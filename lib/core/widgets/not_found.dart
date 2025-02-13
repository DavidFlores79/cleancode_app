import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NotFound extends StatelessWidget {
  final String? message;
  const NotFound({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            height: 200,
            child: Image.asset('assets/images/box.png'),
          ),
          Text(
            message ?? 'No fue posible cargar los registros de este módulo.',
            style: TextStyle(fontSize: 20, fontFamily: 'Roboto'),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
