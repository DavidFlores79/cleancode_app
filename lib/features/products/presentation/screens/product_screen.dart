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
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductSuccess) {
            return ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = state.products[index];
                return ListTile(
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
          } else if (state is ProductFailure) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: Text('No se cargaron productos'));
        },
      ),
    );
  }
}