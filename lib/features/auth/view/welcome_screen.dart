import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wedlist/app/router.dart';
import 'package:wedlist/core/constants/app_colors.dart';
import 'package:wedlist/core/constants/app_sizes.dart';
import 'package:wedlist/data/providers/room_provider.dart';
import 'package:wedlist/features/shared/components/atoms/app_square_image.dart';
import 'package:wedlist/features/shared/components/atoms/app_title_text.dart';
import 'package:wedlist/features/shared/components/atoms/custom_primary_button.dart';
import 'package:wedlist/features/shared/components/atoms/screen_header.dart';

@RoutePage()
class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                const AppTitleText(text: 'WedList'),
                const SizedBox(height: AppSizes.paddingXxl),
                ScreenHeader(
                  title: "Plan Your Wedding Together 💍",
                  subTitle:
                      "Create or join a shared room to build your checklist as a couple",
                ),
                const SizedBox(height: AppSizes.paddingXxl),
                const AppSquareImage(imagePath: 'assets/images/couple.png'),
                const SizedBox(height: AppSizes.paddingXxl),
                CustomPrimaryButton(
                  text: "Oda Oluştur",
                  onTap: () async {
                    final roomId =
                        await ref.read(roomProvider.notifier).createRoom();
                    if (roomId != null) {
                      context.router.push(RoomCreatedRoute(roomId: roomId));
                    }
                  },
                ),
                const SizedBox(height: AppSizes.paddingMd),
                CustomPrimaryButton(
                  text: "Odaya katıl",
                  onTap: () {
                    context.router.push(const JoinRoomRoute());
                  },
                  color: AppColors.white,
                  borderColor: AppColors.primary,
                  textColor: AppColors.primary,
                  hasBorder: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
