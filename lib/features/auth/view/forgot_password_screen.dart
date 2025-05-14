import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedlist/core/constants/app_colors.dart';
import 'package:wedlist/core/constants/app_sizes.dart';
import 'package:wedlist/data/providers/auth_provider.dart';
import 'package:wedlist/features/shared/components/atoms/app_title_text.dart';
import 'package:wedlist/features/shared/components/atoms/custom_primary_button.dart';
import 'package:wedlist/features/shared/components/molecules/labeled_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class ForgotPasswordScreen extends ConsumerWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController _emailController = TextEditingController();
    final authState = ref.watch(authProvider);
    final authVM = ref.read(authProvider.notifier);
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [AppColors.softPrimary, AppColors.white],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: AppSizes.paddingLg,
                horizontal: AppSizes.paddingXl,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppTitleText(text: t.appTitle),
                  SizedBox(height: AppSizes.paddingXxl),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {
                        context.router.back();
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.arrow_back),
                          SizedBox(width: AppSizes.paddingSm),
                          Text(
                            t.backToLogin,
                            style: GoogleFonts.inter(
                              fontSize: AppSizes.fontLg,
                              color: AppColors.textBlack,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: AppSizes.paddingLg),
                  Text(
                    t.resetPasswordTitle,
                    style: GoogleFonts.inter(
                      fontSize: AppSizes.fontHuge,
                      fontWeight: AppSizes.weightBold,
                      color: AppColors.textBlack,
                    ),
                  ),
                  SizedBox(height: AppSizes.paddingXs),
                  Text(
                    t.resetPasswordDescription,
                    style: GoogleFonts.inter(
                      fontSize: AppSizes.fontLg,
                      color: AppColors.textBlack,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: AppSizes.paddingXl),
                  LabeledTextField(
                    label: t.email,
                    hintText: t.enterYourEmail,
                    controller: _emailController,
                  ),
                  SizedBox(height: AppSizes.paddingXl),
                  CustomPrimaryButton(
                    text: t.resetPasswordButton,
                    onTap: () async {
                      final email = _emailController.text.trim();

                      if (email.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(t.emailRequired)),
                        );
                        return;
                      }
                      await authVM.resetPassword(email);
                      if (authState.error != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(authState.error!)),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(t.resetEmailSent),
                          ),
                        );
                        context.router.back(); // Giriş ekranına geri döner
                      }
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
