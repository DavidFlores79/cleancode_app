import 'package:cleancode_app/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CustomListTile extends StatelessWidget {
  final GestureTapCallback? onTap;
  final SlidableActionCallback? onPressed;
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
      this.onPressed,
      this.itemId = '0',
      }
    );

  @override
  Widget build(BuildContext context) {
    return Slidable(
      // Specify a key if the Slidable is dismissible.
      key: ValueKey(itemId),

      // The start action pane is the one at the left or the top side.
      endActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),

        // A pane can dismiss the Slidable.
        dismissible: DismissiblePane(onDismissed: () {}),

        // All actions are defined in the children parameter.
        children: [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            onPressed: onPressed,
            backgroundColor: AppConstants.red,
            foregroundColor: AppConstants.white,
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
                color: status == true ? Colors.lightGreen : Colors.red,
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
