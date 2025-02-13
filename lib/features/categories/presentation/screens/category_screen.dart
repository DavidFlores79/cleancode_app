import 'package:cleancode_app/core/constants/app_messages.dart';
import 'package:cleancode_app/core/utils/app_utils.dart';
import 'package:cleancode_app/core/widgets/not_found.dart';
import 'package:cleancode_app/features/categories/data/models/item_req_params.dart';
import 'package:cleancode_app/features/categories/domain/usecases/get_all_categories_usecase.dart';
import 'package:cleancode_app/features/categories/presentation/bloc/category_bloc.dart';
import 'package:cleancode_app/features/categories/presentation/bloc/category_event.dart';
import 'package:cleancode_app/features/categories/presentation/bloc/category_state.dart';
import 'package:cleancode_app/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
   @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(GetAllCategories());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categories')),
      body: BlocListener<CategoryBloc, CategoryState>(
        listener: (context, state) {
          if (state is CategoryFailureState) {
            AppUtils.showSnackBar(context, state.message);
          }
        },
        child: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state is CategoryLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CategorySuccessState) {
              return ListView.builder(
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  final item = state.items[index];
                  return ListTile(
                    onTap: () {
                      sl<GetAllCategoriesUsecase>().call(
                        params: CategoryReqParams(id: item.id!)
                      );
                    },
                    title: Text(item.name ?? ''),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${item.name}'),
                        Text((item.status == true) ? 'Activo':'Inactivo'),
                      ],
                    ),
                  );
                },
              );
            }
            return Center(child: NotFound(message: AppMessages.unloadedRecords,));
          },
        ),
      ),
    );
  }
}