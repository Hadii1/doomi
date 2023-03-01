// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class FadeAnimation extends StatefulWidget {
  const FadeAnimation({
    Key? key,
    this.duration = const Duration(milliseconds: 300),
    required this.hide,
    required this.child,
    this.delay,
    this.initialValue = 1,
    this.automaticallyStart = true,
  }) : super(key: key);

  final Widget child;
  final Duration duration;
  final Duration? delay;
  final double initialValue;
  final bool hide;
  final bool automaticallyStart;

  @override
  _FadenimationState createState() => _FadenimationState();
}

class _FadenimationState extends State<FadeAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> animation;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: widget.duration,
      value: widget.initialValue,
    );
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeOutCubic,
    );
    if (widget.automaticallyStart) {
      if (widget.delay != null) {
        Future.delayed(widget.delay!).then((_) {
          if (mounted) {
            controller.forward();
          }
        });
      } else {
        controller.forward();
      }
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant FadeAnimation oldWidget) {
    if (oldWidget.hide != widget.hide && mounted) {
      widget.hide ? controller.reverse() : controller.forward();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: widget.child,
    );
  }
}
