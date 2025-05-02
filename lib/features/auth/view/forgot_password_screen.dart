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

@RoutePage()
class ForgotPasswordScreen extends ConsumerWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController _emailController = TextEditingController();
    final authState = ref.watch(authProvider);
    final authVM = ref.read(authProvider.notifier);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
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
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const AppTitleText(text: 'WedList'),
                const SizedBox(height: AppSizes.paddingXxl),
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
                        const SizedBox(width: AppSizes.paddingSm),
                        Text(
                          "Giriş Yap Sayfasına Dön",
                          style: GoogleFonts.inter(
                            fontSize: AppSizes.fontLg,
                            color: AppColors.textBlack,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.paddingLg),
                Text(
                  "Parolanı Yenile",
                  style: GoogleFonts.inter(
                    fontSize: AppSizes.fontHuge,
                    fontWeight: AppSizes.weightBold,
                    color: AppColors.textBlack,
                  ),
                ),
                const SizedBox(height: AppSizes.paddingXs),
                Text(
                  "E-posta adresinizi girin, şifrenizi sıfırlamak için talimatları size gönderelim.",
                  style: GoogleFonts.inter(
                    fontSize: AppSizes.fontLg,
                    color: AppColors.textBlack,
                  ),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: AppSizes.paddingXl),
                LabeledTextField(
                  label: 'Email',
                  hintText: 'Emailinizi giriniz',
                  controller: _emailController,
                ),
                const SizedBox(height: AppSizes.paddingXl),
                CustomPrimaryButton(
                  text: "Şifreni Sıfırla",
                  onTap: () async {
                    final email = _emailController.text.trim();

                    if (email.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Lütfen e-posta adresinizi girin')),
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
                        const SnackBar(
                            content: Text(
                                'Şifre sıfırlama bağlantısı e-posta adresinize gönderildi.')),
                      );
                      context.router.back(); // Giriş ekranına geri döner
                    }
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
