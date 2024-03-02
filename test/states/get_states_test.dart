import 'package:flutter_test/flutter_test.dart';
import 'package:api_bloc/api_bloc.dart';

void main() {
  group('GetStates', () {
    test('Validate Loading State', () {
      const getStates = GetLoadingState<String>();
      expect(getStates.type, equals(GetStateType.loading));
      expect(getStates.message, isEmpty);
      expect(getStates.data, isNull);
      expect(
          getStates.toJSON,
          equals({
            'message': '',
            'data': null,
            'type': {'name': 'loading', 'index': 0}
          }));
      expect(
          getStates.toString(),
          equals(
              'GetLoadingState<String>(message: , data: null, type: {name: loading, index: 0})'));
    });

    test('Validate Success State', () {
      const customMessage = 'Custom Message';
      const customData = 'Success';
      const getStates =
          GetSuccessState<String>(data: customData, message: customMessage);
      expect(getStates.type, equals(GetStateType.success));
      expect(getStates.message, equals(customMessage));
      expect(getStates.data, isA<String>());
      expect(getStates.data, equals(customData));
      expect(
          getStates.toJSON,
          equals({
            'message': customMessage,
            'data': customData,
            'type': {'name': 'success', 'index': 1}
          }));
      expect(
          getStates.toString(),
          equals(
              'GetSuccessState<String>(message: $customMessage, data: $customData, type: {name: success, index: 1})'));
    });

    test('Validate Error State', () {
      const customMessage = 'Custom Message';
      const customData = 'Error';
      const getStates =
          GetErrorState<String>(data: customData, message: customMessage);
      expect(getStates.type, equals(GetStateType.error));
      expect(getStates.message, equals(customMessage));
      expect(getStates.data, isA<String>());
      expect(getStates.data, equals(customData));
      expect(
          getStates.toJSON,
          equals({
            'message': customMessage,
            'data': customData,
            'type': {'name': 'error', 'index': 2}
          }));
      expect(
          getStates.toString(),
          equals(
              'GetErrorState<String>(message: $customMessage, data: $customData, type: {name: error, index: 2})'));
    });

    test('Validate Equality', () {
      const originalGetStates = GetLoadingState<int>();
      final decodedGetStates =
          GetStates.fromJSON<int>(originalGetStates.toJSON);
      expect(decodedGetStates.type, equals(originalGetStates.type));
      expect(decodedGetStates.message, equals(originalGetStates.message));
      expect(decodedGetStates.data, equals(originalGetStates.data));
      expect(decodedGetStates, equals(originalGetStates));
    });
  });
}
