import 'package:cleancode_app/core/usecase/usecase.dart';
import 'package:cleancode_app/features/summaries/data/models/item_req_params.dart';
import 'package:cleancode_app/features/summaries/domain/repositories/summary_repository.dart';
import 'package:cleancode_app/service_locator.dart';
import 'package:dartz/dartz.dart';

class DeleteSummaryUsecase implements Usecase<Either, SummaryReqParams>{
  @override
  Future<Either> call({SummaryReqParams? params}) async {
    return sl<SummaryRepository>().deleteItem(params!);
  }
}