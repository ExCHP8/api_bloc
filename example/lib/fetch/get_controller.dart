part of 'get_page.dart';

class GetUserController extends FetchController {
  @override
  Future<void> request({required Map<String, dynamic> args}) async {
    await Future.delayed(const Duration(seconds: 1));
    final response = await Dio().get('https://reqres.in/api/users/2',
        onReceiveProgress: (received, total) {
      emit(FetchLoadingState<double>(data: received / total));
    });

    final model = GetUserModel.fromJson(response.data);
    emit(FetchSuccessState<GetUserModel>(data: model));
  }
}
