import 'package:flutter/material.dart';

class FadingExportDialog extends StatefulWidget {
  @override
  _FadingExportDialogState createState() => _FadingExportDialogState();
}

class _FadingExportDialogState extends State<FadingExportDialog>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink,
      child: FadeTransition(
        opacity: animation,
        child: Container(
          height: 100,
          width: 100,
        ),
      ),
    );
  }
}
