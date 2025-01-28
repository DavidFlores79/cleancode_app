import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ForbiddenAccess extends StatelessWidget {
  const ForbiddenAccess({super.key});

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
      Text(
        'No tiene permisos para acceder a este módulo.',
        style: TextStyle(fontSize: 26, fontFamily: 'Roboto'),
        textAlign: TextAlign.center,
      ),
              ],
            ),
    );
  }
}
