import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedlist/core/constants/app_colors.dart';
import 'package:wedlist/core/constants/app_sizes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wedlist/data/providers/room_provider.dart';
import 'package:wedlist/features/shared/components/atoms/custom_primary_button.dart';
import 'package:wedlist/features/shared/components/atoms/custom_text_field.dart';
import 'package:wedlist/features/shared/components/molecules/participant_item.dart';
import 'package:wedlist/features/shared/components/molecules/room_code_display.dart';
import 'package:wedlist/features/shared/components/organisms/settings_card.dart';

@RoutePage()
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final TextEditingController _roomNameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // RoomProvider future'u tamamlandığında controller'a veri atanır
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(roomProvider.future).then((room) {
        if (room != null && _roomNameController.text.isEmpty) {
          _roomNameController.text = room.roomName;
        }
      });
    });
  }

  @override
  void dispose() {
    _roomNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final roomAsync = ref.watch(roomProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          t.settings,
          style: GoogleFonts.inter(
            fontWeight: AppSizes.weightBold,
            color: AppColors.textBlack,
          ),
        ),
        backgroundColor: AppColors.white,
        centerTitle: true,
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
          child: roomAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text("Error: $e")),
            data: (room) {
              if (room == null) {
                return Center(child: Text(t.error));
              }

              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  vertical: AppSizes.paddingLg,
                  horizontal: AppSizes.paddingXl,
                ),
                child: Column(
                  children: [
                    /// 📌 Room Code
                    SettingsCard(
                      title: t.roomCode,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RoomCodeDisplay(roomCode: room.id),
                          SizedBox(height: AppSizes.heightXxs),
                          Text(
                            t.shareCodeWithPartner,
                            style: GoogleFonts.roboto(
                              fontSize: AppSizes.fontLg,
                              color: AppColors.greyText,
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// 📝 Room Name Edit
                    SettingsCard(
                      title: t.roomName,
                      child: CustomTextField(
                        hintText: t.roomName,
                        controller: _roomNameController,
                        suffixIcon: Icons.check,
                        suffixIconColor: AppColors.primary,
                        onSuffixTap: () async {
                          final updatedName = _roomNameController.text.trim();
                          if (updatedName.isNotEmpty &&
                              updatedName != room.roomName) {
                            await ref
                                .read(roomProvider.notifier)
                                .updateRoomName(room.id, updatedName);

                            // SnackBar ile bilgilendir
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(t.roomNameUpdated)),
                            );
                          }
                        },
                      ),
                    ),

                    /// 👥 Participants
                    SettingsCard(
                      title: t.participants,
                      child: ref.watch(participantsProvider).when(
                            loading: () => const Center(
                                child: CircularProgressIndicator()),
                            error: (e, _) =>
                                Center(child: Text(t.errorLoadingParticipants)),
                            data: (users) {
                              if (users.isEmpty) {
                                return Text(t.noParticipants);
                              }

                              final participantInfo = ref
                                  .read(roomProvider.notifier)
                                  .mapUsersToParticipantInfo(users);

                              return Column(
                                children: participantInfo.map((info) {
                                  return ParticipantItem(
                                    initials: info['initials']!,
                                    name: info['name']!,
                                    role: info['role'] == "you" ? t.you : "",
                                    isOnline: true,
                                  );
                                }).toList(),
                              );
                            },
                          ),
                    ),
                    SettingsCard(
                      title: t.dangerZone,
                      child: Column(
                        children: [
                          CustomPrimaryButton(
                            text: t.leaveRoom,
                            onTap: () async {
                              final confirmed = await showDialog<bool>(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: Text(t.confirmLeave),
                                  content: Text(t.leaveRoomWarning),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(ctx).pop(false),
                                      child: Text(t.cancel),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(ctx).pop(true),
                                      child: Text(t.leave),
                                    ),
                                  ],
                                ),
                              );
                              if (confirmed == true) {
                                await ref
                                    .read(roomProvider.notifier)
                                    .leaveRoom(context);
                              }
                            },
                            color: AppColors.white,
                            hasShadow: false,
                            textColor: AppColors.textBlack,
                            hasBorder: true,
                          ),
                          SizedBox(height: AppSizes.heightXxs),
                          CustomPrimaryButton(
                            text: t.deleteRoom,
                            onTap: () async {
                              final confirmed = await showDialog<bool>(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: Text(t.deleteRoomConfirm),
                                  content: Text(t.irreversibleAction),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(ctx).pop(false),
                                      child: Text(t.cancel),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(ctx).pop(true),
                                      child: Text(t.delete),
                                    ),
                                  ],
                                ),
                              );
                              if (confirmed == true) {
                                await ref
                                    .read(roomProvider.notifier)
                                    .deleteRoom(context);
                              }
                            },
                            color: AppColors.opacityPrimary,
                            hasShadow: false,
                            hasBorder: true,
                            textColor: AppColors.opacityTextPrimary,
                            borderColor: AppColors.opacityBorderPrimary,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
