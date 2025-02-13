import 'package:cleancode_app/core/network/dio_client_sl.dart';
import 'package:cleancode_app/features/home/data/datasources/modules_remote_datasource.dart';
import 'package:cleancode_app/features/home/data/repositories/module_repository_impl.dart';
import 'package:cleancode_app/features/home/domain/repositories/module_repository.dart';
import 'package:cleancode_app/features/home/domain/usecases/get_modules_usecase.dart';
import 'package:cleancode_app/features/posters/data/datasources/poster_api_service.dart';
import 'package:cleancode_app/features/posters/data/repositories/poster_repository_impl.dart';
import 'package:cleancode_app/features/posters/domain/repositories/poster_repository.dart';
import 'package:cleancode_app/features/posters/domain/usecases/delete_poster_usecase.dart';
import 'package:cleancode_app/features/posters/domain/usecases/get_all_posters_usecase.dart';
import 'package:cleancode_app/features/posters/domain/usecases/get_one_poster_usecase.dart';
import 'package:cleancode_app/features/posters/domain/usecases/post_poster_usecase.dart';
import 'package:cleancode_app/features/posters/domain/usecases/update_poster_usecase.dart';
import 'package:cleancode_app/features/products/domain/usecases/get_product_usecase.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerSingleton<DioClient>(DioClient());


  //Services
  sl.registerSingleton<ModulesRemoteDataSource>(
    ModulesRemoteDataSourceImpl()
  );

  sl.registerSingleton<PosterApiService>(
    PosterApiServiceImpl()
  );

  // Repositories
  sl.registerSingleton<ModuleRepository>(
    ModuleRepositoryImpl()
  );

  sl.registerSingleton<PosterRepository>(
    PosterRepositoryImpl()
  );

  //UseCases
  sl.registerSingleton<GetModulesUsecase>(
    GetModulesUsecase()
  );
  sl.registerSingleton<GetProductUsecase>(
    GetProductUsecase()
  );
  sl.registerSingleton<GetAllPostersUsecase>(
    GetAllPostersUsecase()
  );
  sl.registerSingleton<GetOnePosterUsecase>(
    GetOnePosterUsecase()
  );
  sl.registerSingleton<PostPosterUsecase>(
    PostPosterUsecase()
  );
  sl.registerSingleton<UpdatePosterUsecase>(
    UpdatePosterUsecase()
  );
  sl.registerSingleton<DeletePosterUsecase>(
    DeletePosterUsecase()
  );
}