// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class SlideAnimation extends StatefulWidget {
  const SlideAnimation({
    Key? key,
    this.duration = const Duration(milliseconds: 300),
    required this.hide,
    this.initialValue = 0,
    required this.child,
    this.showingDelay = Duration.zero,
    this.automaticallyStart = true,
  }) : super(key: key);

  final Widget child;
  final double initialValue;
  final Duration duration;

  /// Duration to wait before starting the show animation
  final Duration showingDelay;
  final bool hide;
  final bool automaticallyStart;

  @override
  _SlideAnimationState createState() => _SlideAnimationState();
}

class _SlideAnimationState extends State<SlideAnimation>
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
      curve: Curves.easeOutExpo,
      reverseCurve: Curves.easeInCubic,
    );
    if (widget.automaticallyStart && widget.initialValue == 0) {
      Future.delayed(widget.showingDelay).then((value) => controller.forward());
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant SlideAnimation oldWidget) {
    if (oldWidget.hide != widget.hide && mounted) {
      Future.delayed(widget.hide ? Duration.zero : widget.showingDelay)
          .then((_) {
        widget.hide ? controller.reverse() : controller.forward();
      });
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
    return SizeTransition(
      sizeFactor: animation,
      child: widget.child,
    );
  }
}
