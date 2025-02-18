abstract class Usecase<Type, Param> {
  Future<Type> call({Param query});
}