part of 'post_page.dart';

class CreateUserModel {
  const CreateUserModel(
      {required this.name,
      required this.job,
      required this.id,
      required this.createdAt});
  final String name, job, id;
  final DateTime createdAt;

  factory CreateUserModel.fromJson(Map<String, dynamic> value) {
    return CreateUserModel(
        name: value["name"] as String,
        job: value["job"] as String,
        id: value["id"] as String,
        createdAt: DateTime.parse(value["createdAt"] as String));
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'job': job, 'created_at': createdAt};
  }

  @override
  String toString() =>
      '$runtimeType${toJson().entries.map((e) => '${e.key}: ${e.value}')}';
}
