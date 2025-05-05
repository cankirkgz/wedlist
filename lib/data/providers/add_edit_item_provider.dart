import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wedlist/features/checklist/viewmodel/add_edit_item_viewmodel.dart';

final addEditItemViewModelProvider = ChangeNotifierProvider(
  (ref) => AddEditItemViewModel(),
);
