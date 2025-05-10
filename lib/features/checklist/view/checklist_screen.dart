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
import 'package:wedlist/data/providers/search_query_provider.dart';
import 'package:wedlist/features/shared/components/atoms/filter_button.dart';
import 'package:wedlist/features/shared/components/atoms/search_items.dart';
import 'package:wedlist/features/shared/components/molecules/custom_gradient_progress_bar.dart';
import 'package:wedlist/features/shared/components/molecules/financial_status_card.dart';
import 'package:wedlist/features/shared/components/molecules/item_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

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
  late BannerAd _bannerAd;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();

    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-3195576697663098/1913688170',
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) => debugPrint('Ad loaded'),
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          debugPrint('Ad failed to load: $error');
        },
      ),
    )..load();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(checklistProvider.notifier).setRoomCode(widget.roomId);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    final authVM = ref.watch(authProvider.notifier);
    final roomAsync = ref.watch(roomProvider);
    final checklistVM = ref.read(checklistProvider.notifier);
    final items = ref.watch(filteredChecklistProvider);

    // Finansal hesaplamalar
    final spent = items
        .where((i) => i.isPurchased)
        .fold(0.0, (sum, i) => sum + (i.price ?? 0));
    final remaining = items
        .where((i) => !i.isPurchased)
        .fold(0.0, (sum, i) => sum + (i.price ?? 0));
    final total = spent + remaining;
    final remainingPercent = total == 0 ? 0 : remaining / total;

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
          child: CustomScrollView(
            slivers: [
              // 🟩 ÜST BAR
              SliverToBoxAdapter(
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    border: Border(
                      bottom: BorderSide(color: AppColors.lightGrey, width: 1),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: AppSizes.paddingLg,
                      horizontal: AppSizes.paddingXl,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Başlık ve çıkış
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            roomAsync.when(
                              data: (room) => Expanded(
                                child: Text(
                                  room?.roomName ?? t.checklist,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.inter(
                                    fontSize: AppSizes.fontLg,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryText,
                                  ),
                                ),
                              ),
                              loading: () => Text(t.loading),
                              error: (e, _) => Text(t.error),
                            ),
                            Flexible(
                              child: PopupMenuButton<String>(
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
                                      value: 'settings',
                                      child: Text(t.settings)),
                                  PopupMenuItem(
                                      value: 'logout', child: Text(t.logout)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Divider(color: AppColors.lightGrey),
                        SizedBox(height: AppSizes.paddingXs),
                        // Finansal kartlar
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
                                    percentage: remainingPercent.toDouble(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: AppSizes.paddingLg),
                        // Arama ve Filtre
                        Row(
                          children: [
                            Expanded(
                              child: SearchItems(
                                controller: _controller,
                                onChanged: (q) {
                                  ref.read(searchQueryProvider.notifier).state =
                                      q;
                                },
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
              ),

              // 🟦 ÜRÜN LİSTESİ
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final item = items[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ItemCard(
                        name: item.name,
                        category: item.category,
                        price: item.price ?? 0,
                        rating: item.priority.toDouble(),
                        isBought: item.isPurchased,
                        onCheckToggle: (checked) {
                          final updatedItem =
                              item.copyWith(isPurchased: checked);
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
                  childCount: items.length,
                ),
              ),
            ],
          ),
        ),
      ),

      // ➕ FAB
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

      // 📢 Banner Ad
      bottomNavigationBar: _bannerAd.responseInfo == null
          ? const SizedBox.shrink()
          : SizedBox(
              width: _bannerAd.size.width.toDouble(),
              height: _bannerAd.size.height.toDouble(),
              child: AdWidget(ad: _bannerAd),
            ),
    );
  }
}
