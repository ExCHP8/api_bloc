part of '../post.dart';

class CreateUserController extends WriteController {
  final TextEditingController name = TextEditingController();
  final TextEditingController job = TextEditingController();

  @override
  Future<void> onRequest(Map<String, dynamic> args) async {
    if (name.text.isEmpty) {
      emit(WriteFailedState(message: 'Name cannot be empty', data: name));
    } else if (job.text.isEmpty) {
      emit(WriteFailedState(message: 'Job cannot be empty', data: job));
    } else {
      await Future.delayed(const Duration(seconds: 1));

      Response response = await Dio().post(
        'https://reqres.in/api/users/2',
        data: FormData.fromMap({
          'name': name.text,
          'job': job.text,
        }),
        onReceiveProgress: (received, total) {
          emit(WriteLoadingState<double>(data: received / total));
        },
      );

      if (response.statusCode == 201) {
        emit(WriteSuccessState<CreateUserModel>(
            data: CreateUserModel.fromJSON(response.data)));
      } else {
        emit(WriteFailedState(
            data: response.data,
            message: "Expected response code output is 201"));
      }
    }
  }

  @override
  void dispose() {
    name.dispose();
    job.dispose();
    super.dispose();
  }
}
