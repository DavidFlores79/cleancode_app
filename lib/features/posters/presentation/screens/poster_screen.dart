import 'package:cleancode_app/core/constants/app_messages.dart';
import 'package:cleancode_app/core/utils/app_utils.dart';
import 'package:cleancode_app/features/posters/data/models/item_req_params.dart';
import 'package:cleancode_app/features/posters/domain/usecases/get_all_posters_usecase.dart';
import 'package:cleancode_app/features/posters/presentation/bloc/poster_bloc.dart';
import 'package:cleancode_app/features/posters/presentation/bloc/poster_event.dart';
import 'package:cleancode_app/features/posters/presentation/bloc/poster_state.dart';
import 'package:cleancode_app/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PosterScreen extends StatefulWidget {
  const PosterScreen({super.key});

  @override
  State<PosterScreen> createState() => _PosterScreenState();
}

class _PosterScreenState extends State<PosterScreen> {
   @override
  void initState() {
    super.initState();
    context.read<PosterBloc>().add(GetAllPosters());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posters')),
      body: BlocListener<PosterBloc, PosterState>(
        listener: (context, state) {
          if (state is PosterFailureState) {
            AppUtils.showSnackBar(context, state.message);
          }
        },
        child: BlocBuilder<PosterBloc, PosterState>(
          builder: (context, state) {
            if (state is PosterLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PosterSuccessState) {
              return ListView.builder(
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  final item = state.items[index];
                  return ListTile(
                    onTap: () {
                      sl<GetAllPostersUsecase>().call(
                        params: PosterReqParams(id: item.id!)
                      );
                    },
                    title: Text(item.name ?? ''),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${item.code}'),
                        Text('${item.authors}'),
                      ],
                    ),
                  );
                },
              );
            }
            return const Center(child: Text(AppMessages.unloadedRecords));
          },
        ),
      ),
    );
  }
}