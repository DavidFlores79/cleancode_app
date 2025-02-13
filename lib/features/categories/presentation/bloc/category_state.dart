import 'package:cleancode_app/features/categories/data/models/category_model.dart';

abstract class CategoryState {}

class CategoryInitialState implements CategoryState {}
class CategoryLoadingState implements CategoryState {}
class CategorySuccessState implements CategoryState {
  final List<CategoryModel> items;
  CategorySuccessState(this.items);
}
class CategoryFailureState implements CategoryState {
  final String message;
  CategoryFailureState(this.message);
}

class ForbiddenActionState extends CategoryState {
  final String message;

  ForbiddenActionState(this.message);
}