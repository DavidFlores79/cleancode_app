import 'package:cleancode_app/features/summaries/data/models/summary_model.dart';
import 'package:cleancode_app/features/summaries/data/models/item_req_params.dart';
import 'package:cleancode_app/features/summaries/domain/usecases/create_summary_usecase.dart';
import 'package:cleancode_app/features/summaries/domain/usecases/delete_summary_usecase.dart';
import 'package:cleancode_app/features/summaries/domain/usecases/update_summary_usecase.dart';
import 'package:cleancode_app/features/summaries/domain/usecases/get_all_summaries_usecase.dart';
import 'package:cleancode_app/features/summaries/domain/usecases/get_one_summary_usecase.dart';
import 'package:cleancode_app/features/summaries/presentation/bloc/summary_event.dart';
import 'package:cleancode_app/features/summaries/presentation/bloc/summary_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SummaryBloc extends Bloc<SummaryEvent, SummaryState> {
  final GetAllSummariesUsecase getAllSummariesUseCase;
  final GetOneSummaryUsecase getOneSummaryUseCase;
  final CreateSummaryUsecase createSummaryUseCase;
  final UpdateSummaryUsecase updateSummaryUseCase;
  final DeleteSummaryUsecase deleteSummaryUseCase;

  SummaryBloc({
    required this.getAllSummariesUseCase,
    required this.getOneSummaryUseCase,
    required this.createSummaryUseCase,
    required this.updateSummaryUseCase,
    required this.deleteSummaryUseCase,
  }) : super(SummaryInitialState()) {
    on<GetAllSummaries>(_onGetAllSummaries);
    on<GetOneSummary>(_onGetOneSummary);
    on<CreateSummary>(_onCreateSummary);
    on<UpdateSummary>(_onUpdateSummary);
    on<DeleteSummary>(_onDeleteSummary);
  }

  void _onGetAllSummaries(
      GetAllSummaries event, Emitter<SummaryState> emit) async {
    emit(SummaryLoadingState());
    final result = await getAllSummariesUseCase();
    result.fold(
      (failure) => emit(SummaryFailureState(failure)),
      (data) {
        debugPrint(data.data['data'].toString());
        final List<SummaryModel> summaries =
            (data.data?['data'] as List<dynamic>)
                .map((json) => SummaryModel.fromMap(json))
                .toList();
        emit(GetAllSummariesSuccessState(summaries));
      },
    );
  }

  void _onGetOneSummary(
      GetOneSummary event, Emitter<SummaryState> emit) async {
    emit(SummaryLoadingState());
    final result = await getOneSummaryUseCase.call(
        params: SummaryReqParams(id: event.itemId));
    result.fold(
      (failure) => emit(SummaryFailureState(failure)),
      (data) {
        emit(
          GetOneSummarySuccessState(
            SummaryModel.fromMap(
              data.data['data'],
            ),
          ),
        );
      },
    );
  }

  void _onCreateSummary(
      CreateSummary event, Emitter<SummaryState> emit) async {
    emit(SummaryLoadingState());
    final result = await createSummaryUseCase.call(
      params: SummaryReqParams(
        id: '',
        title: event.item.title,
        comments: event.item.comments,
        status: event.item.status,
      ),
    );
    result.fold(
      (failure) => emit(SummaryFailureState(failure)),
      (data) {
        emit(CreateSummarySuccessState(SummaryModel.fromMap(
            data.data['data'],
        )));
      }, // Recargar la lista después de crear
    );
  }

  void _onUpdateSummary(
      UpdateSummary event, Emitter<SummaryState> emit) async {
    emit(SummaryLoadingState());
    final result = await updateSummaryUseCase.call(
        params: SummaryReqParams(
      id: event.item.id!,
      title: event.item.title!,
      comments: event.item.comments!,
      status: event.item.status!,
    ));
    result.fold(
      (failure) => emit(SummaryFailureState(failure)),
      (data) {
        emit(UpdateSummarySuccessState(SummaryModel.fromMap(
            data.data['data'],
        )));
      }, // Recargar la lista después de actualizar
    );
  }

  void _onDeleteSummary(
      DeleteSummary event, Emitter<SummaryState> emit) async {
    emit(SummaryLoadingState());
    final result = await deleteSummaryUseCase(params: SummaryReqParams(id: event.itemId));
    result.fold(
      (failure) => emit(SummaryFailureState(failure)),
      (_) {
        emit(DeleteSummarySuccessState());
      }, // Recargar la lista después de eliminar
    );
  }
}
