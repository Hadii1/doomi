import 'package:doomi/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loader extends ConsumerWidget {
  const Loader({
    super.key,
    this.size = 62.0,
    this.topPadding = 0,
    this.color,
  });

  final double size;
  final Color? color;
  final double topPadding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: Center(
        child: SpinKitPulse(
          color: color ?? ref.watch(themeProvider).textColor,
          size: size,
        ),
      ),
    );
  }
}
