import 'package:auto_route/auto_route.dart';
import 'package:doomi/interfaces/themes.dart';
import 'package:doomi/providers/theme_provider.dart';
import 'package:doomi/utils/general_functions.dart';
import 'package:doomi/utils/styles/spacings.dart';
import 'package:doomi/widgets/cta.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// This is used to show a text field which when
// pressed displays a bottom sheet with speicifc options
// to choose from and update the textfield's state.
class BottomSheetField extends ConsumerStatefulWidget {
  const BottomSheetField({
    Key? key,
    required this.options,
    required this.onOptionSelected,
    this.fillColor,
    this.borderRadius,
    this.boxBorder,
    this.verticalPadding,
    this.prefixText = '',
    this.intialValue,
  }) : super(key: key);

  final List<String> options;
  final Color? fillColor;
  final double? borderRadius;
  final BoxBorder? boxBorder;
  final String prefixText;
  final double? verticalPadding;
  final Function(String) onOptionSelected;
  final String? intialValue;

  @override
  ConsumerState<BottomSheetField> createState() => _BottomSheetFieldState();
}

class _BottomSheetFieldState extends ConsumerState<BottomSheetField> {
  late FixedExtentScrollController scrollController;
  late String selectedOption;
  bool sheetOpened = false;

  @override
  void initState() {
    selectedOption = widget.intialValue ?? '';
    int i = widget.options.indexOf(selectedOption);
    scrollController = FixedExtentScrollController(
      initialItem: i == -1 ? 0 : i,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        sheetOpened = !sheetOpened;
        setState(() {});
        showCustomBottomSheet(theme);
      },
      child: Container(
        padding: widget.verticalPadding == null
            ? null
            : EdgeInsets.symmetric(vertical: widget.verticalPadding!),
        decoration: BoxDecoration(
          color: widget.fillColor,
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 24),
          border: widget.boxBorder ??
              Border.all(
                color: theme.textFieldBorderColor,
                width: 0.7,
              ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(Spacings.spacingFactor * 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (widget.prefixText.isNotEmpty)
                Text(
                  '${widget.prefixText}: ',
                  style: theme.body3.copyWith(fontWeight: FontWeight.w400),
                ),
              Expanded(
                child: Text(
                  selectedOption,
                  style: theme.body3.copyWith(fontWeight: FontWeight.w400),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: AnimatedRotation(
                  turns: !sheetOpened ? 0 : 1 / 2,
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.decelerate,
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: Icon(
                      Icons.arrow_back_ios_outlined,
                      color: theme.accentColor,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showCustomBottomSheet(ITheme theme) async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (c) {
        scrollController.dispose;
        scrollController = FixedExtentScrollController(
          initialItem: widget.options.indexOf(selectedOption),
        );
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CtaButton(
                    label: translate('verify', context),
                    padding: const EdgeInsets.symmetric(
                      vertical: Spacings.spacingFactor,
                      horizontal: Spacings.spacingFactor * 3,
                    ),
                    onPressed: () {
                      selectedOption =
                          widget.options[scrollController.selectedItem];
                      widget.onOptionSelected(selectedOption);
                      setState(() {});
                      AutoRouter.of(context).pop();
                    },
                  )),
            ),
            Container(
              decoration: BoxDecoration(
                color: theme.backgroundLightContrast,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              height: 220,
              child: CupertinoPicker(
                itemExtent: 45,
                scrollController: scrollController,
                backgroundColor: Colors.transparent,
                onSelectedItemChanged: (i) {},
                children: List.generate(
                  widget.options.length,
                  (index) => SizedBox(
                    height: 45,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        widget.options[index],
                        style: theme.body4,
                        // style: Styles.settingsLabelStyle.copyWith(
                        //   color: Colors.black,
                        //   fontSize: 20,
                        // ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
    sheetOpened = false;
    if (mounted) setState(() {});
  }
}
