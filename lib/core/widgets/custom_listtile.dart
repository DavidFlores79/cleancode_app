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
  final bool enabled;
  final String itemId;
  final Widget? leading;
  final Widget? trailing;

  const CustomListTile(
      {super.key,
      required this.title,
      required this.status,
      this.subtitle,
      this.onTap,
      this.onDelete,
      this.itemId = '0',
      this.onDismissed,
      required this.confirmDismiss,
      this.trailing,
      this.leading,
      this.enabled = true,
      }
    );

  @override
  Widget build(BuildContext context) {
    return Slidable(
      enabled: enabled,
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
            label: 'Eliminar',
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
            trailing: trailing,
            leading: leading,
            onTap: onTap,
            title: title,
            subtitle: subtitle,
          ),
        ),
      ),
    );
  }
}
