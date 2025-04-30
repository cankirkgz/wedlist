import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:wedlist/app/router.dart';

final appRouter = AppRouter();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'WeddingList',
      routerConfig: appRouter.config(),
      debugShowCheckedModeBanner: false,
    );
  }
}
