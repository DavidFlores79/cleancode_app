import 'package:cleancode_app/features/summaries/data/models/item_req_params.dart';
import 'package:dartz/dartz.dart';

abstract class SummaryRepository {
  Future<Either> getAllItems();
  Future<Either> getItem(SummaryReqParams params);
  Future<Either> postItem(SummaryReqParams params);
  Future<Either> updateItem(SummaryReqParams params);
  Future<Either> deleteItem(SummaryReqParams params);
}