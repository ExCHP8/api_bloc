import 'package:flutter_test/flutter_test.dart';
import 'package:api_bloc/api_bloc.dart';

class MockSendResponse {
  final dynamic data;

  MockSendResponse(this.data);
}

class StatusModel {
  final String status;
  final String message;

  StatusModel(this.status, this.message);

  factory StatusModel.fromJson(Map<String, dynamic> json) {
    return StatusModel(json['status'], json['message']);
  }
}

class MockSendController extends SendController {
  bool success = true;

  @override
  Future<void> onRequest(Map<String, dynamic> args) async {
    await Future.delayed(const Duration(seconds: 1));

    if (success) {
      final response = MockSendResponse(
          {'status': 'success', 'message': 'Operation successful'});
      emit(SendSuccessState<StatusModel>(
          message: 'Operation successful',
          data: StatusModel.fromJson(response.data)));
    } else {
      throw 'Mocked error';
    }
  }
}

void main() {
  group('SendController', () {
    late MockSendController mockSendController;

    setUp(() {
      mockSendController = MockSendController();
    });

    test('Validate Initial State', () {
      expect(mockSendController.value, isA<SendIdleState>());
    });

    test('Validate Success State', () async {
      await mockSendController.run();
      expect(mockSendController.value, isA<SendSuccessState<StatusModel>>());
      expect(mockSendController.value.data, isA<StatusModel>());
      expect(mockSendController.value.message, isNotEmpty);
      expect(mockSendController.value.message, equals('Operation successful'));
    });

    test('Validate Error State', () async {
      mockSendController.success = false;
      await mockSendController.run();
      expect(mockSendController.value, isA<SendErrorState>());
      expect(mockSendController.value.message, isNotEmpty);
      expect(mockSendController.value.message, equals('Mocked error'));
      expect(mockSendController.value.data, isA<StackTrace>());
    });

    test('Validate AutoDispose Value', () {
      expect(mockSendController.autoDispose, isTrue);
    });
  });
}
