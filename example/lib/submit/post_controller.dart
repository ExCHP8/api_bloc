part of 'post_page.dart';

class CreateUserController extends WriteRequest {
  @override
  Future<void> onRequest(Map<String, dynamic> args) async {
    // Mock Delay
    await Future.delayed(const Duration(seconds: 1));

    final response = await Dio().post(
      'https://reqres.in/api/users/2',
      data: FormData.fromMap(args),
    );

    if (response.statusCode == 201) {
      emit(WriteSuccessState<CreateUserModel>(
          data: CreateUserModel.fromJSON(response.data)));
    } else {
      emit(WriteFailedState<Map<String, dynamic>>(
          data: response.data,
          message: "Expected response code output is 201"));
    }
  }
}
