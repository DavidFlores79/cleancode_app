import 'package:cleancode_app/features/summaries/data/datasources/summaries_api_service.dart';
import 'package:cleancode_app/features/summaries/data/models/item_req_params.dart';
import 'package:cleancode_app/features/summaries/domain/repositories/summary_repository.dart';
import 'package:cleancode_app/service_locator.dart';
import 'package:dartz/dartz.dart';

class SummaryRepositoryImpl implements SummaryRepository {

  @override
  Future<Either> getAllItems() {
    return sl<SummaryApiService>().getAllItems();
  }

  @override
  Future<Either> getItem(SummaryReqParams params) {
    return sl<SummaryApiService>().getItem(params);
  }

    @override
  Future<Either> postItem(SummaryReqParams params) {
    return sl<SummaryApiService>().postItem(params);
  }

  @override
  Future<Either> updateItem(SummaryReqParams params) {
    return sl<SummaryApiService>().updateItem(params);
  }

    @override
  Future<Either> deleteItem(SummaryReqParams params) {
    return sl<SummaryApiService>().deleteItem(params);
  }

}