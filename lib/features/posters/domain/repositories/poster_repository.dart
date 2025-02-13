import 'package:cleancode_app/features/posters/data/models/item_req_params.dart';
import 'package:dartz/dartz.dart';

abstract class PosterRepository {
  Future<Either> getAllItems();
  Future<Either> getItem(PosterReqParams params);
  Future<Either> postItem(PosterReqParams params);
  Future<Either> updateItem(PosterReqParams params);
  Future<Either> deleteItem(PosterReqParams params);
}