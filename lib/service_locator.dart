import 'package:cleancode_app/core/network/dio_client_sl.dart';
import 'package:cleancode_app/features/categories/data/datasources/category_api_service.dart';
import 'package:cleancode_app/features/categories/data/repositories/category_repository_impl.dart';
import 'package:cleancode_app/features/categories/domain/repositories/category_repository.dart';
import 'package:cleancode_app/features/categories/domain/usecases/delete_category_usecase.dart';
import 'package:cleancode_app/features/categories/domain/usecases/get_all_categories_usecase.dart';
import 'package:cleancode_app/features/categories/domain/usecases/get_one_category_usecase.dart';
import 'package:cleancode_app/features/categories/domain/usecases/create_category_usecase.dart';
import 'package:cleancode_app/features/categories/domain/usecases/update_category_usecase.dart';
import 'package:cleancode_app/features/home/data/datasources/modules_remote_datasource.dart';
import 'package:cleancode_app/features/home/data/repositories/module_repository_impl.dart';
import 'package:cleancode_app/features/home/domain/repositories/module_repository.dart';
import 'package:cleancode_app/features/home/domain/usecases/get_modules_usecase.dart';
import 'package:cleancode_app/features/payment_methods/data/datasources/payment_methods_api_service.dart';
import 'package:cleancode_app/features/payment_methods/data/repositories/payment_method_repository_impl.dart';
import 'package:cleancode_app/features/payment_methods/domain/repositories/payment_method_repository.dart';
import 'package:cleancode_app/features/payment_methods/domain/usecases/create_payment_method_usecase.dart';
import 'package:cleancode_app/features/payment_methods/domain/usecases/delete_payment_method_usecase.dart';
import 'package:cleancode_app/features/payment_methods/domain/usecases/get_all_payment_methods_usecase.dart';
import 'package:cleancode_app/features/payment_methods/domain/usecases/get_one_payment_method_usecase.dart';
import 'package:cleancode_app/features/payment_methods/domain/usecases/update_payment_method_usecase.dart';
import 'package:cleancode_app/features/payments/data/datasources/payments_api_service.dart';
import 'package:cleancode_app/features/payments/data/repositories/payment_repository_impl.dart';
import 'package:cleancode_app/features/payments/domain/repositories/payment_repository.dart';
import 'package:cleancode_app/features/payments/domain/usecases/create_payment_usecase.dart';
import 'package:cleancode_app/features/payments/domain/usecases/delete_payment_usecase.dart';
import 'package:cleancode_app/features/payments/domain/usecases/get_all_payments_usecase.dart';
import 'package:cleancode_app/features/payments/domain/usecases/get_one_payment_usecase.dart';
import 'package:cleancode_app/features/payments/domain/usecases/update_payment_usecase.dart';
import 'package:cleancode_app/features/posters/data/datasources/poster_api_service.dart';
import 'package:cleancode_app/features/posters/data/repositories/poster_repository_impl.dart';
import 'package:cleancode_app/features/posters/domain/repositories/poster_repository.dart';
import 'package:cleancode_app/features/posters/domain/usecases/delete_poster_usecase.dart';
import 'package:cleancode_app/features/posters/domain/usecases/get_all_posters_usecase.dart';
import 'package:cleancode_app/features/posters/domain/usecases/get_one_poster_usecase.dart';
import 'package:cleancode_app/features/posters/domain/usecases/post_poster_usecase.dart';
import 'package:cleancode_app/features/posters/domain/usecases/update_poster_usecase.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerSingleton<DioClient>(DioClient());


  // ========= Services =========
  sl.registerSingleton<ModulesRemoteDataSource>(
    ModulesRemoteDataSourceImpl()
  );

  sl.registerSingleton<PosterApiService>(
    PosterApiServiceImpl()
  );
  sl.registerSingleton<CategoryApiService>(
    CategoryApiServiceImpl()
  );
  sl.registerSingleton<PaymentMethodApiService>(
    PaymentMethodApiServiceImpl()
  );
  sl.registerSingleton<PaymentApiService>(
    PaymentApiServiceImpl()
  );

  // ========= Repositories ========
  sl.registerSingleton<ModuleRepository>(
    ModuleRepositoryImpl()
  );

  sl.registerSingleton<PosterRepository>(
    PosterRepositoryImpl()
  );

  sl.registerSingleton<CategoryRepository>(
    CategoryRepositoryImpl()
  );
  sl.registerSingleton<PaymentMethodRepository>(
    PaymentMethodRepositoryImpl()
  );
  sl.registerSingleton<PaymentRepository>(
    PaymentRepositoryImpl()
  );

  // =======  UseCases ========
  sl.registerSingleton<GetModulesUsecase>(
    GetModulesUsecase()
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
  //Categories
  sl.registerSingleton<GetAllCategoriesUsecase>(
    GetAllCategoriesUsecase()
  );
  sl.registerSingleton<GetOneCategoryUsecase>(
    GetOneCategoryUsecase()
  );
  sl.registerSingleton<CreateCategoryUsecase>(
    CreateCategoryUsecase()
  );
  sl.registerSingleton<UpdateCategoryUsecase>(
    UpdateCategoryUsecase()
  );
  sl.registerSingleton<DeleteCategoryUsecase>(
    DeleteCategoryUsecase()
  );
  //Payments
  sl.registerSingleton<GetAllPaymentsUsecase>(
    GetAllPaymentsUsecase()
  );
  sl.registerSingleton<GetOnePaymentUsecase>(
    GetOnePaymentUsecase()
  );
  sl.registerSingleton<CreatePaymentUsecase>(
    CreatePaymentUsecase()
  );
  sl.registerSingleton<UpdatePaymentUsecase>(
    UpdatePaymentUsecase()
  );
  sl.registerSingleton<DeletePaymentUsecase>(
    DeletePaymentUsecase()
  );
  //Payment Methods
  sl.registerSingleton<GetAllPaymentMethodsUsecase>(
    GetAllPaymentMethodsUsecase()
  );
  sl.registerSingleton<GetOnePaymentMethodUsecase>(
    GetOnePaymentMethodUsecase()
  );
  sl.registerSingleton<CreatePaymentMethodUsecase>(
    CreatePaymentMethodUsecase()
  );
  sl.registerSingleton<UpdatePaymentMethodUsecase>(
    UpdatePaymentMethodUsecase()
  );
  sl.registerSingleton<DeletePaymentMethodUsecase>(
    DeletePaymentMethodUsecase()
  );
}