part of '../user.dart';

class UserUpdateController extends WriteController {
  @override
  Future<void> onRequest(Map<String, dynamic> args) async {
    // Delay to make the loading state more noticable.
    await Future.delayed(const Duration(milliseconds: 300));

    // Emit your success and failed state here ↓↓
    if (args['success'] ?? false) {
      emit(const WriteSuccessState<UserUpdateSuccessModel>(
          data: UserUpdateSuccessModel.test()));
    } else {
      emit(const WriteFailedState<UserUpdateFailedModel>(
          data: UserUpdateFailedModel.test()));
    }
  }
}
