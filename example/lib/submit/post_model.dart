part of 'post_page.dart';

class CreateUserModel {
  const CreateUserModel({required this.id, required this.createdAt});
  final String id;
  final DateTime createdAt;

  factory CreateUserModel.fromJson(Map<String, dynamic> value) {
    return CreateUserModel(
        id: value["id"] as String,
        createdAt: DateTime.parse(value["createdAt"] as String));
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'created_at': createdAt};
  }

  @override
  String toString() =>
      '$runtimeType${toJson().entries.map((e) => '${e.key}: ${e.value}')}';
}
