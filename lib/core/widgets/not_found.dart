import 'package:cleancode_app/core/constants/color_constants.dart';
import 'package:cleancode_app/core/constants/message_constants.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class NotFound extends StatelessWidget {
  final String? message;
  const NotFound({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: HugeIcon(icon: HugeIcons.strokeRoundedDeliveryBox01, size: 75, color: ColorConstants.grey,),
            ),
            Text(
              message ?? MessagesConstants.noRecords,
              style: TextStyle(fontSize: 20, fontFamily: 'Roboto', color: ColorConstants.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
