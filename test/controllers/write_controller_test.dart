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

class MockWriteRequest extends WriteRequest {
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
  group('WriteRequest', () {
    late MockWriteRequest mockWriteRequest;

    setUp(() {
      mockWriteRequest = MockWriteRequest();
    });

    test('Validate Initial State', () {
      expect(mockWriteRequest.value, isA<WriteIdleState>());
    });

    test('Validate Success State', () async {
      await mockWriteRequest.run();
      expect(mockWriteRequest.value, isA<WriteSuccessState<StatusModel>>());
      expect(mockWriteRequest.value.data, isA<StatusModel>());
      expect(mockWriteRequest.value.message, isNotEmpty);
      expect(mockWriteRequest.value.message, equals('Operation successful'));
    });

    test('Validate Error State', () async {
      mockWriteRequest.success = false;
      await mockWriteRequest.run();
      expect(mockWriteRequest.value, isA<WriteErrorState>());
      expect(mockWriteRequest.value.message, isNotEmpty);
      expect(mockWriteRequest.value.message, equals('Mocked error'));
      expect(mockWriteRequest.value.data, isA<StackTrace>());
    });
  });
}
