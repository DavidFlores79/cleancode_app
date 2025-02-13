import 'package:cleancode_app/core/utils/app_utils.dart';
import 'package:cleancode_app/features/products/data/models/product_req_params.dart';
import 'package:cleancode_app/features/products/domain/usecases/get_product_usecase.dart';
import 'package:cleancode_app/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleancode_app/features/products/presentation/bloc/product_bloc.dart';
import 'package:cleancode_app/features/products/presentation/bloc/product_event.dart';
import 'package:cleancode_app/features/products/presentation/bloc/product_state.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
   @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(FetchProducts());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posters')),
      body: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is ProductFailure) {
            AppUtils.showSnackBar(context, state.message);
          }
        },
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductSuccess) {
              return ListView.builder(
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  return ListTile(
                    onTap: () {
                      sl<GetProductUsecase>().call(
                        params: ProductReqParams(id: product.id!)
                      );
                    },
                    title: Text(product.name ?? ''),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${product.code}'),
                        Text('${product.authors}'),
                      ],
                    ),
                  );
                },
              );
            }
            return const Center(child: Text('No se cargaron productos'));
          },
        ),
      ),
    );
  }
}