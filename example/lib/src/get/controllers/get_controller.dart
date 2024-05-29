part of '../get.dart';

class GetUserController extends ReadController {
  @override
  Future<void> onRequest(Map<String, dynamic> args) async {
    // Mock Delay
    await Future.delayed(const Duration(seconds: 1));

    Response response = await Dio().get(
      'https://reqres.in/api/users/2',
      onReceiveProgress: (received, total) {
        emit(ReadLoadingState<double>(data: received / total));
      },
    );

    emit(ReadSuccessState<GetUserModel>(
        data: GetUserModel.fromJSON(response.data)));
  }
}
