import 'package:flutter/material.dart';

class LoadingIndicator {
  static bool _isShowing = false;

  static void setLoading(BuildContext context, [bool value = true]) {
    // Check if context is still valid
    if (!context.mounted) {
      _isShowing = false;
      return;
    }

    if (value) {
      if (!_isShowing) {
        _isShowing = true;
        showDialog(
          context: context,
          barrierDismissible: false,
          barrierColor: Colors.black.withValues(alpha: 0.3),
          builder: (_) => const Center(
            child: CircularProgressIndicator(color: Colors.blueAccent),
          ),
        );
      }
    } else {
      if (_isShowing) {
        try {
          final navigator = Navigator.maybeOf(context);
          if (navigator != null && navigator.canPop()) {
            navigator.pop();
          }
        } catch (e) {
          print("Error dismissing loading: $e");
        } finally {
          _isShowing = false;
        }
      }
    }
  }
}