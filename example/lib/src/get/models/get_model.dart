part of '../get.dart';

class GetUserModel {
  const GetUserModel(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.avatar});
  final int id;
  final String firstName, lastName, avatar;
  String get fullName => '$firstName $lastName';

  static GetUserModel fromJSON(Map<String, dynamic> value) {
    return GetUserModel(
      id: value['data']?['id'] ?? 0,
      firstName: value['data']?['first_name'] ?? 'FIRST_NAME',
      lastName: value['data']?['last_name'] ?? 'LAST_NAME',
      avatar: value['data']?['avatar'] ?? 'https:/placehold.co/300x300',
    );
  }

  Map<String, dynamic> get toJSON {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'avatar': avatar
    };
  }

  @override
  String toString() =>
      '$runtimeType${toJSON.entries.map((e) => '${e.key}: ${e.value}')}';
}
