import 'package:cleancode_app/features/summaries/data/models/summary_model.dart';

abstract class SummaryEvent {}

class GetAllSummaries implements SummaryEvent {}
class GetOneSummary implements SummaryEvent {
  final String itemId;
  GetOneSummary(this.itemId);
}
class CreateSummary extends SummaryEvent {
  final SummaryModel item;
  CreateSummary(this.item);
}
class UpdateSummary extends SummaryEvent {
  final SummaryModel item;
  UpdateSummary(this.item);
}
class DeleteSummary extends SummaryEvent {
  final String itemId;
  DeleteSummary(this.itemId);
}