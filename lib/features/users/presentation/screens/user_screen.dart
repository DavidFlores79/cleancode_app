import 'package:cleancode_app/core/constants/app_constants.dart';
import 'package:cleancode_app/core/constants/color_constants.dart';
import 'package:cleancode_app/core/utils/app_utils.dart';
import 'package:cleancode_app/core/widgets/custom_listtile.dart';
import 'package:cleancode_app/core/widgets/not_found.dart';
import 'package:cleancode_app/features/users/data/models/user_model.dart';
import 'package:cleancode_app/features/users/presentation/bloc/user_bloc.dart';
import 'package:cleancode_app/features/users/presentation/bloc/user_event.dart';
import 'package:cleancode_app/features/users/presentation/bloc/user_state.dart';
import 'package:cleancode_app/features/users/presentation/widgets/create_form.dart';
import 'package:cleancode_app/features/users/presentation/widgets/update_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  UserModel item = UserModel();
  List<UserModel> items = [];
  bool isDeleted = false;

  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(GetAllUsers());
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      overlayColor: Theme.of(context).cardColor.withOpacity(0.8),
      overlayWidgetBuilder: (_) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
      child: MultiBlocListener(
        listeners: [
          BlocListener<UserBloc, UserState>(
            listener: (context, state) {
              if (state is UserLoadingState) {
                context.loaderOverlay.show();
              }

              if (state is UserFailureState) {
                context.loaderOverlay.hide();
                AppUtils.showSnackBar(context, state.message);
              }

              if (state is GetAllUsersSuccessState) {
                setState(() {
                  items = state.items;
                  context.loaderOverlay.hide();
                });
              }
              if (state is GetOneUserSuccessState) {
                setState(() {
                  context.loaderOverlay.hide();
                });
              }
              if (state is UpdateUserSuccessState) {
                setState(() {
                  context.loaderOverlay.hide();
                  int index =
                      items.indexWhere((item) => item.id == state.item.id);
                  if (index != -1) items[index] = state.item;
                });
              }
              if (state is CreateUserSuccessState) {
                setState(() {
                  context.loaderOverlay.hide();
                  items.add(state.item);
                });
              }
              if (state is DeleteUserSuccessState) {
                setState(() {
                  context.loaderOverlay.hide();
                  isDeleted = true;
                  context.read<UserBloc>().add(GetAllUsers());
                });
              }
            },
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Usuarios'),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () => showCreateModal(context),
                icon: Icon(Icons.add_rounded),
              )
            ],
          ),
          body: items.isNotEmpty
              ? ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return CustomListTile(
                      status: item.status ?? false,
                      onTap: () => showUpdateModal(context, item),
                      leading: SizedBox(
                        height: 30,
                        width: 30,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage('${item.image}'),
                        ),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              item.name ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 10),
                          UserRoleLabel(item: item),
                        ],
                      ),
                      subtitle: Text(
                        item.email ?? '',
                        style: TextStyle(color: ColorConstants.grey),
                      ),
                      itemId: item.id!,
                      onDelete: (context) {
                        debugPrint("Item: ${item.id}");
                        context.read<UserBloc>().add(DeleteUser(item.id!));
                      },
                      onDismissed: () => items.removeWhere((element) => element.id == item.id),
                      confirmDismiss: () async {
                        context.read<UserBloc>().add(DeleteUser(item.id!));
                        // await Future.delayed(Duration(seconds: AppConstants.deleteSecondsDelay));
                        return isDeleted;
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

class UserRoleLabel extends StatelessWidget {
  const UserRoleLabel({
    super.key,
    required this.item,
  });

  final UserModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 95, 95, 95),
          borderRadius: BorderRadius.circular(10)),
      child: Text(
        item.role.name.replaceAll('_ROLE', '') ?? '',
        style: TextStyle(
          color: ColorConstants.white,
          fontSize: 10,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

Future<void> showUpdateModal(BuildContext context, UserModel item) async {
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
          child: SimpleUpdateForm(
            item: item,
          ),
        ),
      );
    },
  );
}

Future<void> showCreateModal(BuildContext context) async {
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
          child: SimpleCreateForm(),
        ),
      );
    },
  );
}
