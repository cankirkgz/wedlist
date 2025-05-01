import 'package:flutter/material.dart';
import 'package:wedlist/core/constants/app_sizes.dart';
import 'package:wedlist/features/shared/components/atoms/clickable_text.dart';
import 'package:wedlist/features/shared/components/atoms/custom_primary_button.dart';
import 'package:wedlist/features/shared/components/molecules/labeled_text_field.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onForgotPassword;
  final VoidCallback onLoginTap;
  final bool isLoading;

  const LoginScreen({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.onForgotPassword,
    required this.onLoginTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        LabeledTextField(
          label: "Email",
          hintText: "Email'inizi giriniz",
          controller: emailController,
        ),
        const SizedBox(height: AppSizes.paddingXxl),
        LabeledTextField(
          label: "Parola",
          hintText: "Parolanızı giriniz",
          controller: passwordController,
          isPassword: true,
        ),
        const SizedBox(height: AppSizes.paddingMd),
        Align(
          alignment: Alignment.centerRight,
          child: ClickableText(
            text: "Parolanızı mı unuttunuz?",
            onTap: onForgotPassword,
          ),
        ),
        const SizedBox(height: AppSizes.paddingMd),
        CustomPrimaryButton(
          text: "Giriş Yap",
          onTap: onLoginTap,
          isLoading: isLoading,
        ),
      ],
    );
  }
}
