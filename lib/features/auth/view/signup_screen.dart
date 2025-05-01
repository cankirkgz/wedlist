import 'package:flutter/material.dart';
import 'package:wedlist/core/constants/app_sizes.dart';
import 'package:wedlist/features/shared/components/atoms/custom_primary_button.dart';
import 'package:wedlist/features/shared/components/molecules/labeled_text_field.dart';

class SignupScreen extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController nameController;
  final VoidCallback onSignupTap;
  final bool isLoading;

  const SignupScreen({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.nameController,
    required this.onSignupTap,
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
        const SizedBox(height: AppSizes.paddingXxl),
        LabeledTextField(
          label: "İsim",
          hintText: "İsminizi giriniz",
          controller: nameController,
        ),
        const SizedBox(height: AppSizes.paddingLg),
        CustomPrimaryButton(
          text: "Kayıt Ol",
          onTap: onSignupTap,
          isLoading: isLoading,
        ),
      ],
    );
  }
}
