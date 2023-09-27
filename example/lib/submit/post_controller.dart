part of 'post_page.dart';

class CreateUserController extends SubmitController {
  @override
  bool get autoDispose => false;

  @override
  Future<void> request({required Map<String, dynamic> args}) async {
    await Future.delayed(const Duration(seconds: 1));
    final response = await Dio().post('https://reqres.in/api/users/2',
        data: FormData.fromMap({"name": args[0], "job": args[1]}));

    if (response.statusCode == 201) {
      final model = CreateUserModel.fromJson(response.data);
      emit(SubmitSuccessState<CreateUserModel>(data: model));
    } else {
      emit(SubmitFailedState<Map<String, dynamic>>(
          data: response.data,
          message: "Expected response code output is 201"));
    }
  }
}
