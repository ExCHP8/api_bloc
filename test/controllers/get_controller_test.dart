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

class MockGetController extends GetController {
  bool success = true;

  @override
  Future<void> onRequest(Map<String, dynamic> args) async {
    await Future.delayed(const Duration(seconds: 1));
    if (success) {
      final response = MockResponse({'userName': 'John Doe'});
      emit(GetSuccessState<UserModel>(data: UserModel.fromJson(response.data)));
    } else {
      throw 'Mocked error';
    }
  }
}

void main() {
  group('GetController', () {
    late MockGetController mockGetController;

    setUp(() {
      mockGetController = MockGetController();
    });

    test('Validate Initial State', () {
      expect(mockGetController.value, isA<GetLoadingState>());
    });

    test('Validate Success State', () async {
      await mockGetController.run();
      expect(mockGetController.value, isA<GetSuccessState<UserModel>>());
      expect(mockGetController.value.data, isA<UserModel>());
      expect(
          (mockGetController.value as GetSuccessState<UserModel>)
              .data!
              .userName,
          isNotEmpty);
      expect(
          (mockGetController.value as GetSuccessState<UserModel>)
              .data!
              .userName,
          equals('John Doe'));
    });

    test('Validate Error State', () async {
      mockGetController.success = false;
      await mockGetController.run();
      expect(mockGetController.value, isA<GetErrorState>());
      expect(mockGetController.value.message, isNotEmpty);
      expect(mockGetController.value.message, equals('Mocked error'));
      expect(mockGetController.value.data, isA<StackTrace>());
    });

    test('Validate AutoDispose Value', () {
      expect(mockGetController.autoDispose, isTrue);
    });

    test('Validate AutoRun Value', () {
      expect(mockGetController.autoRun, isTrue);
    });
  });
}
