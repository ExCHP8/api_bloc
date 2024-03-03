import 'package:flutter_test/flutter_test.dart';
import 'package:api_bloc/api_bloc.dart';

class MockResponse {
  final dynamic data;

  MockResponse(this.data);
}

class UserModel {
  final String userName;

  UserModel(this.userName);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(json['userName']);
  }
}

class MockReadController extends ReadController {
  bool success = true;

  @override
  Future<void> onRequest(Map<String, dynamic> args) async {
    await Future.delayed(const Duration(seconds: 1));
    if (success) {
      final response = MockResponse({'userName': 'John Doe'});
      emit(
          ReadSuccessState<UserModel>(data: UserModel.fromJson(response.data)));
    } else {
      throw 'Mocked error';
    }
  }
}

void main() {
  group('ReadController', () {
    late MockReadController mockReadController;

    setUp(() {
      mockReadController = MockReadController();
    });

    test('Validate Initial State', () {
      expect(mockReadController.value, isA<ReadLoadingState>());
    });

    test('Validate Success State', () async {
      await mockReadController.run();
      expect(mockReadController.value, isA<ReadSuccessState<UserModel>>());
      expect(mockReadController.value.data, isA<UserModel>());
      expect(
          (mockReadController.value as ReadSuccessState<UserModel>)
              .data!
              .userName,
          isNotEmpty);
      expect(
          (mockReadController.value as ReadSuccessState<UserModel>)
              .data!
              .userName,
          equals('John Doe'));
    });

    test('Validate Error State', () async {
      mockReadController.success = false;
      await mockReadController.run();
      expect(mockReadController.value, isA<ReadErrorState>());
      expect(mockReadController.value.message, isNotEmpty);
      expect(mockReadController.value.message, equals('Mocked error'));
      expect(mockReadController.value.data, isA<StackTrace>());
    });

    test('Validate AutoDispose Value', () {
      expect(mockReadController.autoDispose, isTrue);
    });

    test('Validate AutoRun Value', () {
      expect(mockReadController.autoRun, isTrue);
    });
  });
}
