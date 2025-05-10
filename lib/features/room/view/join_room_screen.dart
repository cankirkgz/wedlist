import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedlist/core/constants/app_colors.dart';
import 'package:wedlist/core/constants/app_sizes.dart';
import 'package:wedlist/data/providers/room_provider.dart';
import 'package:wedlist/features/shared/components/atoms/app_square_image.dart';
import 'package:wedlist/features/shared/components/atoms/custom_primary_button.dart';
import 'package:wedlist/features/shared/components/molecules/room_code_input.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class JoinRoomScreen extends ConsumerStatefulWidget {
  const JoinRoomScreen({super.key});

  @override
  ConsumerState<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends ConsumerState<JoinRoomScreen> {
  String _enteredCode = '';

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: Text(
          t.joinRoomTitle,
          style: GoogleFonts.inter(
            fontWeight: AppSizes.weightBold,
            fontSize: AppSizes.fontXxl,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [AppColors.softPrimary, AppColors.white],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              top: kToolbarHeight + AppSizes.paddingLg,
              left: AppSizes.paddingXl,
              right: AppSizes.paddingXl,
              bottom: mediaQuery.viewInsets.bottom + AppSizes.paddingLg,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: mediaQuery.size.height - kToolbarHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    SizedBox(height: AppSizes.paddingXxl),
                    Text(
                      t.enterRoomCode,
                      style: GoogleFonts.inter(
                        fontSize: AppSizes.fontXl,
                        color: AppColors.textBlack,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: AppSizes.paddingXxl),
                    AppSquareImage(
                      imagePath: 'assets/images/contact.png',
                      width: AppSizes.imageSizeLg,
                      height: AppSizes.imageSizeLg,
                    ),
                    SizedBox(height: AppSizes.paddingXxl),
                    RoomCodeInput(
                      length: 6,
                      onChanged: (code) => setState(() => _enteredCode = code),
                      onCompleted: (code) =>
                          setState(() => _enteredCode = code),
                    ),
                    const Spacer(),
                    CustomPrimaryButton(
                      text: t.joinRoom,
                      onTap: () async {
                        final joined = await ref
                            .read(roomProvider.notifier)
                            .joinRoom(_enteredCode, context);
                        if (!joined) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(t.roomNotFound)),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
