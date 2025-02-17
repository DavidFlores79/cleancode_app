import 'package:cleancode_app/core/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CustomListTile extends StatelessWidget {
  final GestureTapCallback? onTap;
  final SlidableActionCallback? onDelete;
  final VoidCallback? onDismissed;
  final Future<bool>Function()? confirmDismiss;
  final Widget title;
  final Widget? subtitle;
  final bool status;
  final String itemId;

  const CustomListTile(
      {super.key,
      required this.title,
      required this.status,
      this.subtitle,
      this.onTap,
      this.onDelete,
      this.itemId = '0',
      this.onDismissed,
      required this.confirmDismiss
      }
    );

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(itemId),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(
          closeOnCancel: true,
          confirmDismiss:confirmDismiss,
          onDismissed: onDismissed ?? (){},
        ),
        children: [
          SlidableAction(
            onPressed: onDelete,
            backgroundColor: ColorConstants.red,
            foregroundColor: ColorConstants.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: Card(
        elevation: 5, // Sombra integrada en el Card
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ),
        ),
        child: Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
            border: Border(
              left: BorderSide(
                color: status == true ? ColorConstants.activeColor : ColorConstants.inactiveColor,
                width: 7, // Grosor del borde
              ),
            ),
          ),
          child: ListTile(
            onTap: onTap,
            title: title,
            subtitle: subtitle,
          ),
        ),
      ),
    );
  }
}
