import 'package:cleancode_app/core/widgets/custom_listtile.dart';
import 'package:cleancode_app/core/widgets/not_found.dart';
import 'package:cleancode_app/features/users/data/models/user_model.dart';
import 'package:cleancode_app/features/users/presentation/bloc/user_bloc.dart';
import 'package:cleancode_app/features/users/presentation/bloc/user_event.dart';
import 'package:cleancode_app/features/users/presentation/bloc/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchUsersDelegate extends SearchDelegate<UserModel?> {
  final userBloc;

  SearchUsersDelegate({required this.userBloc});

  @override
  String? get searchFieldLabel => 'Buscar';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          close(context, null);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  Widget _buildSearchResults() {
    userBloc.add(SearchUsers(query));

    return BlocBuilder<UserBloc, UserState>(
      bloc: userBloc,
      builder: (context, state) {
        if (state is UserLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SearchUsersSuccessState) {
          final users = state.items;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return CustomListTile(
                enabled: false,
                title: Text(user.name ?? 'Sin nombre'),
                subtitle: Text(user.email ?? 'Sin email'),
                onTap: () {
                  close(context, user);
                },
                status: user.status ?? false,
                onDismissed: null,
                confirmDismiss: null,
              );
            },
          );
        } else if (state is UserFailureState) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text('Busca usuarios por nombre o email'));
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    debugPrint("Query ==================> $query");
    userBloc.add(SearchUsers(query));

    // Muestra sugerencias mientras el usuario escribe
    if (query.isEmpty) {
      return Center(
        child: NotFound(
          message: 'Sin resultados',
        ),
      );
    }
    return _buildSearchResults();
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }
}
