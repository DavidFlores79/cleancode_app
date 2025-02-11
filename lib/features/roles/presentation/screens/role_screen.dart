import 'package:cleancode_app/core/utils/app_utils.dart';
import 'package:cleancode_app/core/widgets/forbidden_access.dart';
import 'package:cleancode_app/features/roles/presentation/bloc/role_bloc.dart';
import 'package:cleancode_app/features/roles/presentation/bloc/role_event.dart';
import 'package:cleancode_app/features/roles/presentation/bloc/role_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RolesScreen extends StatefulWidget {
  const RolesScreen({super.key});

  @override
  State<RolesScreen> createState() => _RolesScreenState();
}

class _RolesScreenState extends State<RolesScreen> {
   @override
  void initState() {
    super.initState();
    context.read<RoleBloc>().add(FetchRoles());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Roles')),
      body: BlocListener<RoleBloc, RoleState>(
        listener: (context, state) {
          if (state is RoleFailureState) {
            // debugPrint(state.message);
            AppUtils.showSnackBar(context, state.message);
          }
        },
        child: BlocBuilder<RoleBloc, RoleState>(
          builder: (context, state) {
            if(state is ForbiddenActionState) {
              debugPrint("Screen |*** ${state.message} ***|");
              return ForbiddenAccess(message: state.message);
            }
            if (state is RoleLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is RoleSuccessState) {

              return ListView.builder(
                itemCount: state.roles.length,
                itemBuilder: (context, index) {
                  final role = state.roles[index];
                  return ListTile(
                    title: Text(role.name ?? ''),
                    subtitle: Text('${role.status}'),
                  );
                },
              );
            }
            return const Center(child: Text('No se cargaron roles'));
          },
        ),
      ),
    );
  }
}