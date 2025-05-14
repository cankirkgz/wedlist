import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wedlist/data/repository/checklist_repository.dart';
import 'package:wedlist/features/checklist/model/checklist_item_model.dart';

class ChecklistViewModel extends AutoDisposeAsyncNotifier<List<ChecklistItem>> {
  final ChecklistRepository _repository = ChecklistRepository();
  late StreamSubscription<List<ChecklistItem>> _subscription;
  String _roomCode = '';

  @override
  FutureOr<List<ChecklistItem>> build() async {
    return []; // Stream bu aşamada başlatılmaz
  }

  Future<void> setRoomCode(String roomCode) async {
    _roomCode = roomCode;
    final connectivity = await Connectivity().checkConnectivity();

    if (connectivity != ConnectivityResult.none) {
      _subscription = _repository.streamItems(roomCode).listen((items) {
        state = AsyncData(items);
      });
      await _repository.syncUnsyncedItems(roomCode);
    } else {
      final localItems = await _repository.getLocalItems(roomCode);
      state = AsyncData(localItems);
    }
  }

  Future<void> addItem(ChecklistItem item) async {
    final connectivity = await Connectivity().checkConnectivity();
    if (connectivity != ConnectivityResult.none) {
      await _repository.addItem(_roomCode, item);
    } else {
      await _repository.saveToHive(item.copyWith(isSynced: false));
    }
  }

  Future<void> updateItem(ChecklistItem item) async {
    try {
      final connectivity = await Connectivity().checkConnectivity();
      if (connectivity != ConnectivityResult.none) {
        await _repository.updateItem(_roomCode, item);
      } else {
        await _repository.saveToHive(item.copyWith(isSynced: false));
      }

      // State güncelle (isteğe bağlı)
      final current = state;
      if (current is AsyncData<List<ChecklistItem>>) {
        final updatedList =
            current.value.map((i) => i.id == item.id ? item : i).toList();
        state = AsyncData(updatedList);
      }
    } catch (e) {
      print("ChecklistViewModel.updateItem Hata: $e");
    }
  }

  Future<void> deleteItem(String id) async {
    final connectivity = await Connectivity().checkConnectivity();
    await _repository.deleteItem(_roomCode, id);
    // Hive’dan zaten siliniyor

    // State'ten de çıkar
    final current = state;
    if (current is AsyncData<List<ChecklistItem>>) {
      final updatedList = current.value.where((i) => i.id != id).toList();
      state = AsyncData(updatedList);
    }
  }

  void addOrUpdateLocalItem(ChecklistItem item) {
    final current = state;
    if (current is AsyncData<List<ChecklistItem>>) {
      final items = [...current.value];
      final index = items.indexWhere((i) => i.id == item.id);

      if (index != -1) {
        items[index] = item;
      } else {
        items.add(item);
      }

      state = AsyncData(items);
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
  }
}
