import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wedlist/data/repository/checklist_repository.dart';
import '../model/checklist_item_model.dart';

class ChecklistViewModel extends Notifier<List<ChecklistItem>> {
  late ChecklistRepository _repository;
  late String _roomCode;

  @override
  List<ChecklistItem> build() {
    _repository = ChecklistRepository();
    _roomCode = '';
    return [];
  }

  void setRoomCode(String code) {
    _roomCode = code;
    _listenToItems();
  }

  void _listenToItems() {
    _repository.streamItems(_roomCode).listen((items) {
      state = items;
    });
  }

  Future<void> addItem(ChecklistItem item) async {
    await _repository.addItem(_roomCode, item);
  }

  Future<void> updateItem(ChecklistItem item) async {
    await _repository.updateItem(_roomCode, item);
  }

  Future<void> deleteItem(String itemId) async {
    await _repository.deleteItem(_roomCode, itemId);
  }
}
