import 'dart:async';
import 'dart:io';
import 'package:cleancode_app/core/constants/app_constants.dart';
import 'package:cleancode_app/core/network/dio_client_sl.dart';
import 'package:cleancode_app/core/utils/app_utils.dart';
import 'package:cleancode_app/features/posters/data/models/poster_model.dart';
import 'package:cleancode_app/features/posters/presentation/bloc/poster_bloc.dart';
import 'package:cleancode_app/features/posters/presentation/bloc/poster_event.dart';
import 'package:cleancode_app/features/posters/presentation/bloc/poster_state.dart';
import 'package:cleancode_app/features/posters/presentation/widgets/custom_audio_player.dart';
import 'package:cleancode_app/service_locator.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:path_provider/path_provider.dart';

class PosterScreen extends StatefulWidget {
  const PosterScreen({super.key});

  @override
  State<PosterScreen> createState() => _PosterScreenState();
}

class _PosterScreenState extends State<PosterScreen> {
  List<PosterModel> items = [];

  @override
  void initState() {
    super.initState();
    context.read<PosterBloc>().add(GetAllPosters());
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      overlayColor: Theme.of(context).cardColor.withOpacity(0.8),
      overlayWidgetBuilder: (_) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
      child: MultiBlocListener(
        listeners: [
          BlocListener<PosterBloc, PosterState>(
            listener: (context, state) {
              if (state is PosterLoadingState) {
                context.loaderOverlay.show();
              }

              if (state is PosterFailureState) {
                context.loaderOverlay.hide();
                AppUtils.showSnackBar(context, state.message);
              }

              if (state is PosterSuccessState) {
                setState(() {
                  items = state.items;
                  context.loaderOverlay.hide();
                });
              }
            },
          ),
        ],
        child: Scaffold(
          appBar: AppBar(title: const Text('Posters'), centerTitle: true),
          body: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return ListTile(
                onTap: () => showFullScreenModal(context, item),
                title: Text(item.name ?? ''),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${item.code}',
                    ),
                    Text(
                      '${item.authors}',
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

Future<void> showFullScreenModal(BuildContext context, PosterModel item) async {
  showModalBottomSheet(
    context: context,
    sheetAnimationStyle: AnimationStyle(duration: Duration(seconds: 1)),
    isScrollControlled: true,
    useRootNavigator: true, // Asegura que el Navigator raíz maneje el modal
    backgroundColor: AppConstants.lightGrey,
    builder: (BuildContext context) {
      return GestureDetector(
        onTap: () {}, // Esto evita que los gestos se cierren accidentalmente
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          child: FullScreenModalContent(item: item),
        ),
      );
    },
  );
}

class FullScreenModalContent extends StatefulWidget {
  final PosterModel item;
  const FullScreenModalContent({super.key, required this.item});

  @override
  State<FullScreenModalContent> createState() => _FullScreenModalContentState();
}

class _FullScreenModalContentState extends State<FullScreenModalContent> {
  final Completer<PDFViewController> controller =
      Completer<PDFViewController>();
  bool isReady = false;
  int? totalPages = 0;
  int? currentPage = 0;
  String? localFilePdfPath; // Ruta local del archivo descargado
  bool isLoading = true;

  @override
  void initState() {
    _downloadPDFFile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (isLoading)
        ? Center(
            child: CircularProgressIndicator(), // Mostrar un indicador de carga
          )
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (localFilePdfPath != null)
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.60,
                      child: PDFView(
                        filePath: localFilePdfPath,
                        enableSwipe: true,
                        swipeHorizontal: true,
                        autoSpacing: false,
                        pageFling: false,
                        backgroundColor: AppConstants.transparent,
                        onRender: (pages) {
                          setState(() {
                            totalPages = pages;
                            isReady = true;
                          });
                        },
                        onError: (error) {
                          debugPrint(error.toString());
                          AppUtils.showSnackBar(context, error.toString());
                        },
                        onPageError: (page, error) {
                          debugPrint(error.toString());
                          AppUtils.showSnackBar(context, error.toString());
                        },
                        onViewCreated: (PDFViewController pdfViewController) {
                          controller.complete(pdfViewController);
                        },
                        onPageChanged: (page, total) {
                          debugPrint('page change: $page/$total');
                        },
                      ),
                    ),
                  const SizedBox(height: 15),
                  CustomAudioPlayer(audioUrl: widget.item.audio!)
                ],
              ),
            ),
          );
  }

  Future<void> _downloadPDFFile() async {
    try {
      // Obtener el directorio temporal del dispositivo
      final directory = await getTemporaryDirectory();
      final filePath = '${directory.path}/temp.pdf';

      // Descargar el archivo desde la URL
      final response = await sl<DioClient>().get(widget.item.image!,
          options: Options(
              responseType:
                  ResponseType.bytes)); // Indicar que esperamos bytes);
      final file = File(filePath);

      // Guardar el archivo en el dispositivo
      await file.writeAsBytes(response.data);

      // Actualizar el estado con la ruta local
      setState(() {
        isLoading = false;
        localFilePdfPath = filePath;
      });
    } catch (e) {
      AppUtils.showSnackBar(context, 'Error al descargar el archivo: $e');
      setState(() {
        isLoading = false;
      });
    }
  }
}
