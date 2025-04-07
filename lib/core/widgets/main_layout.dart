import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../blocs/connectivity_cubit.dart';

class MainLayout extends StatefulWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  OverlayEntry? _overlayEntry;

  void _showOfflineBanner(BuildContext context) {
    if (_overlayEntry != null) return; // ya se está mostrando

    _overlayEntry = OverlayEntry(
      builder: (_) => SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.red.shade600,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: IconButton(
                  icon: const Icon(Icons.wifi_off, color: Colors.white),
                  onPressed: () {
                    AppSettings.openAppSettings(type: AppSettingsType.wifi);
                  },
                  tooltip: 'Sin conexión',
                ),
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context, rootOverlay: true).insert(_overlayEntry!);
  }

  void _hideOfflineBanner() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectivityCubit, ConnectivityResult>(
      listener: (context, state) {
        final isOffline = state == ConnectivityResult.none;
        if (isOffline) {
          _showOfflineBanner(context);
        } else {
          _hideOfflineBanner();
        }
      },
      child: Scaffold(
        body: widget.child,
      ),
    );
  }
}
