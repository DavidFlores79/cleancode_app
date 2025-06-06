import 'package:cleancode_app/core/usecase/usecase.dart';
import 'package:cleancode_app/features/posters/data/models/item_req_params.dart';
import 'package:cleancode_app/features/posters/domain/repositories/poster_repository.dart';
import 'package:cleancode_app/service_locator.dart';
import 'package:dartz/dartz.dart';

class GetOnePosterUsecase implements Usecase<Either, PosterReqParams>{
  @override
  Future<Either> call({PosterReqParams? query}) async {
    return sl<PosterRepository>().getItem(query!);
  }
}