import 'package:cleancode_app/features/categories/data/models/category_model.dart';
import 'package:cleancode_app/features/categories/domain/usecases/get_all_categories_usecase.dart';
import 'package:cleancode_app/features/categories/presentation/bloc/category_event.dart';
import 'package:cleancode_app/features/categories/presentation/bloc/category_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetAllCategoriesUsecase getAllCategoriesUseCase;

  CategoryBloc({required this.getAllCategoriesUseCase}) : super(CategoryInitialState()) {
    on<GetAllCategories>(_onGetAllCategories);
  }

  void _onGetAllCategories(GetAllCategories event, Emitter<CategoryState> emit) async {
    emit(CategoryLoadingState());
    final result = await getAllCategoriesUseCase();
    result.fold(
      (failure) => emit(CategoryFailureState(failure)),
      (data) {
        debugPrint(data.data['data'].toString());
        final List<CategoryModel> categories = (data.data?['data'] as List<dynamic>)
            .map((json) => CategoryModel.fromMap(json))
            .toList();
        emit(CategorySuccessState(categories));
      },
    );
  }
}