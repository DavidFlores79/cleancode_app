import 'package:cleancode_app/core/constants/app_constants.dart';
import 'package:cleancode_app/core/constants/app_messages.dart';
import 'package:cleancode_app/core/utils/app_utils.dart';
import 'package:cleancode_app/core/widgets/custom_button.dart';
import 'package:cleancode_app/core/widgets/custom_input_field.dart';
import 'package:cleancode_app/core/widgets/custom_listtile.dart';
import 'package:cleancode_app/core/widgets/not_found.dart';
import 'package:cleancode_app/features/categories/data/models/category_model.dart';
import 'package:cleancode_app/features/categories/presentation/bloc/category_bloc.dart';
import 'package:cleancode_app/features/categories/presentation/bloc/category_event.dart';
import 'package:cleancode_app/features/categories/presentation/bloc/category_state.dart';
import 'package:cleancode_app/features/categories/presentation/widgets/update_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  CategoryModel item = CategoryModel();
  List<CategoryModel> items = [];

  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(GetAllCategories());
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      overlayColor: Theme.of(context).cardColor,
      overlayWidgetBuilder: (_) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
      child: MultiBlocListener(
        listeners: [
          BlocListener<CategoryBloc, CategoryState>(
            listener: (context, state) {
              if (state is CategoryLoadingState) {
                context.loaderOverlay.show();
              }

              if (state is CategoryFailureState) {
                context.loaderOverlay.hide();
                AppUtils.showSnackBar(context, state.message);
              }

              if (state is GetAllCategoriesSuccessState) {
                setState(() {
                  items = state.items;
                  context.loaderOverlay.hide();
                });
              }
            },
          ),
          BlocListener<CategoryBloc, CategoryState>(
            listener: (context, state) {
              if (state is GetOneCategorySuccessState) {
                setState(() {
                  context.loaderOverlay.hide();
                });
              }
              if (state is UpdateCategorySuccessState) {
                setState(() {
                  context.loaderOverlay.hide();
                  int index =
                      items.indexWhere((item) => item.id == state.item.id);
                  if (index != -1) items[index] = state.item;
                });
              }
            },
          ),
        ],
        child: Scaffold(
          appBar: AppBar(title: const Text('Categorías'), centerTitle: true),
          body: items.isNotEmpty
              ? ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return CustomListTile(
                      status: item.status ?? false,
                      onTap: () => showFullScreenModal(context, item),
                      title: Text(item.name ?? ''),
                      itemId: item.id!,
                      onPressed:(context) {
                        debugPrint("Item: ${item.id}");
                      },
                    );
                  },
                )
              : NotFound(),
        ),
      ),
    );
  }
}

Future<void> showFullScreenModal(
    BuildContext context, CategoryModel item) async {
  // context.read<CategoryBloc>().add(GetOneCategory(item.id!));

  showModalBottomSheet(
    context: context,
    sheetAnimationStyle: AnimationStyle(duration: Duration(seconds: 1)),
    isScrollControlled: true,
    useRootNavigator: true, // Asegura que el Navigator raíz maneje el modal
    // backgroundColor: AppConstants.lightGrey,
    builder: (BuildContext context) {
      return GestureDetector(
        onTap: () {}, // Esto evita que los gestos se cierren accidentalmente
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          child: SimpleForm(item: item,),
        ),
      );
    },
  );
}
