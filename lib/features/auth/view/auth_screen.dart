import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedlist/app/router.dart';
import 'package:wedlist/core/constants/app_colors.dart';
import 'package:wedlist/core/constants/app_sizes.dart';
import 'package:wedlist/data/providers/auth_provider.dart';
import 'package:wedlist/features/auth/view/login_screen.dart';
import 'package:wedlist/features/auth/view/signup_screen.dart';
import 'package:wedlist/features/shared/components/atoms/app_title_text.dart';
import 'package:wedlist/features/shared/components/atoms/custom_primary_button.dart';
import 'package:wedlist/features/shared/components/atoms/or_divider.dart';
import 'package:wedlist/features/shared/components/molecules/animated_toggle_tab.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final ValueNotifier<int> selectedIndex = ValueNotifier<int>(0);
  final emailController = TextEditingController(text: 'mcankirkgoz@gmail.com');
  final passwordController = TextEditingController(text: '123456');
  final nameController = TextEditingController(text: 'Can');

  @override
  void dispose() {
    selectedIndex.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final authVM = ref.read(authProvider.notifier);
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
          child: SingleChildScrollView(
            // 👈 Burada kaydırma sağlıyoruz
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: AppSizes.paddingLg,
                horizontal: AppSizes.paddingXl,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      AppSizes.paddingLg * 2,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppTitleText(text: t.appTitle),
                      SizedBox(height: AppSizes.paddingXxl),
                      // 🔘 Toggle Login / Signup
                      ValueListenableBuilder<int>(
                        valueListenable: selectedIndex,
                        builder: (_, value, __) => AnimatedToggleTab(
                          selectedIndex: value,
                          onTabChange: (i) => selectedIndex.value = i,
                        ),
                      ),
                      SizedBox(height: AppSizes.paddingXxl),
                      // 🔐 Login / Signup form
                      ValueListenableBuilder<int>(
                        valueListenable: selectedIndex,
                        builder: (_, value, __) {
                          if (value == 0) {
                            return LoginScreen(
                              emailController: emailController,
                              passwordController: passwordController,
                              isLoading: authState.isLoading,
                              onForgotPassword: () => context.router
                                  .push(const ForgotPasswordRoute()),
                              onLoginTap: () async {
                                final user = await authVM.signIn(
                                  emailController.text.trim(),
                                  passwordController.text.trim(),
                                  context,
                                );
                                if (user != null) {
                                  await authVM.handlePostLoginRouting(context);
                                } else if (authState.error != null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(authState.error!)),
                                  );
                                }
                              },
                            );
                          } else {
                            return SignupScreen(
                              emailController: emailController,
                              passwordController: passwordController,
                              nameController: nameController,
                              isLoading: authState.isLoading,
                              onSignupTap: () async {
                                final user = await authVM.signUp(
                                  emailController.text.trim(),
                                  passwordController.text.trim(),
                                  nameController.text.trim(),
                                  context,
                                );
                                if (user != null) {
                                  await authVM.handlePostLoginRouting(context);
                                } else if (authState.error != null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(authState.error!)),
                                  );
                                }
                              },
                            );
                          }
                        },
                      ),
                      SizedBox(height: AppSizes.paddingXxl),
                      const OrDivider(),
                      SizedBox(height: AppSizes.paddingXxl),

                      CustomPrimaryButton(
                        text: "Google ile devam et",
                        color: AppColors.white,
                        hasBorder: true,
                        hasShadow: false,
                        isLoading: false,
                        widget: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/icons/google.png'),
                            SizedBox(width: AppSizes.paddingSm),
                            Text(
                              t.continueWithGoogle,
                              style: GoogleFonts.inter(
                                color: AppColors.textBlack,
                                fontSize: AppSizes.fontXl,
                                fontWeight: AppSizes.weightBold,
                              ),
                            ),
                          ],
                        ),
                        onTap: () async {
                          final user = await authVM.signInWithGoogle(context);
                          if (user == null && authState.error != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(authState.error!)),
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
      ),
    );
  }
}
