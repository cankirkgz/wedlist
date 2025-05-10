import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Satın alma durumları
enum PurchaseStatus { all, purchased, notPurchased }

class FilterState {
  final String? selectedCategory;
  final int? selectedPriority;
  final PurchaseStatus status;

  FilterState({
    this.selectedCategory,
    this.selectedPriority,
    this.status = PurchaseStatus.all,
  });

  FilterState copyWith({
    String? selectedCategory,
    int? selectedPriority,
    PurchaseStatus? status,
  }) {
    return FilterState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedPriority: selectedPriority ?? this.selectedPriority,
      status: status ?? this.status,
    );
  }

  static FilterState initial() => FilterState();
}

class FilterViewModel extends StateNotifier<FilterState> {
  FilterViewModel() : super(FilterState.initial());

  void setCategory(String category) {
    state = state.copyWith(selectedCategory: category);
  }

  void setPriority(int priority) {
    state = state.copyWith(selectedPriority: priority);
  }

  void setStatus(PurchaseStatus status) {
    state = state.copyWith(status: status);
  }

  void reset() {
    state = FilterState.initial();
  }
}

final filterProvider =
    StateNotifierProvider<FilterViewModel, FilterState>((ref) {
  return FilterViewModel();
});
