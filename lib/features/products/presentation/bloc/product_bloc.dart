import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleancode_app/features/products/domain/usecases/get_products_usecase.dart';
import 'package:cleancode_app/features/products/presentation/bloc/product_event.dart';
import 'package:cleancode_app/features/products/presentation/bloc/product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductsUseCase getProductsUseCase;

  ProductBloc({required this.getProductsUseCase}) : super(ProductInitial()) {
    on<FetchProducts>(_onFetchProducts);
  }

  void _onFetchProducts(FetchProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    final result = await getProductsUseCase();
    result.fold(
      (failure) => emit(ProductFailure(failure.message)),
      (products) => emit(ProductSuccess(products)),
    );
  }
}