import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Kullanıcının arama çubuğuna yazdığı metin
final searchQueryProvider = StateProvider<String>((ref) => '');
