abstract class CategoryEvent {}

class GetAllCategories implements CategoryEvent {}
class GetOneCategory implements CategoryEvent {}
class PostCategory implements CategoryEvent {}
class UpdateCategory implements CategoryEvent {}
class DeleteCategory implements CategoryEvent {}