abstract class PosterEvent {}

class GetAllPosters implements PosterEvent {}
class GetOnePoster implements PosterEvent {}
class PostPoster implements PosterEvent {}
class UpdatePoster implements PosterEvent {}
class DeletePoster implements PosterEvent {}