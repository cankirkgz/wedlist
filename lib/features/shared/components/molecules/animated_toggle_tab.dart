import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedlist/core/constants/app_colors.dart';
import 'package:wedlist/core/constants/app_sizes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AnimatedToggleTab extends StatefulWidget {
  final Function(int) onTabChange;
  final int selectedIndex;

  const AnimatedToggleTab({
    super.key,
    required this.onTabChange,
    required this.selectedIndex,
  });

  @override
  State<AnimatedToggleTab> createState() => _AnimatedToggleTabState();
}

class _AnimatedToggleTabState extends State<AnimatedToggleTab> {
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Container(
      height: AppSizes.heightXl,
      decoration: BoxDecoration(
        color: AppColors.softPrimary,
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            alignment: widget.selectedIndex == 0
                ? Alignment.centerLeft
                : Alignment.centerRight,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            child: Container(
              width: MediaQuery.of(context).size.width / 2 - 32,
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppSizes.radiusMd),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(AppSizes.radiusLg),
                  onTap: () => widget.onTabChange(0),
                  child: Center(
                    child: Text(
                      t.login,
                      style: GoogleFonts.inter(
                        color: widget.selectedIndex == 0
                            ? AppColors.primaryText
                            : AppColors.softPrimaryText,
                        fontSize: AppSizes.fontXl,
                        fontWeight: AppSizes.weightBold,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(AppSizes.radiusLg),
                  onTap: () => widget.onTabChange(1),
                  child: Center(
                    child: Text(
                      t.signUp,
                      style: GoogleFonts.inter(
                        color: widget.selectedIndex == 1
                            ? AppColors.primaryText
                            : AppColors.softPrimaryText,
                        fontSize: AppSizes.fontXl,
                        fontWeight: AppSizes.weightBold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
