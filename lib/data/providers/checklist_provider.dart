import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wedlist/features/checklist/model/checklist_item_model.dart';
import 'package:wedlist/features/checklist/viewmodel/checklist_viewmodel.dart';

final checklistProvider =
    AutoDisposeAsyncNotifierProvider<ChecklistViewModel, List<ChecklistItem>>(
  () => ChecklistViewModel(),
);
