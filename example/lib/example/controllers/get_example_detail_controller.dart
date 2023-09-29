part of '../example.dart';

class GetExampleDetailController extends GetController {

  @override
  Future<void> request({required Map<String, dynamic> args}) async {
    // Delay to make the loading state more noticable.
    await Future.delayed(const Duration(milliseconds: 300));

    // Emit your success state here ↓↓
  }

  @override
  bool get autoDispose => false;
}

