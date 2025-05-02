import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart'; // 📦 paylaşım için
import 'package:wedlist/core/constants/app_colors.dart';
import 'package:wedlist/core/constants/app_sizes.dart';
import 'package:wedlist/features/shared/components/atoms/custom_primary_button.dart';
import 'package:wedlist/features/shared/components/atoms/room_code_text.dart';

class RoomCodeBox extends StatelessWidget {
  final String roomId;
  const RoomCodeBox({super.key, required this.roomId});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingXl),
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
                    "Kodu Kopyala",
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
                  const SnackBar(content: Text('Kod kopyalandı')),
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
                  Icon(Icons.share,
                      color: AppColors.primaryText, size: AppSizes.iconSizeMd),
                  SizedBox(width: AppSizes.paddingMd),
                  Text(
                    "Kodu Paylaş",
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
                  ShareParams(
                      text:
                          '💍 WedList oda kodum: $roomId\nBu kodla odamıza katılabilirsin!'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
