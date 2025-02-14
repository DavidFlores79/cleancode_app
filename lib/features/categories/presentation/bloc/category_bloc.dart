import 'package:cleancode_app/features/categories/data/models/category_model.dart';
import 'package:cleancode_app/features/categories/data/models/item_req_params.dart';
import 'package:cleancode_app/features/categories/domain/usecases/create_category_usecase.dart';
import 'package:cleancode_app/features/categories/domain/usecases/delete_category_usecase.dart';
import 'package:cleancode_app/features/categories/domain/usecases/update_category_usecase.dart';
import 'package:cleancode_app/features/categories/domain/usecases/get_all_categories_usecase.dart';
import 'package:cleancode_app/features/categories/domain/usecases/get_one_category_usecase.dart';
import 'package:cleancode_app/features/categories/presentation/bloc/category_event.dart';
import 'package:cleancode_app/features/categories/presentation/bloc/category_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetAllCategoriesUsecase getAllCategoriesUseCase;
  final GetOneCategoryUsecase getOneCategoryUseCase;
  final CreateCategoryUsecase createCategoryUseCase;
  final UpdateCategoryUsecase updateCategoryUseCase;
  final DeleteCategoryUsecase deleteCategoryUseCase;

  CategoryBloc({
    required this.getAllCategoriesUseCase,
    required this.getOneCategoryUseCase,
    required this.createCategoryUseCase,
    required this.updateCategoryUseCase,
    required this.deleteCategoryUseCase,
  }) : super(CategoryInitialState()) {
    on<GetAllCategories>(_onGetAllCategories);
    on<GetOneCategory>(_onGetOneCategory);
    on<CreateCategory>(_onCreateCategory);
    on<UpdateCategory>(_onUpdateCategory);
    on<DeleteCategory>(_onDeleteCategory);
  }

  void _onGetAllCategories(
      GetAllCategories event, Emitter<CategoryState> emit) async {
    emit(CategoryLoadingState());
    final result = await getAllCategoriesUseCase();
    result.fold(
      (failure) => emit(CategoryFailureState(failure)),
      (data) {
        debugPrint(data.data['data'].toString());
        final List<CategoryModel> categories =
            (data.data?['data'] as List<dynamic>)
                .map((json) => CategoryModel.fromMap(json))
                .toList();
        emit(GetAllCategoriesSuccessState(categories));
      },
    );
  }

  void _onGetOneCategory(
      GetOneCategory event, Emitter<CategoryState> emit) async {
    emit(CategoryLoadingState());
    final result = await getOneCategoryUseCase.call(
        params: CategoryReqParams(id: event.itemId));
    result.fold(
      (failure) => emit(CategoryFailureState(failure)),
      (data) {
        emit(
          GetOneCategorySuccessState(
            CategoryModel.fromMap(
              data.data['data'],
            ),
          ),
        );
      },
    );
  }

  void _onCreateCategory(
      CreateCategory event, Emitter<CategoryState> emit) async {
    // emit(CategoryLoadingState());
    final result = await createCategoryUseCase.call(
      params: CategoryReqParams(
        id: '',
        name: event.item.name,
        status: event.item.status,
      ),
    );
    result.fold(
      (failure) => emit(CategoryFailureState(failure)),
      (data) {
        emit(CreateCategorySuccessState(CategoryModel.fromMap(
            data.data['data'],
        )));
      }, // Recargar la lista después de crear
    );
  }

  void _onUpdateCategory(
      UpdateCategory event, Emitter<CategoryState> emit) async {
    // emit(CategoryLoadingState());
    final result = await updateCategoryUseCase.call(
        params: CategoryReqParams(
      id: event.item.id!,
      name: event.item.name!,
      status: event.item.status!,
    ));
    result.fold(
      (failure) => emit(CategoryFailureState(failure)),
      (data) {
        emit(UpdateCategorySuccessState(CategoryModel.fromMap(
            data.data['data'],
        )));
      }, // Recargar la lista después de actualizar
    );
  }

  void _onDeleteCategory(
      DeleteCategory event, Emitter<CategoryState> emit) async {
    emit(CategoryLoadingState());
    final result = await deleteCategoryUseCase();
    result.fold(
      (failure) => emit(CategoryFailureState(failure)),
      (_) => add(GetAllCategories()), // Recargar la lista después de eliminar
    );
  }
}
