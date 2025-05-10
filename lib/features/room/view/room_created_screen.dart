import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedlist/app/router.dart';
import 'package:wedlist/core/constants/app_colors.dart';
import 'package:wedlist/core/constants/app_sizes.dart';
import 'package:wedlist/features/shared/components/atoms/custom_primary_button.dart';
import 'package:wedlist/features/shared/components/atoms/screen_header.dart';
import 'package:wedlist/features/shared/components/organisms/room_code_box.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class RoomCreatedScreen extends StatelessWidget {
  final String roomId;

  const RoomCreatedScreen({super.key, required this.roomId});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [AppColors.softPrimary, AppColors.white],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: AppSizes.paddingLg,
              horizontal: AppSizes.paddingXl,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // İçerik kaydırılabilir hale getirildi
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/done.png',
                          width: AppSizes.imageSizeMd,
                        ),
                        SizedBox(height: AppSizes.paddingXxl),
                        ScreenHeader(
                          title: t.youreAllSet,
                          subTitle: t.shareCodeWithPartner,
                        ),
                        SizedBox(height: AppSizes.paddingXxl),
                        RoomCodeBox(roomId: roomId),
                      ],
                    ),
                  ),
                ),

                // Alt sabit buton
                CustomPrimaryButton(
                  widget: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        t.goToYourRoom,
                        style: GoogleFonts.inter(
                          fontSize: AppSizes.fontXl,
                          fontWeight: AppSizes.weightBold,
                        ),
                      ),
                      SizedBox(width: AppSizes.paddingXs),
                      Icon(
                        Icons.arrow_forward,
                        color: AppColors.white,
                        size: AppSizes.iconSizeMd,
                      ),
                    ],
                  ),
                  onTap: () {
                    context.router.replace(ChecklistRoute(roomId: roomId));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
