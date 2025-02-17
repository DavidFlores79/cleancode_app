import 'package:cleancode_app/core/constants/app_constants.dart';
import 'package:cleancode_app/core/utils/app_utils.dart';
import 'package:cleancode_app/core/widgets/custom_listtile.dart';
import 'package:cleancode_app/core/widgets/not_found.dart';
import 'package:cleancode_app/features/payment_methods/data/models/payment_method_model.dart';
import 'package:cleancode_app/features/payment_methods/presentation/bloc/payment_method_bloc.dart';
import 'package:cleancode_app/features/payment_methods/presentation/bloc/payment_method_event.dart';
import 'package:cleancode_app/features/payment_methods/presentation/bloc/payment_method_state.dart';
import 'package:cleancode_app/features/payment_methods/presentation/widgets/create_form.dart';
import 'package:cleancode_app/features/payment_methods/presentation/widgets/update_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  PaymentMethodModel item = PaymentMethodModel();
  List<PaymentMethodModel> items = [];
  bool isDeleted = false;

  @override
  void initState() {
    super.initState();
    context.read<PaymentMethodBloc>().add(GetAllPaymentMethods());
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      overlayColor: Theme.of(context).cardColor.withOpacity(0.6),
      overlayWidgetBuilder: (_) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
      child: MultiBlocListener(
        listeners: [
          BlocListener<PaymentMethodBloc, PaymentMethodState>(
            listener: (context, state) {
              if (state is PaymentMethodLoadingState) {
                context.loaderOverlay.show();
              }

              if (state is PaymentMethodFailureState) {
                context.loaderOverlay.hide();
                AppUtils.showSnackBar(context, state.message);
              }

              if (state is GetAllPaymentMethodsSuccessState) {
                setState(() {
                  items = state.items;
                  context.loaderOverlay.hide();
                });
              }
              if (state is GetOnePaymentMethodSuccessState) {
                setState(() {
                  context.loaderOverlay.hide();
                });
              }
              if (state is UpdatePaymentMethodSuccessState) {
                setState(() {
                  context.loaderOverlay.hide();
                  int index =
                      items.indexWhere((item) => item.id == state.item.id);
                  if (index != -1) items[index] = state.item;
                });
              }
              if (state is CreatePaymentMethodSuccessState) {
                setState(() {
                  context.loaderOverlay.hide();
                  items.add(state.item);
                });
              }
              if (state is DeletePaymentMethodSuccessState) {
                setState(() {
                  context.loaderOverlay.hide();
                  isDeleted = true;
                  context.read<PaymentMethodBloc>().add(GetAllPaymentMethods());
                });
              }
            },
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Métodos de Pago'), 
            centerTitle: true, 
            actions: [
              IconButton(onPressed:() => showCreateModal(context), icon: Icon(Icons.add_rounded))
            ],
          ),
          body: items.isNotEmpty || !context.loaderOverlay.visible
              ? ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return CustomListTile(
                      status: item.status ?? false,
                      onTap: () => showUpdateModal(context, item),
                      title: Text(item.name ?? ''),
                      itemId: item.id!,
                      onDelete:(context) {
                        debugPrint("Item: ${item.id}");
                        context.read<PaymentMethodBloc>().add(DeletePaymentMethod(item.id!));
                      },
                      onDismissed: () => items.removeWhere((element) => element.id == item.id),
                      confirmDismiss: () async {
                        context.read<PaymentMethodBloc>().add(DeletePaymentMethod(item.id!));
                        await Future.delayed(Duration(seconds: AppConstants.deleteSecondsDelay));
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

Future<void> showUpdateModal(BuildContext context, PaymentMethodModel item) async {
  // context.read<PaymentMethodBloc>().add(GetOnePaymentMethod(item.id!));

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
          child: SimpleUpdateForm(item: item,),
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
