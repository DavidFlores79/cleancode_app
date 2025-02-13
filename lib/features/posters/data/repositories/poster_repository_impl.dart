import 'package:cleancode_app/features/posters/data/datasources/poster_api_service.dart';
import 'package:cleancode_app/features/posters/data/models/item_req_params.dart';
import 'package:cleancode_app/features/posters/domain/repositories/poster_repository.dart';
import 'package:cleancode_app/service_locator.dart';
import 'package:dartz/dartz.dart';

class PosterRepositoryImpl implements PosterRepository {

  @override
  Future<Either> getAllItems() {
    return sl<PosterApiService>().getAllItems();
  }

  @override
  Future<Either> getItem(PosterReqParams params) {
    return sl<PosterApiService>().getItem(params);
  }

    @override
  Future<Either> postItem(PosterReqParams params) {
    return sl<PosterApiService>().postItem(params);
  }

  @override
  Future<Either> updateItem(PosterReqParams params) {
    return sl<PosterApiService>().updateItem(params);
  }

    @override
  Future<Either> deleteItem(PosterReqParams params) {
    return sl<PosterApiService>().deleteItem(params);
  }

}