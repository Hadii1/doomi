import 'package:doomi/providers/theme_provider.dart';
import 'package:doomi/utils/styles/spacings.dart';
import 'package:doomi/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActionTile extends ConsumerStatefulWidget {
  const ActionTile({
    Key? key,
    required this.label,
    required this.icon,
    required this.onTap,
    this.animatedLoading = false,
  }) : super(key: key);

  final String label;
  final bool animatedLoading;
  final IconData icon;
  final Function() onTap;

  @override
  ConsumerState<ActionTile> createState() => _ActionTileState();
}

class _ActionTileState extends ConsumerState<ActionTile> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () async {
            if (widget.animatedLoading == false) return widget.onTap();
            if (loading) return;
            loading = true;
            setState(() {});

            await widget.onTap();

            loading = false;
            setState(() {});
          },
          child: Container(
            padding: const EdgeInsets.all(Spacings.spacingFactor * 2),
            decoration: BoxDecoration(
              color: theme.backgroundLightContrast,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.label,
                    style: theme.body3,
                  ),
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: loading
                      ? const Loader(
                          size: 24,
                        )
                      : Icon(
                          widget.icon,
                          color: theme.accentColor,
                        ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: Spacings.spacingBetweenElements,
        ),
      ],
    );
  }
}
