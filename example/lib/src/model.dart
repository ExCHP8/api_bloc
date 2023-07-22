part of 'page.dart';

class ExampleModel {
  const ExampleModel(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.avatar});
  final int id;
  final String firstName, lastName, avatar;

  ExampleModel.fromJson(Map<String, dynamic> value)
      : this(
            id: value['data']['id'] as int,
            firstName: value['data']['first_name'] as String,
            lastName: value['data']['last_name'] as String,
            avatar: value['data']['avatar'] as String);
}
