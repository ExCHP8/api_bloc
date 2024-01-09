part of 'post_page.dart';

class CreateUserController extends SendController {
  @override
  bool get autoDispose => false;

  @override
  Future<void> request(Map<String, dynamic> args) async {
    await Future.delayed(const Duration(seconds: 1));
    final response = await Dio().post(
      'https://reqres.in/api/users/2',
      data: FormData.fromMap(
        {
          "name": args['name'],
          "job": args['job'],
        },
      ),
    );

    if (response.statusCode == 201) {
      final model = CreateUserModel.fromJson(response.data);
      emit(SendSuccessState<CreateUserModel>(data: model));
    } else {
      emit(SendFailedState<Map<String, dynamic>>(
          data: response.data,
          message: "Expected response code output is 201"));
    }
  }
}
