part of 'page.dart';

class ExampleController extends FetchController {
  @override
  Future<void> request() async {
    await Future.delayed(const Duration(seconds: 1));
    final response = await Dio().get('https://reqres.in/api/users/2',
        onReceiveProgress: (received, total) {
      emit(FetchLoadingState<double>(data: received / total));
    });
    final model = ExampleModel.fromJson(response.data);
    emit(FetchSuccessState<ExampleModel>(data: model));
  }
}
