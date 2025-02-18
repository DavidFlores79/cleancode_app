import 'package:cleancode_app/core/constants/app_constants.dart';
import 'package:cleancode_app/core/utils/app_utils.dart';
import 'package:cleancode_app/core/widgets/custom_listtile.dart';
import 'package:cleancode_app/core/widgets/not_found.dart';
import 'package:cleancode_app/features/summaries/data/models/summary_model.dart';
import 'package:cleancode_app/features/summaries/presentation/bloc/summary_bloc.dart';
import 'package:cleancode_app/features/summaries/presentation/bloc/summary_event.dart';
import 'package:cleancode_app/features/summaries/presentation/bloc/summary_state.dart';
import 'package:cleancode_app/features/summaries/presentation/widgets/create_form.dart';
import 'package:cleancode_app/features/summaries/presentation/widgets/update_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  SummaryModel item = SummaryModel();
  List<SummaryModel> items = [];
  bool isDeleted = false;

  @override
  void initState() {
    super.initState();
    context.read<SummaryBloc>().add(GetAllSummaries());
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      overlayColor: Theme.of(context).cardColor.withOpacity(0.6),
      overlayWidgetBuilder: (_) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
      child: MultiBlocListener(
        listeners: [
          BlocListener<SummaryBloc, SummaryState>(
            listener: (context, state) {
              if (state is SummaryLoadingState) {
                context.loaderOverlay.show();
              }

              if (state is SummaryFailureState) {
                context.loaderOverlay.hide();
                AppUtils.showSnackBar(context, state.message);
              }

              if (state is GetAllSummariesSuccessState) {
                setState(() {
                  items = state.items;
                  context.loaderOverlay.hide();
                });
              }
              if (state is GetOneSummarySuccessState) {
                setState(() {
                  context.loaderOverlay.hide();
                });
              }
              if (state is UpdateSummarySuccessState) {
                setState(() {
                  context.loaderOverlay.hide();
                  int index =
                      items.indexWhere((item) => item.id == state.item.id);
                  if (index != -1) items[index] = state.item;
                });
              }
              if (state is CreateSummarySuccessState) {
                setState(() {
                  context.loaderOverlay.hide();
                  items.add(state.item);
                });
              }
              if (state is DeleteSummarySuccessState) {
                setState(() {
                  context.loaderOverlay.hide();
                  isDeleted = true;
                  context.read<SummaryBloc>().add(GetAllSummaries());
                });
              }
            },
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Resúmenes'), 
            centerTitle: true, 
            actions: [
              IconButton(onPressed:() => showCreateModal(context), icon: Icon(Icons.add_rounded))
            ],
          ),
          body: items.isNotEmpty || !context.loaderOverlay.visible
              ? ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return CustomListTile(
                      status: item.status ?? false,
                      onTap: () => showUpdateModal(context, item),
                      title: Text(item.title ?? ''),
                      subtitle: Text(item.owner.name ?? ''),
                      itemId: item.id!,
                      onDelete:(context) {
                        debugPrint("Item: ${item.id}");
                        context.read<SummaryBloc>().add(DeleteSummary(item.id!));
                      },
                      onDismissed: () => items.removeWhere((element) => element.id == item.id),
                      confirmDismiss: () async {
                        context.read<SummaryBloc>().add(DeleteSummary(item.id!));
                        await Future.delayed(Duration(seconds: AppConstants.deleteSecondsDelay));
                        return isDeleted;
                      },
                    );
                  },
                )
              : NotFound(),
        ),
      ),
    );
  }
}

Future<void> showUpdateModal(BuildContext context, SummaryModel item) async {
  // context.read<SummaryBloc>().add(GetOneSummary(item.id!));

  showModalBottomSheet(
    context: context,
    sheetAnimationStyle: AnimationStyle(duration: Duration(seconds: 1)),
    isScrollControlled: true,
    useRootNavigator: true, // Asegura que el Navigator raíz maneje el modal
    // backgroundColor: AppConstants.lightGrey,
    builder: (BuildContext context) {
      return GestureDetector(
        onTap: () {}, // Esto evita que los gestos se cierren accidentalmente
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          child: SimpleUpdateForm(item: item,),
        ),
      );
    },
  );
}

Future<void> showCreateModal(BuildContext context) async {
  showModalBottomSheet(
    context: context,
    sheetAnimationStyle: AnimationStyle(duration: Duration(seconds: 1)),
    isScrollControlled: true,
    useRootNavigator: true, // Asegura que el Navigator raíz maneje el modal
    // backgroundColor: AppConstants.lightGrey,
    builder: (BuildContext context) {
      return GestureDetector(
        onTap: () {}, // Esto evita que los gestos se cierren accidentalmente
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          child: SimpleCreateForm(),
        ),
      );
    },
  );
}
