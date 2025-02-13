import 'package:cleancode_app/core/usecase/usecase.dart';
import 'package:cleancode_app/features/categories/data/models/item_req_params.dart';
import 'package:cleancode_app/features/categories/domain/repositories/category_repository.dart';
import 'package:cleancode_app/service_locator.dart';
import 'package:dartz/dartz.dart';

class GetAllCategoriesUsecase implements Usecase<Either, CategoryReqParams>{
  @override
  Future<Either> call({CategoryReqParams? params}) async {
    return sl<CategoryRepository>().getAllItems();
  }
}