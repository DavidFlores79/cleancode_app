import 'package:cleancode_app/core/constants/message_constants.dart';
import 'package:cleancode_app/features/home/presentation/bloc/module_bloc.dart';
import 'package:flutter/material.dart';

class PageError extends StatelessWidget {
  final String? message;
  const PageError({super.key, this.message});

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
              height: 200,
              child: Image.asset('assets/images/web.png'),
            ),
            Text(
              message ?? MessagesConstants.unloadedRecords,
              style: TextStyle(fontSize: 20, fontFamily: 'Roboto'),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 25),
            ElevatedButton(onPressed:() => ModuleCubit()..getModules(), child: Text('Recargar'))
          ],
        ),
      ),
    );
  }
}
