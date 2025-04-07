// connectivity_cubit.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityCubit extends Cubit<ConnectivityResult> {
  final Connectivity _connectivity = Connectivity();

  ConnectivityCubit() : super(ConnectivityResult.none) {
    _connectivity.onConnectivityChanged.listen((results) {
      for (var result in results) {
        debugPrint("Result Connectivity ===> ${result.name}");
      }
      final result = results.isNotEmpty ? results.first : ConnectivityResult.none;
      emit(result);
    });
  }
}
