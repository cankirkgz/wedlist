import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedlist/app/router.dart';
import 'package:wedlist/core/constants/app_colors.dart';
import 'package:wedlist/core/constants/app_sizes.dart';
import 'package:wedlist/data/providers/auth_provider.dart';
import 'package:wedlist/data/providers/checklist_provider.dart';
import 'package:wedlist/data/providers/filtered_checklist_provider.dart';
import 'package:wedlist/data/providers/room_provider.dart';
import 'package:wedlist/features/shared/components/atoms/filter_button.dart';
import 'package:wedlist/features/shared/components/atoms/search_items.dart';
import 'package:wedlist/features/shared/components/molecules/custom_gradient_progress_bar.dart';
import 'package:wedlist/features/shared/components/molecules/financial_status_card.dart';
import 'package:wedlist/features/shared/components/molecules/item_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class ChecklistScreen extends ConsumerStatefulWidget {
  final String roomId;

  const ChecklistScreen({
    super.key,
    @PathParam('roomId') required this.roomId,
  });

  @override
  ConsumerState<ChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends ConsumerState<ChecklistScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();

    // Oda kodunu bir kez ayarla
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(checklistProvider.notifier).setRoomCode(widget.roomId);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    final authVM = ref.read(authProvider.notifier);
    final roomAsync = ref.watch(roomProvider); // 🔄 roomFutureProvider yerine
    final checklistVM = ref.read(checklistProvider.notifier);
    final items = ref.watch(filteredChecklistProvider);

    final spent = checklistVM.spentTotal;
    final remaining = checklistVM.remainingTotal;
    final remainingPercent = checklistVM.remainingPercentage;

    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [AppColors.softPrimary, AppColors.white],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // ÜST BAR
              Container(
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  border: Border(
                    bottom: BorderSide(color: AppColors.lightGrey, width: 1),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppSizes.paddingLg,
                    horizontal: AppSizes.paddingXl,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Başlık ve çıkış
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          roomAsync.when(
                            data: (room) => Text(
                              room?.roomName ?? t.checklist,
                              style: GoogleFonts.inter(
                                fontSize: AppSizes.fontXl,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryText,
                              ),
                            ),
                            loading: () => Text(t.loading),
                            error: (e, _) => Text(t.error),
                          ),
                          PopupMenuButton<String>(
                            icon: const Icon(Icons.more_vert,
                                color: AppColors.primaryText),
                            onSelected: (value) async {
                              if (value == 'settings') {
                                context.router.push(const SettingsRoute());
                              } else if (value == 'logout') {
                                await authVM.signOut();
                                context.router.replace(const AuthRoute());
                              }
                            },
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                  value: 'settings', child: Text(t.settings)),
                              PopupMenuItem(
                                  value: 'logout', child: Text(t.logout)),
                            ],
                          ),
                        ],
                      ),
                      const Divider(color: AppColors.lightGrey, height: 24),
                      const SizedBox(height: AppSizes.paddingLg),

                      // Finans kartları
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: FinancialStatusCard(
                                iconAssetPath: "assets/icons/check.png",
                                title: t.spent,
                                amount: spent,
                                backgroundColor: AppColors.softPrimary,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: FinancialStatusCard(
                                iconAssetPath: "assets/icons/hour.png",
                                title: t.remaining,
                                amount: remaining,
                                backgroundColor: AppColors.softBlue,
                                footer: CustomGradientProgressBar(
                                  percentage: remainingPercent,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: AppSizes.paddingLg),

                      // Arama ve Filtre
                      Row(
                        children: [
                          Expanded(
                            child: SearchItems(
                              controller: _controller,
                              onChanged: checklistVM.setSearchQuery,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const FilterButton(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Liste
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ItemCard(
                        name: item.name,
                        category: item.category,
                        price: item.price ?? 0,
                        rating: item.priority.toDouble(),
                        isBought: item.isChecked,
                        onCheckToggle: (checked) {
                          final updatedItem = item.copyWith(isChecked: checked);
                          checklistVM.updateItem(updatedItem);
                        },
                        onEdit: () {
                          context.router.push(AddEditItemRoute(
                            item: item,
                            roomId: widget.roomId,
                          ));
                        },
                        onDelete: () {
                          checklistVM.deleteItem(item.id);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      // FAB
      floatingActionButton: SizedBox(
        width: AppSizes.widthXl,
        height: AppSizes.heightXl,
        child: FloatingActionButton(
          onPressed: () {
            context.router.push(AddEditItemRoute(roomId: widget.roomId));
          },
          backgroundColor: AppColors.primary,
          shape: const CircleBorder(),
          child: const Icon(Icons.add, color: AppColors.white, size: 32),
        ),
      ),
    );
  }
}
