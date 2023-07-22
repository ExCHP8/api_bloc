part of 'page.dart';

class ExampleRequest extends FetchController {
  @override
  Future<void> request() async {
    await Future.delayed(const Duration(seconds: 1));
    Response response = await Dio().get('https://reqres.in/api/users/2',
        onReceiveProgress: (current, total) =>
            emit(FetchLoadingState(data: current / total)));
    final model = ExampleModel.fromJson(response.data);
    emit(FetchSuccessState(data: model));
  }
}
