import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wedlist/app/router.dart';
import 'package:wedlist/core/constants/app_colors.dart';
import 'package:wedlist/core/constants/app_sizes.dart';
import 'package:wedlist/data/providers/auth_provider.dart';
import 'package:wedlist/features/shared/components/atoms/custom_primary_button.dart';

@RoutePage()
class ChecklistScreen extends ConsumerWidget {
  final String roomId;

  const ChecklistScreen({
    super.key,
    @PathParam('roomId') required this.roomId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final authVM = ref.read(authProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text("Checklist")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Room ID: $roomId"),
            CustomPrimaryButton(
              text: "Çıkış yap",
              onTap: () async {
                await authVM.signOut();
                context.router.replace(const AuthRoute());
              },
            )
          ],
        ),
      ),

      // ✅ FAB eklendi
      floatingActionButton: SizedBox(
        width: AppSizes.widthXl,
        height: AppSizes.heightXl,
        child: FloatingActionButton(
          onPressed: () {
            context.router.push(const AddEditItemRoute());
          },
          backgroundColor: AppColors.primary,
          shape: const CircleBorder(),
          child: const Icon(
            Icons.add,
            color: AppColors.white,
            size: 32, // İkonu da büyütüyoruz
          ),
        ),
      ),
    );
  }
}
