
// void main() {
//   group('BlocStates', () {
//     test('Validate Default Value', () {
//       const blocState = BlocStates();
//       expect(blocState.message, equals(''));
//       expect(blocState.data, isNull);
//       expect(blocState.toJSON, equals({'message': '', 'data': null}));
//       expect(blocState.toString(),
//           equals('BlocStates<Object?>(message: , data: null)'));
//     });

//     test('Validate Custom Value', () {
//       const customMessage = 'Custom Message';
//       const customData = 42;
//       const blocState = BlocStates(
//         message: customMessage,
//         data: customData,
//       );
//       expect(blocState.message, equals(customMessage));
//       expect(blocState.data, isA<int>());
//       expect(blocState.data, equals(customData));
//       expect(blocState.toJSON,
//           equals({'message': customMessage, 'data': customData}));
//       expect(
//           blocState.toString(),
//           equals(
//               'BlocStates<int>(message: $customMessage, data: $customData)'));
//     });

//     test('Validate Equality', () {
//       const originalBlocState = BlocStates(
//         message: 'Encoded Message',
//         data: {'key': 'value'},
//       );
//       final decodedBlocState =
//           BlocStates.fromJSON<Map<String, String>>(originalBlocState.toJSON);
//       expect(decodedBlocState.message, equals(originalBlocState.message));
//       expect(decodedBlocState.data, equals(originalBlocState.data));
//       expect(decodedBlocState, equals(originalBlocState));
//     });
//   });
// }
