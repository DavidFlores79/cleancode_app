import 'package:cleancode_app/features/summaries/data/models/summary_model.dart';

abstract class SummaryState {}

class SummaryInitialState implements SummaryState {}
class SummaryLoadingState implements SummaryState {}
class GetAllSummariesSuccessState implements SummaryState {
  final List<SummaryModel> items;
  GetAllSummariesSuccessState(this.items);
}
class GetOneSummarySuccessState implements SummaryState {
  final SummaryModel item;
  GetOneSummarySuccessState(this.item);
}
class UpdateSummarySuccessState implements SummaryState {
  final SummaryModel item;
  UpdateSummarySuccessState(this.item);
}
class CreateSummarySuccessState implements SummaryState {
  final SummaryModel item;
  CreateSummarySuccessState(this.item);
}
class DeleteSummarySuccessState implements SummaryState {}
class SummaryFailureState implements SummaryState {
  final String message;
  SummaryFailureState(this.message);
}

class ForbiddenActionState extends SummaryState {
  final String message;

  ForbiddenActionState(this.message);
}