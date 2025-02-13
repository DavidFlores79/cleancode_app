import 'package:cleancode_app/features/posters/data/models/poster_model.dart';

abstract class PosterState {}

class PosterInitialState implements PosterState {}
class PosterLoadingState implements PosterState {}
class PosterSuccessState implements PosterState {
  final List<PosterModel> items;
  PosterSuccessState(this.items);
}
class PosterFailureState implements PosterState {
  final String message;
  PosterFailureState(this.message);
}