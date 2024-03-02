import 'package:flutter_test/flutter_test.dart';
import 'package:api_bloc/api_bloc.dart';

void main() {
  group('SendStates', () {
    test('Validate Idle State', () {
      const sendStates = SendIdleState<String>();
      expect(sendStates.type, equals(SendStateType.idle));
      expect(sendStates.message, isEmpty);
      expect(sendStates.data, isNull);
      expect(
          sendStates.toJSON,
          equals({
            'message': '',
            'data': null,
            'type': {'name': 'idle', 'index': 0} // Corrected index for idle
          }));
      expect(
          sendStates.toString(),
          equals(
              'SendIdleState<String>(message: , data: null, type: {name: idle, index: 0})'));
    });

    test('Validate Loading State', () {
      const customMessage = 'Custom Message';
      const customData = 0.5;
      const sendStates =
          SendLoadingState<double>(message: customMessage, data: customData);
      expect(sendStates.type, equals(SendStateType.loading));
      expect(sendStates.message, equals(customMessage));
      expect(sendStates.data, isA<double>());
      expect(sendStates.data, equals(customData));
      expect(
          sendStates.toJSON,
          equals({
            'message': customMessage,
            'data': customData,
            'type': {
              'name': 'loading',
              'index': 1
            } // Corrected index for loading
          }));
      expect(
          sendStates.toString(),
          equals(
              'SendLoadingState<double>(message: $customMessage, data: $customData, type: {name: loading, index: 1})'));
    });

    test('Validate Success State', () {
      const customMessage = 'Custom Message';
      const customData = 'Success';
      const sendStates =
          SendSuccessState<String>(data: customData, message: customMessage);
      expect(sendStates.type, equals(SendStateType.success));
      expect(sendStates.message, equals(customMessage));
      expect(sendStates.data, isA<String>());
      expect(sendStates.data, equals(customData));
      expect(
          sendStates.toJSON,
          equals({
            'message': customMessage,
            'data': customData,
            'type': {
              'name': 'success',
              'index': 2
            } // Corrected index for success
          }));
      expect(
          sendStates.toString(),
          equals(
              'SendSuccessState<String>(message: $customMessage, data: $customData, type: {name: success, index: 2})'));
    });

    test('Validate Failed State', () {
      const customMessage = 'Custom Message';
      const customData = 'Failed';
      const sendStates =
          SendFailedState<String>(data: customData, message: customMessage);
      expect(sendStates.type, equals(SendStateType.failed));
      expect(sendStates.message, equals(customMessage));
      expect(sendStates.data, isA<String>());
      expect(sendStates.data, equals(customData));
      expect(
          sendStates.toJSON,
          equals({
            'message': customMessage,
            'data': customData,
            'type': {'name': 'failed', 'index': 3} // Corrected index for failed
          }));
      expect(
          sendStates.toString(),
          equals(
              'SendFailedState<String>(message: $customMessage, data: $customData, type: {name: failed, index: 3})'));
    });

    test('Validate Error State', () {
      const customMessage = 'Custom Message';
      const customData = 'Error';
      const sendStates =
          SendErrorState<String>(data: customData, message: customMessage);
      expect(sendStates.type, equals(SendStateType.error));
      expect(sendStates.message, equals(customMessage));
      expect(sendStates.data, isA<String>());
      expect(sendStates.data, equals(customData));
      expect(
          sendStates.toJSON,
          equals({
            'message': customMessage,
            'data': customData,
            'type': {'name': 'error', 'index': 4} // Corrected index for error
          }));
      expect(
          sendStates.toString(),
          equals(
              'SendErrorState<String>(message: $customMessage, data: $customData, type: {name: error, index: 4})'));
    });

    test('Validate Equality', () {
      const originalSendStates = SendLoadingState<int>();
      final decodedSendStates =
          SendStates.fromJSON<int>(originalSendStates.toJSON);
      expect(decodedSendStates.type, equals(originalSendStates.type));
      expect(decodedSendStates.message, equals(originalSendStates.message));
      expect(decodedSendStates.data, equals(originalSendStates.data));
      expect(decodedSendStates, equals(originalSendStates));
    });
  });
}
