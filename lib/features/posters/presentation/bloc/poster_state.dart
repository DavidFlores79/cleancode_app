import 'package:cleancode_app/features/posters/domain/entities/poster.dart';

abstract class PosterState {}

class PosterInitialState implements PosterState {}
class PosterLoadingState implements PosterState {}
class PosterSuccessState implements PosterState {
  final List<Poster> items;
  PosterSuccessState(this.items);
}
class PosterFailureState implements PosterState {
  final String message;
  PosterFailureState(this.message);
}