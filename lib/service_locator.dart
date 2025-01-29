import 'package:cleancode_app/core/network/dio_client_sl.dart';
import 'package:cleancode_app/features/home/data/datasources/modules_remote_datasource.dart';
import 'package:cleancode_app/features/home/data/repositories/module_repository_impl.dart';
import 'package:cleancode_app/features/home/domain/repositories/module_repository.dart';
import 'package:cleancode_app/features/home/domain/usecases/get_modules_usecase.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerSingleton<DioClient>(DioClient());


  //Services
  sl.registerSingleton<ModulesRemoteDataSource>(
    ModulesRemoteDataSourceImpl()
  );

  // Repositories
  sl.registerSingleton<ModuleRepository>(
    ModuleRepositoryImpl()
  );

  //UseCases
  sl.registerSingleton<GetModulesUsecase>(
    GetModulesUsecase()
  );
}