import 'package:flutter/material.dart';

void showToast(String toastMessage, BuildContext context) {
  final overlayEntry = OverlayEntry(
    builder: (ctx) {
      return Align(
        alignment: const Alignment(0.0, 0.8),
        child: Material(
          animationDuration: const Duration(milliseconds: 500),
          color: Theme.of(ctx).primaryColorLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Theme.of(ctx).colorScheme.onPrimary),
          ),

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),

            child: Text(toastMessage),
          ),
        ),
      );
    },
  );

  Overlay.of(context).insert(overlayEntry);
  Future.delayed(
    const Duration(seconds: 2),
  ).then((val) => overlayEntry.remove());
}
