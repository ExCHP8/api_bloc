part of '../post.dart';

class CreateUserModel {
  const CreateUserModel({required this.id, required this.createdAt});
  final String id;
  final DateTime createdAt;

  static CreateUserModel fromJSON(Map<String, dynamic> value) {
    return CreateUserModel(
      id: value["id"] ?? '0',
      createdAt: DateTime.tryParse(value["created_at"] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> get toJSON {
    return {
      'id': id,
      'created_at': createdAt,
    };
  }

  @override
  String toString() =>
      '$runtimeType${toJSON.entries.map((e) => '${e.key}: ${e.value}')}';
}
