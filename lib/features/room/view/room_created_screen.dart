import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedlist/app/router.dart';
import 'package:wedlist/core/constants/app_colors.dart';
import 'package:wedlist/core/constants/app_sizes.dart';
import 'package:wedlist/features/shared/components/atoms/custom_primary_button.dart';
import 'package:wedlist/features/shared/components/atoms/screen_header.dart';
import 'package:wedlist/features/shared/components/organisms/room_code_box.dart';

@RoutePage()
class RoomCreatedScreen extends StatelessWidget {
  final String roomId;

  const RoomCreatedScreen({super.key, required this.roomId});

  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.symmetric(
              vertical: AppSizes.paddingLg,
              horizontal: AppSizes.paddingXl,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/done.png',
                  width: AppSizes.imageSizeMd,
                ),
                const SizedBox(height: AppSizes.paddingXxl),
                ScreenHeader(
                  title: "You're All Set! 💍",
                  subTitle:
                      "Share this code with your partner so they can join you",
                ),
                const SizedBox(height: AppSizes.paddingXxl),
                RoomCodeBox(roomId: roomId), // roomId ile gösterim
                const Spacer(),
                CustomPrimaryButton(
                  widget: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Odanıza Gidin",
                        style: GoogleFonts.inter(
                          fontSize: AppSizes.fontXl,
                          fontWeight: AppSizes.weightBold,
                        ),
                      ),
                      const SizedBox(width: AppSizes.paddingXs),
                      const Icon(
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
