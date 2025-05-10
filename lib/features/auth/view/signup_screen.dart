import 'package:flutter/material.dart';
import 'package:wedlist/core/constants/app_sizes.dart';
import 'package:wedlist/features/shared/components/atoms/custom_primary_button.dart';
import 'package:wedlist/features/shared/components/molecules/labeled_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final t = AppLocalizations.of(context)!;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        LabeledTextField(
          label: t.email,
          hintText: t.enterYourEmail,
          controller: emailController,
        ),
        SizedBox(height: AppSizes.paddingXxl),
        LabeledTextField(
          label: t.password,
          hintText: t.enterYourPassword,
          controller: passwordController,
          isPassword: true,
        ),
        SizedBox(height: AppSizes.paddingXxl),
        LabeledTextField(
          label: t.name,
          hintText: t.enterYourName,
          controller: nameController,
        ),
        SizedBox(height: AppSizes.paddingLg),
        CustomPrimaryButton(
          text: t.signUp,
          onTap: onSignupTap,
          isLoading: isLoading,
        ),
      ],
    );
  }
}
