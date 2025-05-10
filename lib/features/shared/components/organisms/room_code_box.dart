import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wedlist/core/constants/app_colors.dart';
import 'package:wedlist/core/constants/app_sizes.dart';
import 'package:wedlist/features/shared/components/atoms/custom_primary_button.dart';
import 'package:wedlist/features/shared/components/atoms/room_code_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RoomCodeBox extends StatelessWidget {
  final String roomId;
  const RoomCodeBox({super.key, required this.roomId});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final message = t.shareRoomMessage(roomId);

    return Card(
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppSizes.paddingXl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RoomCodeText(code: roomId),
            SizedBox(height: AppSizes.paddingLg),
            CustomPrimaryButton(
              hasShadow: false,
              widget: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.copy,
                      color: AppColors.white, size: AppSizes.iconSizeMd),
                  SizedBox(width: AppSizes.paddingMd),
                  Text(
                    t.copyCode,
                    style: GoogleFonts.inter(
                      fontSize: AppSizes.fontXl,
                      fontWeight: AppSizes.weightBold,
                    ),
                  ),
                ],
              ),
              onTap: () async {
                await Clipboard.setData(ClipboardData(text: roomId));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(t.codeCopied)),
                );
              },
            ),
            SizedBox(height: AppSizes.paddingLg),
            CustomPrimaryButton(
              color: AppColors.buttonSoftPrimary,
              hasShadow: false,
              widget: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.share,
                    color: AppColors.primaryText,
                    size: AppSizes.iconSizeMd,
                  ),
                  SizedBox(width: AppSizes.paddingMd),
                  Text(
                    t.shareCode,
                    style: GoogleFonts.inter(
                      fontSize: AppSizes.fontXl,
                      fontWeight: AppSizes.weightBold,
                      color: AppColors.primaryText,
                    ),
                  ),
                ],
              ),
              onTap: () {
                SharePlus.instance.share(
                  ShareParams(text: message),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
