import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingOverlay {
  static OverlayEntry? _overlayEntry;

  static void show(BuildContext context) {
    if (_overlayEntry != null) return; // Nếu đã có loading, không tạo lại

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _overlayEntry = OverlayEntry(
        builder: (context) => Stack(
          children: [
            ModalBarrier(
              color: const Color(0xffF5F9FE).withOpacity(0.5),
              dismissible: false, // Không cho phép bấm ra ngoài
            ),
            Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: const Color(0xff3461FD),
                size: 50,
              ),
            ),
          ],
        ),
      );

      Overlay.of(context).insert(_overlayEntry!);
    });
  }

  static void hide() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
