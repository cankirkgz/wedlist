import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedlist/app/router.dart';
import 'firebase_options.dart'; // ✅ BU SATIRI EKLEDİK

final _appRouter = AppRouter();

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Firebase için zorunlu
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions
        .currentPlatform, // CLI tarafından oluşturulan yapı
  );
  runApp(const ProviderScope(child: MyApp())); // Riverpod kullanımı
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
      builder: (context, child) => child!,
      title: 'Flutter Font Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.robotoTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
