
// void main() {
//   group('ReadStates', () {
//     test('Validate Loading State', () {
//       const readStates = ReadLoadingState<String>();
//       expect(readStates.type, equals(ReadStateType.loading));
//       expect(readStates.message, isEmpty);
//       expect(readStates.data, isNull);
//       expect(
//           readStates.toJSON,
//           equals({
//             'message': '',
//             'data': null,
//             'type': {'name': 'loading', 'index': 0}
//           }));
//       expect(
//           readStates.toString(),
//           equals(
//               'ReadLoadingState<String>(message: , data: null, type: {name: loading, index: 0})'));
//     });

//     test('Validate Success State', () {
//       const customMessage = 'Custom Message';
//       const customData = 'Success';
//       const readStates =
//           ReadSuccessState<String>(data: customData, message: customMessage);
//       expect(readStates.type, equals(ReadStateType.success));
//       expect(readStates.message, equals(customMessage));
//       expect(readStates.data, isA<String>());
//       expect(readStates.data, equals(customData));
//       expect(
//           readStates.toJSON,
//           equals({
//             'message': customMessage,
//             'data': customData,
//             'type': {'name': 'success', 'index': 1}
//           }));
//       expect(
//           readStates.toString(),
//           equals(
//               'ReadSuccessState<String>(message: $customMessage, data: $customData, type: {name: success, index: 1})'));
//     });

//     test('Validate Error State', () {
//       const customMessage = 'Custom Message';
//       const customData = 'Error';
//       const readStates =
//           ReadErrorState<String>(data: customData, message: customMessage);
//       expect(readStates.type, equals(ReadStateType.error));
//       expect(readStates.message, equals(customMessage));
//       expect(readStates.data, isA<String>());
//       expect(readStates.data, equals(customData));
//       expect(
//           readStates.toJSON,
//           equals({
//             'message': customMessage,
//             'data': customData,
//             'type': {'name': 'error', 'index': 2}
//           }));
//       expect(
//           readStates.toString(),
//           equals(
//               'ReadErrorState<String>(message: $customMessage, data: $customData, type: {name: error, index: 2})'));
//     });

//     test('Validate Equality', () {
//       const originalReadStates = ReadLoadingState<int>();
//       final decodedReadStates =
//           ReadStates.fromJSON<int>(originalReadStates.toJSON);
//       expect(decodedReadStates.type, equals(originalReadStates.type));
//       expect(decodedReadStates.message, equals(originalReadStates.message));
//       expect(decodedReadStates.data, equals(originalReadStates.data));
//       expect(decodedReadStates, equals(originalReadStates));
//     });
//   });
// }
