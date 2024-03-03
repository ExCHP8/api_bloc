import 'package:flutter_test/flutter_test.dart';
import 'package:api_bloc/api_bloc.dart';

class MockWriteResponse {
  final dynamic data;

  MockWriteResponse(this.data);
}

class StatusModel {
  final String status;
  final String message;

  StatusModel(this.status, this.message);

  factory StatusModel.fromJson(Map<String, dynamic> json) {
    return StatusModel(json['status'], json['message']);
  }
}

class MockWriteController extends WriteController {
  bool success = true;

  @override
  Future<void> onRequest(Map<String, dynamic> args) async {
    await Future.delayed(const Duration(seconds: 1));

    if (success) {
      final response = MockWriteResponse(
          {'status': 'success', 'message': 'Operation successful'});
      emit(WriteSuccessState<StatusModel>(
          message: 'Operation successful',
          data: StatusModel.fromJson(response.data)));
    } else {
      throw 'Mocked error';
    }
  }
}

void main() {
  group('WriteController', () {
    late MockWriteController mockWriteController;

    setUp(() {
      mockWriteController = MockWriteController();
    });

    test('Validate Initial State', () {
      expect(mockWriteController.value, isA<WriteIdleState>());
    });

    test('Validate Success State', () async {
      await mockWriteController.run();
      expect(mockWriteController.value, isA<WriteSuccessState<StatusModel>>());
      expect(mockWriteController.value.data, isA<StatusModel>());
      expect(mockWriteController.value.message, isNotEmpty);
      expect(mockWriteController.value.message, equals('Operation successful'));
    });

    test('Validate Error State', () async {
      mockWriteController.success = false;
      await mockWriteController.run();
      expect(mockWriteController.value, isA<WriteErrorState>());
      expect(mockWriteController.value.message, isNotEmpty);
      expect(mockWriteController.value.message, equals('Mocked error'));
      expect(mockWriteController.value.data, isA<StackTrace>());
    });

    test('Validate AutoDispose Value', () {
      expect(mockWriteController.autoDispose, isTrue);
    });
  });
}
