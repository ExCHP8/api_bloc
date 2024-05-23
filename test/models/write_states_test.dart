import 'package:flutter_test/flutter_test.dart';
import 'package:api_bloc/api_bloc.dart';

void main() {
  group('WriteStates', () {
    test('Validate Idle State', () {
      const writeStates = WriteIdleState<String>();
      expect(writeStates.type, equals(WriteStateType.idle));
      expect(writeStates.message, isEmpty);
      expect(writeStates.data, isNull);
      expect(
          writeStates.toJSON,
          equals({
            'message': '',
            'data': null,
            'type': {'name': 'idle', 'index': 0} // Corrected index for idle
          }));
      expect(
          writeStates.toString(),
          equals(
              'WriteIdleState<String>(message: , data: null, type: {name: idle, index: 0})'));
    });

    test('Validate Loading State', () {
      const customMessage = 'Custom Message';
      const customData = 0.5;
      const writeStates =
          WriteLoadingState<double>(message: customMessage, data: customData);
      expect(writeStates.type, equals(WriteStateType.loading));
      expect(writeStates.message, equals(customMessage));
      expect(writeStates.data, isA<double>());
      expect(writeStates.data, equals(customData));
      expect(
          writeStates.toJSON,
          equals({
            'message': customMessage,
            'data': customData,
            'type': {
              'name': 'loading',
              'index': 1
            } // Corrected index for loading
          }));
      expect(
          writeStates.toString(),
          equals(
              'WriteLoadingState<double>(message: $customMessage, data: $customData, type: {name: loading, index: 1})'));
    });

    test('Validate Success State', () {
      const customMessage = 'Custom Message';
      const customData = 'Success';
      const writeStates =
          WriteSuccessState<String>(data: customData, message: customMessage);
      expect(writeStates.type, equals(WriteStateType.success));
      expect(writeStates.message, equals(customMessage));
      expect(writeStates.data, isA<String>());
      expect(writeStates.data, equals(customData));
      expect(
          writeStates.toJSON,
          equals({
            'message': customMessage,
            'data': customData,
            'type': {
              'name': 'success',
              'index': 2
            } // Corrected index for success
          }));
      expect(
          writeStates.toString(),
          equals(
              'WriteSuccessState<String>(message: $customMessage, data: $customData, type: {name: success, index: 2})'));
    });

    test('Validate Failed State', () {
      const customMessage = 'Custom Message';
      const customData = 'Failed';
      const writeStates =
          WriteFailedState<String>(data: customData, message: customMessage);
      expect(writeStates.type, equals(WriteStateType.failed));
      expect(writeStates.message, equals(customMessage));
      expect(writeStates.data, isA<String>());
      expect(writeStates.data, equals(customData));
      expect(
          writeStates.toJSON,
          equals({
            'message': customMessage,
            'data': customData,
            'type': {'name': 'failed', 'index': 3} // Corrected index for failed
          }));
      expect(
          writeStates.toString(),
          equals(
              'WriteFailedState<String>(message: $customMessage, data: $customData, type: {name: failed, index: 3})'));
    });

    test('Validate Error State', () {
      const customMessage = 'Custom Message';
      const customData = 'Error';
      const writeStates =
          WriteErrorState<String>(data: customData, message: customMessage);
      expect(writeStates.type, equals(WriteStateType.error));
      expect(writeStates.message, equals(customMessage));
      expect(writeStates.data, isA<String>());
      expect(writeStates.data, equals(customData));
      expect(
          writeStates.toJSON,
          equals({
            'message': customMessage,
            'data': customData,
            'type': {'name': 'error', 'index': 4} // Corrected index for error
          }));
      expect(
          writeStates.toString(),
          equals(
              'WriteErrorState<String>(message: $customMessage, data: $customData, type: {name: error, index: 4})'));
    });

    test('Validate Equality', () {
      const originalWriteStates = WriteLoadingState<int>();
      final decodedWriteStates =
          WriteStates.fromJSON<int>(originalWriteStates.toJSON);
      expect(decodedWriteStates.type, equals(originalWriteStates.type));
      expect(decodedWriteStates.message, equals(originalWriteStates.message));
      expect(decodedWriteStates.data, equals(originalWriteStates.data));
      expect(decodedWriteStates, equals(originalWriteStates));
    });
  });
}
