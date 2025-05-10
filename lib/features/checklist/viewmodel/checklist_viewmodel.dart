import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wedlist/data/repository/checklist_repository.dart';
import 'package:wedlist/features/checklist/model/checklist_item_model.dart';

class ChecklistViewModel extends AutoDisposeAsyncNotifier<List<ChecklistItem>> {
  final ChecklistRepository _repository = ChecklistRepository();
  late StreamSubscription<List<ChecklistItem>> _subscription;
  String _roomCode = '';

  @override
  FutureOr<List<ChecklistItem>> build() async {
    // Stream aboneliği sadece setRoomCode çağrıldığında başlatılacak
    return [];
  }

  /// Oda kodunu alıp Firestore stream'ini başlat
  void setRoomCode(String roomCode) {
    _roomCode = roomCode;

    _subscription = _repository.streamItems(roomCode).listen((items) {
      state = AsyncData(items);
    });
  }

  Future<void> addItem(ChecklistItem item) =>
      _repository.addItem(_roomCode, item);

  Future<void> updateItem(ChecklistItem item) async {
    print("Güncelleme başlıyor - Item ID: ${item.id}");
    print("Güncellenecek item verileri:");
    print("isPurchased değeri: ${item.isPurchased}");
    print("Ham veri: ${item.toMap()}");

    try {
      // Önce mevcut state'i al
      final currentState = state;
      if (currentState is AsyncData) {
        // Mevcut item'ı bul
        final currentItems = currentState.value;
        if (currentItems != null) {
          final currentItem = currentItems.firstWhere((i) => i.id == item.id,
              orElse: () => item);

          // Sadece isPurchased değeri değiştiyse güncelle
          if (currentItem.isPurchased != item.isPurchased) {
            await _repository.updateItem(_roomCode, item);
            print("Güncelleme başarılı");
          } else {
            print("isPurchased değeri değişmedi, güncelleme yapılmadı");
          }
        }
      }
    } catch (e) {
      print("Güncelleme hatası: $e");
      rethrow;
    }

    print("-------------------");
  }

  Future<void> deleteItem(String id) => _repository.deleteItem(_roomCode, id);

  /// Oda değişirse eski stream'i kapat
  @override
  void dispose() {
    _subscription.cancel();
  }
}
