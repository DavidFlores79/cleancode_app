import 'package:cleancode_app/features/posters/data/models/poster_model.dart';
import 'package:cleancode_app/features/posters/domain/usecases/get_all_posters_usecase.dart';
import 'package:cleancode_app/features/posters/presentation/bloc/poster_event.dart';
import 'package:cleancode_app/features/posters/presentation/bloc/poster_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PosterBloc extends Bloc<PosterEvent, PosterState> {
  final GetAllPostersUsecase getAllPostersUseCase;

  PosterBloc({required this.getAllPostersUseCase}) : super(PosterInitialState()) {
    on<GetAllPosters>(_onGetAllPosters);
  }

  void _onGetAllPosters(GetAllPosters event, Emitter<PosterState> emit) async {
    emit(PosterLoadingState());
    final result = await getAllPostersUseCase();
    result.fold(
      (failure) => emit(PosterFailureState(failure.message)),
      (data) {
        debugPrint(data.data['data'].toString());
        final List<PosterModel> posters = (data.data['data'] as List<dynamic>)
            .map((json) => PosterModel.fromMap(json))
            .toList();
        emit(PosterSuccessState(posters));
      },
    );
  }
}