import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wedlist/core/constants/app_colors.dart';
import 'package:wedlist/core/constants/app_sizes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RoomCodeDisplay extends StatelessWidget {
  final String roomCode;

  const RoomCodeDisplay({super.key, required this.roomCode});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    final message = t.shareRoomMessage(roomCode);
    return Container(
      decoration: BoxDecoration(
        color: AppColors.softBackground,
        borderRadius: BorderRadius.circular(AppSizes.radiusSm),
      ),
      padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.widthXxs, vertical: AppSizes.heightXxs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            roomCode,
            style: const TextStyle(
              fontSize: AppSizes.fontXl,
              fontWeight: FontWeight.bold,
              color: AppColors.textBlack,
              letterSpacing: AppSizes.letterSpacingXl,
            ),
          ),
          Row(
            children: [
              _IconBox(
                icon: Icons.copy,
                color: AppColors.softPrimary,
                iconColor: AppColors.primary,
                onTap: () {
                  Clipboard.setData(ClipboardData(text: roomCode));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(t.codeCopied)),
                  );
                },
              ),
              const SizedBox(width: 8),
              _IconBox(
                icon: Icons.share,
                color: AppColors.softBlue,
                iconColor: AppColors.blue,
                onTap: () {
                  SharePlus.instance.share(
                    ShareParams(text: message),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _IconBox extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color iconColor;
  final VoidCallback onTap;

  const _IconBox({
    required this.icon,
    required this.color,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(AppSizes.radiusMd),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.paddingSm),
          child: Icon(icon, color: iconColor, size: AppSizes.fontXl),
        ),
      ),
    );
  }
}
