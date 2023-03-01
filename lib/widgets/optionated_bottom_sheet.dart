// import 'package:auto_route/auto_route.dart';
// import 'package:doomi/providers/theme_provider.dart';
// import 'package:doomi/utils/general_functions.dart';
// import 'package:doomi/utils/styles/spacings.dart';
// import 'package:doomi/widgets/cta.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// // This widget displays a textfield which when pressed
// // displays a bottom sheet with the provided options for
// // the user to choose from.
// class BottomSheetField extends ConsumerStatefulWidget {
//   const BottomSheetField({
//     Key? key,
//     required this.options,
//     required this.onOptionSelected,
//     required this.intialValue,
//     required this.labelAboveField,
//   }) : super(key: key);

//   final List<String> options;
//   final String labelAboveField;
//   final Function(String) onOptionSelected;
//   final String intialValue;

//   @override
//   ConsumerState<BottomSheetField> createState() => _BottomSheetFieldState();
// }

// class _BottomSheetFieldState extends ConsumerState<BottomSheetField> {
//   late FixedExtentScrollController scrollController;
//   late String selectedOption;
//   bool sheetOpened = false;

//   @override
//   void initState() {
//     selectedOption = widget.intialValue;
//     int i = widget.options.indexOf(selectedOption);
//     scrollController = FixedExtentScrollController(
//       initialItem: i == -1 ? 0 : i,
//     );
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = ref.watch(themeProvider);
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(
//             bottom: Spacings.spacingFactor * 2,
//           ),
//           child: Text(
//             widget.labelAboveField,
//             style: theme.labelStyle,
//           ),
//         ),
//         InkWell(
//           onTap: () {
//             sheetOpened = !sheetOpened;
//             setState(() {});
//             showCustomBottomSheet();
//           },
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.red,
//               borderRadius: BorderRadius.circular(4),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(12),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     selectedOption,
//                     // style: theme.
//                   ),
//                   SizedBox(
//                     width: 36,
//                     child: Align(
//                       alignment: Alignment.centerLeft,
//                       child: AnimatedRotation(
//                         turns: !sheetOpened ? 0 : 1 / 2,
//                         duration: const Duration(milliseconds: 250),
//                         curve: Curves.decelerate,
//                         child: const RotatedBox(
//                           quarterTurns: 1,
//                           child: Icon(
//                             Icons.arrow_back_ios_outlined,
//                             // color: Styles.darkGrey,
//                             size: 18,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   void showCustomBottomSheet() async {
//     await showModalBottomSheet(
//       context: context,
//       backgroundColor: Colors.transparent,
//       builder: (c) {
//         scrollController.dispose;
//         scrollController = FixedExtentScrollController(
//           initialItem: widget.options.indexOf(selectedOption),
//         );
//         return Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Align(
//               alignment: Alignment.topRight,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: CtaButton(
//                   label: translate('verify', context),
//                   padding: const EdgeInsets.symmetric(
//                     vertical: Spacings.spacingFactor,
//                     horizontal: Spacings.spacingFactor * 2,
//                   ),
//                   onPressed: () {
//                     selectedOption =
//                         widget.options[scrollController.selectedItem];
//                     widget.onOptionSelected(selectedOption);
//                     setState(() {});
//                     AutoRouter.of(context).pop();
//                   },
//                 ),
//               ),
//             ),
//             Container(
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(12),
//                   topRight: Radius.circular(12),
//                 ),
//               ),
//               height: 250,
//               child: CupertinoPicker(
//                 itemExtent: 45,
//                 scrollController: scrollController,
//                 backgroundColor: Colors.transparent,
//                 onSelectedItemChanged: (i) {},
//                 children: List.generate(
//                   widget.options.length,
//                   (index) => SizedBox(
//                     height: 45,
//                     child: Padding(
//                       padding: const EdgeInsets.only(top: 8.0),
//                       child: Text(
//                         widget.options[index],
//                         // style: Styles.settingsLabelStyle.copyWith(
//                         //   color: Colors.black,
//                         //   fontSize: 20,
//                         // ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//     sheetOpened = false;
//     if (mounted) setState(() {});
//   }
// }
