part of '../auth.dart';

class AuthDataController extends ReadController {
  @override
  Future<void> onRequest(Map<String, dynamic> args) async {
    // Delay to make the loading state more noticable.
    await Future.delayed(const Duration(milliseconds: 300));

    // Emit your success state here ↓↓
    emit(const ReadSuccessState<AuthDataModel>(data: AuthDataModel.test()));
  }
}
