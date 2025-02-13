import 'package:cleancode_app/features/categories/data/models/category_model.dart';

abstract class CategoryState {}

class CategoryInitialState implements CategoryState {}
class CategoryLoadingState implements CategoryState {}
class GetAllCategoriesSuccessState implements CategoryState {
  final List<CategoryModel> items;
  GetAllCategoriesSuccessState(this.items);
}
class GetOneCategorySuccessState implements CategoryState {
  final CategoryModel item;
  GetOneCategorySuccessState(this.item);
}
class CategoryFailureState implements CategoryState {
  final String message;
  CategoryFailureState(this.message);
}

class ForbiddenActionState extends CategoryState {
  final String message;

  ForbiddenActionState(this.message);
}