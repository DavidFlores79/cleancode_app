import 'package:cleancode_app/core/utils/app_utils.dart';
import 'package:cleancode_app/core/widgets/custom_listtile.dart';
import 'package:cleancode_app/core/widgets/not_found.dart';
import 'package:cleancode_app/features/payments/data/models/payment_model.dart';
import 'package:cleancode_app/features/payments/presentation/bloc/payment_bloc.dart';
import 'package:cleancode_app/features/payments/presentation/bloc/payment_event.dart';
import 'package:cleancode_app/features/payments/presentation/bloc/payment_state.dart';
import 'package:cleancode_app/features/payments/presentation/widgets/create_form.dart';
import 'package:cleancode_app/features/payments/presentation/widgets/update_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  PaymentModel item = PaymentModel();
  List<PaymentModel> items = [];
  bool isDeleted = false;

  @override
  void initState() {
    super.initState();
    context.read<PaymentBloc>().add(GetAllPayments());
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
          BlocListener<PaymentBloc, PaymentState>(
            listener: (context, state) {
              if (state is PaymentLoadingState) {
                context.loaderOverlay.show();
              }

              if (state is PaymentFailureState) {
                context.loaderOverlay.hide();
                AppUtils.showSnackBar(context, state.message);
              }

              if (state is GetAllPaymentsSuccessState) {
                setState(() {
                  items = state.items;
                  context.loaderOverlay.hide();
                });
              }
              if (state is GetOnePaymentSuccessState) {
                setState(() {
                  context.loaderOverlay.hide();
                });
              }
              if (state is UpdatePaymentSuccessState) {
                setState(() {
                  context.loaderOverlay.hide();
                  int index =
                      items.indexWhere((item) => item.id == state.item.id);
                  if (index != -1) items[index] = state.item;
                });
              }
              if (state is CreatePaymentSuccessState) {
                setState(() {
                  context.loaderOverlay.hide();
                  items.add(state.item);
                });
              }
              if (state is DeletePaymentSuccessState) {
                setState(() {
                  context.loaderOverlay.hide();
                  isDeleted = true;
                  context.read<PaymentBloc>().add(GetAllPayments());
                });
              }
            },
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Pagos'),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () => showCreateModal(context),
                  icon: Icon(Icons.add_rounded))
            ],
          ),
          body: items.isEmpty
              ? NotFound()
              : ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return CustomListTile(
                      status: item.status ?? false,
                      onTap: () => showUpdateModal(context, item),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(item.description ?? ''),
                          Text(item.amount.toString()),
                        ],
                      ),
                      subtitle: Text(item.owner?.name ?? ''),
                      itemId: item.id!,
                      onDelete: (context) {
                        debugPrint("Item: ${item.id}");
                        context
                            .read<PaymentBloc>()
                            .add(DeletePayment(item.id!));
                      },
                      onDismissed: () =>
                          items.removeWhere((element) => element.id == item.id),
                      confirmDismiss: () async {
                        context
                            .read<PaymentBloc>()
                            .add(DeletePayment(item.id!));
                        return isDeleted;
                      },
                    );
                  },
                ),
        ),
      ),
    );
  }
}

Future<void> showUpdateModal(BuildContext context, PaymentModel item) async {
  // context.read<PaymentBloc>().add(GetOnePayment(item.id!));

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
