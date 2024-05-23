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

class MockReadRequest extends ReadRequest {
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
  group('ReadRequest', () {
    late MockReadRequest mockReadRequest;

    setUp(() {
      mockReadRequest = MockReadRequest();
    });

    test('Validate Initial State', () {
      expect(mockReadRequest.value, isA<ReadLoadingState>());
    });

    test('Validate Success State', () async {
      await mockReadRequest.run();
      expect(mockReadRequest.value, isA<ReadSuccessState<UserModel>>());
      expect(mockReadRequest.value.data, isA<UserModel>());
      expect(
          (mockReadRequest.value as ReadSuccessState<UserModel>).data!.userName,
          isNotEmpty);
      expect(
          (mockReadRequest.value as ReadSuccessState<UserModel>).data!.userName,
          equals('John Doe'));
    });

    test('Validate Error State', () async {
      mockReadRequest.success = false;
      await mockReadRequest.run();
      expect(mockReadRequest.value, isA<ReadErrorState>());
      expect(mockReadRequest.value.message, isNotEmpty);
      expect(mockReadRequest.value.message, equals('Mocked error'));
      expect(mockReadRequest.value.data, isA<StackTrace>());
    });

    test('Validate AutoRun Value', () {
      expect(mockReadRequest.autorun, isTrue);
    });
  });
}
