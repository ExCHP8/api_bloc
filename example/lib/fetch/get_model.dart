part of 'get_page.dart';

class GetUserModel {
  const GetUserModel(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.avatar});
  final int id;
  final String firstName, lastName, avatar;

  static GetUserModel fromJSON(Map<String, dynamic> value) {
    return GetUserModel(
      id: value['data']['id'] as int,
      firstName: value['data']['first_name'] as String,
      lastName: value['data']['last_name'] as String,
      avatar: value['data']['avatar'] as String,
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
