part of '../user.dart';

class UserDataController extends ReadController {
  @override
  Future<void> onRequest(Map<String, dynamic> args) async {
    // Delay to make the loading state more noticable.
    await Future.delayed(const Duration(milliseconds: 300));

    // Emit your success state here ↓↓
    emit(const ReadSuccessState<UserDataModel>(data: UserDataModel.test()));
  }
}
