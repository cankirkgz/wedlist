import 'package:cloud_firestore/cloud_firestore.dart';

class RoomModel {
  final String id;
  final String roomName;
  final String createdBy;
  final DateTime createdAt;
  final List<String> participants;
  final int totalItems;
  final int completedItems;

  RoomModel({
    required this.id,
    required this.roomName,
    required this.createdBy,
    required this.createdAt,
    required this.participants,
    required this.totalItems,
    required this.completedItems,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json, String id) {
    return RoomModel(
      id: id,
      roomName: json['roomName'] as String,
      createdBy: json['createdBy'] as String,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      participants: List<String>.from(json['participants'] ?? []),
      totalItems: json['totalItems'] ?? 0,
      completedItems: json['completedItems'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'roomName': roomName,
      'createdBy': createdBy,
      'createdAt': createdAt,
      'participants': participants,
      'totalItems': totalItems,
      'completedItems': completedItems,
    };
  }
}
