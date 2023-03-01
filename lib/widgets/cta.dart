import 'package:doomi/providers/theme_provider.dart';
import 'package:doomi/utils/styles/spacings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CtaButton extends ConsumerStatefulWidget {
  const CtaButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.padding,
    this.enabled = true,
    this.animateEnabledState = false,
    this.textSize,
    this.animateAsyncProcess = false,
  }) : super(key: key);

  final Function() onPressed;

  final EdgeInsets? padding;
  final bool animateEnabledState;
  final bool enabled;
  final String label;
  final double? textSize;
  final bool animateAsyncProcess;

  @override
  ConsumerState<CtaButton> createState() => _CtaButtonState();
}

class _CtaButtonState extends ConsumerState<CtaButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController? animationController;
  late Animation<Color?>? animation;
  bool loading = false;

  @override
  void initState() {
    if (widget.animateEnabledState) {
      animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
        lowerBound: 0,
        upperBound: 1,
        value: widget.enabled ? 0 : 1,
      )..addListener(() {
          setState(() {});
        });
      animation = ColorTween(
        begin: ref.read(themeProvider).accentColor,
        end: Colors.grey[400],
      ).animate(animationController!);
    } else {
      animationController = null;
    }

    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant CtaButton oldWidget) {
    if (mounted &&
        widget.animateEnabledState &&
        widget.enabled != oldWidget.enabled) {
      if (widget.enabled) {
        animationController!.reverse();
      } else {
        animationController!.forward();
      }
      setState(() {});
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);
    return TextButton(
      onPressed: widget.enabled == false
          ? null
          : () async {
              if (widget.animateAsyncProcess && loading) return;

              // To close the keyboard in case it was opened
              FocusScopeNode node = FocusScope.of(context);
              if (!node.hasPrimaryFocus) {
                node.unfocus();
              }

              if (widget.animateAsyncProcess) {
                loading = true;
                setState(() {});
                await widget.onPressed();
                loading = false;
                setState(() {});
              } else {
                widget.onPressed();
              }
            },
      style: TextButton.styleFrom(
        shadowColor: Colors.black,
        padding: widget.padding ??
            const EdgeInsets.symmetric(
              vertical: Spacings.spacingFactor * 2,
              horizontal: Spacings.spacingFactor * 3,
            ),
        backgroundColor:
            widget.animateEnabledState ? animation!.value : theme.accentColor,
        textStyle: TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.w500,
          color: theme.textColor,
        ),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: widget.animateAsyncProcess
          ? AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: loading
                  ? const SizedBox(
                      height: 20,
                      child: SpinKitPulse(
                        size: 20,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      widget.label,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: widget.textSize,
                        color: theme.accentContrast,
                      ),
                    ),
            )
          : Text(
              widget.label,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: widget.textSize,
                color: widget.enabled
                    ? Colors.white
                    : Colors.white.withOpacity(0.6),
              ),
            ),
    );
  }
}
