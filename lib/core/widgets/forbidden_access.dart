import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ForbiddenAccess extends StatelessWidget {
  final String? message;
  const ForbiddenAccess({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
      SizedBox(
        height: 200,
        child: Lottie.asset('assets/lottie/error.json'),
      ),
      Text(message ??
        'No tiene permisos para acceder a este módulo.',
        style: TextStyle(fontSize: 26, fontFamily: 'Roboto'),
        textAlign: TextAlign.center,
      ),
              ],
            ),
    );
  }
}
