part of 'get_page.dart';

class GetUserController extends GetController {
  @override
  Future<void> onRequest(Map<String, dynamic> args) async {
    await Future.delayed(const Duration(seconds: 1));
    final response = await Dio().get(
      'https://reqres.in/api/users/2',
      onReceiveProgress: (received, total) {
        emit(GetLoadingState<double>(data: received / total));
      },
    );

    final model = GetUserModel.fromJSON(response.data);
    emit(GetSuccessState<GetUserModel>(data: model));
  }
}
