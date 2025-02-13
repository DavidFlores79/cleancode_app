import 'package:cleancode_app/features/categories/data/models/category_model.dart';

abstract class CategoryEvent {}

class GetAllCategories implements CategoryEvent {}
class GetOneCategory implements CategoryEvent {
  final String itemId;
  GetOneCategory(this.itemId);
}
class CreateCategory extends CategoryEvent {
  final CategoryModel item;
  CreateCategory(this.item);
}
class UpdateCategory extends CategoryEvent {
  final CategoryModel item;
  UpdateCategory(this.item);
}
class DeleteCategory extends CategoryEvent {
  final String itemId;
  DeleteCategory(this.itemId);
}