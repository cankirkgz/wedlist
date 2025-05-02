import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ChecklistScreen extends StatelessWidget {
  final String roomId;

  const ChecklistScreen({
    super.key,
    @PathParam('roomId') required this.roomId, // AutoRoute için parametre
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Checklist")),
      body: Center(
        child: Text("Room ID: $roomId"),
      ),
    );
  }
}
