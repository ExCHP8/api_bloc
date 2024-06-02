part of '../auth.dart';

class AuthUpdateController extends WriteController {
  @override
  Future<void> onRequest(Map<String, dynamic> args) async {
    // Delay to make the loading state more noticable.
    await Future.delayed(const Duration(milliseconds: 300));

    // Emit your success and failed state here ↓↓
    if (args['success'] ?? false) {
    emit(const WriteSuccessState<AuthUpdateSuccessModel>(
        data: AuthUpdateSuccessModel.test()));
    } else {
    emit(const WriteFailedState<AuthUpdateFailedModel>(
        data: AuthUpdateFailedModel.test()));
    }
  }
}
