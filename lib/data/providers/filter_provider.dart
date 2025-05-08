import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wedlist/features/checklist/viewmodel/filter_viewmodel.dart';

final filterProvider =
    StateNotifierProvider<FilterViewModel, FilterState>((ref) {
  return FilterViewModel();
});
