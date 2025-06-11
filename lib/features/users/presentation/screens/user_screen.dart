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
  // List<UserModel> items = []; // Replaced by allLoadedUsers
  List<UserModel> allLoadedUsers = [];
  bool isLoadingMore = false;
  bool canLoadMore = true;
  bool isDeleted = false; // Keep for delete logic

  @override
  void initState() {
    super.initState();
    // Load first page
    context.read<UserBloc>().add(GetAllUsers(page: 1, pageSize: AppConstants.defaultPageSize));
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
                setState(() {
                  allLoadedUsers.clear();
                  isLoadingMore = false;
                  canLoadMore = true; // Reset on initial load
                });
              } else if (state is GetAllUsersSuccessState) {
                context.loaderOverlay.hide();
                setState(() {
                  // Assuming pageableUsers.data is List<User> (domain entities)
                  // and we need to map them to UserModel for the UI list.
                  allLoadedUsers = state.pageableUsers.data.map((e) => UserModel.fromDomain(e)).toList();
                  isLoadingMore = false;
                  canLoadMore = allLoadedUsers.length < state.pageableUsers.totalItems;
                });
              } else if (state is UserLoadingMoreState) {
                setState(() {
                  isLoadingMore = true;
                });
              } else if (state is UserMaxReachedState) {
                context.loaderOverlay.hide();
                setState(() {
                  allLoadedUsers = state.pageableUsers.data.map((e) => UserModel.fromDomain(e)).toList();
                  isLoadingMore = false;
                  canLoadMore = false;
                });
              } else if (state is UserFailureState) {
                context.loaderOverlay.hide();
                setState(() {
                  isLoadingMore = false;
                });
                AppUtils.showSnackBar(context, state.message);
              } else if (state is GetOneUserSuccessState) {
                  context.loaderOverlay.hide();
              } else if (state is UpdateUserSuccessState) {
                context.loaderOverlay.hide();
                // Refresh the list or update the specific item
                // For simplicity, dispatching GetAllUsers to refresh.
                // A more sophisticated approach would update the item in allLoadedUsers directly.
                context.read<UserBloc>().add(GetAllUsers(page: 1, pageSize: AppConstants.defaultPageSize));

              } else if (state is CreateUserSuccessState) {
                 context.loaderOverlay.hide();
                 // Refresh the list
                 context.read<UserBloc>().add(GetAllUsers(page: 1, pageSize: AppConstants.defaultPageSize));

              } else if (state is DeleteUserSuccessState) {
                context.loaderOverlay.hide();
                isDeleted = true; // Assuming isDeleted is part of your delete confirmation logic
                // Refresh the list. Pass current page to try to stay on it, or page 1.
                context.read<UserBloc>().add(GetAllUsers(page: 1, pageSize: AppConstants.defaultPageSize));
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
          body: allLoadedUsers.isEmpty && !context.loaderOverlay.visible && !isLoadingMore
              ? NotFound()
              : ListView.builder(
                  itemCount: allLoadedUsers.length + (canLoadMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == allLoadedUsers.length && canLoadMore) {
                      return Center(
                        child: isLoadingMore
                            ? CircularProgressIndicator()
                            : ElevatedButton(
                                onPressed: () {
                                  if (!isLoadingMore) {
                                    // Access currentPage from UserBloc instance
                                    context.read<UserBloc>().add(GetAllUsers(page: context.read<UserBloc>().currentPage, pageSize: AppConstants.defaultPageSize));
                                  }
                                },
                                child: Text("Load More"),
                              ),
                      );
                    }
                    // Guard against index out of bounds if itemCount logic is tricky
                    if (index >= allLoadedUsers.length) {
                       return SizedBox.shrink(); // Should not happen with correct itemCount
                    }
                    final item = allLoadedUsers[index];
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
                      onDismissed: () => allLoadedUsers.removeWhere((element) => element.id == item.id), // Update allLoadedUsers
                      confirmDismiss: () async {
                        // This confirmDismiss might need re-evaluation with pagination.
                        // Deleting an item might require refreshing the current page or re-fetching.
                        context.read<UserBloc>().add(DeleteUser(item.id!));
                        // await Future.delayed(Duration(seconds: AppConstants.deleteSecondsDelay));
                        return isDeleted; // isDeleted should be set true upon successful deletion in BlocListener
                      },
                    );
                  },
                )
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
