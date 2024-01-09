part of '../example.dart';

class SendExampleUpdateController extends SendController {
  @override
  Future<void> request(Map<String, dynamic> args) async {
    // Delay to make the loading state more noticable.
    await Future.delayed(const Duration(milliseconds: 300));

    // Emit your success and failed state here ↓↓
  }

  @override
  bool get autoDispose => false;
}
