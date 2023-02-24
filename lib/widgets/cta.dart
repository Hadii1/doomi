import 'package:doomi/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CtaButton extends ConsumerStatefulWidget {
  const CtaButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.height,
    this.enabled = true,
    this.animateEnabledState = false,
    this.includePadding = false,
    this.underlinedText = false,
    this.elevate = true,
    this.icon,
    this.borderRadius,
    this.textSize,
    this.animateAsyncProcess = false,
  }) : super(key: key);

  final Function() onPressed;
  final bool includePadding;
  final bool underlinedText;
  final bool animateEnabledState;
  final double? borderRadius;
  final bool enabled;
  final bool elevate;
  final String label;
  final double? height;
  final double? textSize;
  final Widget? icon;
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
        end: ref.read(themeProvider).accentColor.withOpacity(0.4),
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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
        boxShadow: widget.elevate
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                ),
              ]
            : null,
      ),
      child: SizedBox(
        height: widget.height,
        child: TextButton(
          onPressed: !widget.enabled
              ? null
              : () async {
                  if (widget.animateAsyncProcess && loading) return;

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
            backgroundColor: widget.animateEnabledState
                ? animation!.value
                : theme.accentColor,
            fixedSize: Size(double.maxFinite, widget.height ?? 62),
            textStyle: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              decoration:
                  widget.underlinedText ? TextDecoration.underline : null,
              // fontFamily: Fonts.avenir,
            ),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 12,
              right: 12,
              top: 2,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.icon != null) widget.icon!,
                widget.animateAsyncProcess
                    ? AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: loading
                            ? const SpinKitCircle(
                                size: 40,
                                color: Colors.white,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
