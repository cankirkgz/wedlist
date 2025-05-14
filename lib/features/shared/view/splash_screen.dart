import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wedlist/app/router.dart';
import 'package:wedlist/core/constants/app_sizes.dart';
import 'package:wedlist/data/providers/auth_provider.dart';

@RoutePage()
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await Future.delayed(const Duration(milliseconds: 700));

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      context.replaceRoute(const AuthRoute());
    } else {
      await ref.read(authProvider.notifier).handlePostLoginRouting(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: AppSizes.imageSizeMd,
          height: AppSizes.imageSizeMd,
          child: Image.asset("assets/icons/logo.png"),
        ),
      ),
    );
  }
}
