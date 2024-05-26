import 'package:api_bloc/api_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../api_bloc_test.dart';

void main() {
  group('WriteStates', () {
    test('Validate Idle State', () {
      WriteStates state = WriteStates.idle();
      expect(state, isA<WriteIdleState>());
      state = WriteIdleState.fromJSON(state.toJSON);
      expect(state, isA<WriteIdleState>());
      expect(state, isA<WriteIdleState<dynamic>>());
      expect(state.message, 'Waiting For Interaction');
      expect(state.data, isNull);
      expect(state.toJSON['type'], isA<String>());
      expect(state.toJSON['type'], startsWith('WriteIdleState'));
      expect(state.toJSON['data'], isNull);
    });
    test('Validate Loading State', () {
      WriteStates state = WriteStates.loading<double>(data: 0.0);
      expect(state, isA<WriteLoadingState>());
      expect(state, isA<WriteLoadingState<double>>());
      state = WriteLoadingState.fromJSON<double>(state.toJSON);
      expect(state, isA<WriteLoadingState>());
      expect(state, isA<WriteLoadingState<double>>());
      expect(state.message, 'Submitting In Progress');
      expect(state.data, isNotNull);
      expect(state.data, isA<double>());
      expect(state.data, equals(0.0));
      expect(state.toJSON['type'], isA<String>());
      expect(state.toJSON['type'], startsWith('WriteLoadingState'));
      expect(state.toJSON['data'], isA<double>());
      expect(state.toJSON['data'], equals(0.0));
    });

    test('Validate Success State', () {
      WriteStates state = WriteStates.success<TestModel>(
        data: TestModel.test(),
      );
      expect(state, isA<WriteSuccessState>());
      expect(state, isA<WriteSuccessState<TestModel>>());
      state = WriteSuccessState.fromJSON<TestModel>(state.toJSON);
      expect(state, isA<WriteSuccessState>());
      expect(state, isA<WriteSuccessState<TestModel>>());
      expect(state.message, 'Data Successfully Submitted');
      expect(state.data, isNotNull);
      expect(state.data, isA<TestModel>());
      expect(state.data.id, equals(6));
      expect(state.data.name, equals('Bob the Builder'));
      expect(state.toJSON['type'], isA<String>());
      expect(state.toJSON['type'], startsWith('WriteSuccessState'));
      expect(state.toJSON['data'], isA<TestModel>());
      expect(state.toJSON['data'].id, equals(6));
      expect(state.toJSON['data'].name, equals('Bob the Builder'));
    });

    test('Validate Failed State', () {
      WriteStates state = WriteStates.failed<TestModel>(
        data: TestModel.test(),
      );
      expect(state, isA<WriteFailedState>());
      expect(state, isA<WriteFailedState<TestModel>>());
      state = WriteFailedState.fromJSON<TestModel>(state.toJSON);
      expect(state, isA<WriteFailedState>());
      expect(state, isA<WriteFailedState<TestModel>>());
      expect(state.message, 'Submitted Data Returns Failed');
      expect(state.data, isNotNull);
      expect(state.data, isA<TestModel>());
      expect(state.data.id, equals(6));
      expect(state.data.name, equals('Bob the Builder'));
      expect(state.toJSON['type'], isA<String>());
      expect(state.toJSON['type'], startsWith('WriteFailedState'));
      expect(state.toJSON['data'], isA<TestModel>());
      expect(state.toJSON['data'].id, equals(6));
      expect(state.toJSON['data'].name, equals('Bob the Builder'));
    });
    test('Validate Error State', () {
      WriteStates state = WriteStates.error<ApiBlocException>(
        message: 'Something Went Wrong',
        data: const ApiBlocException('Mocked error', StackTrace.empty),
      );
      expect(state, isA<WriteErrorState>());
      expect(state, isA<WriteErrorState<ApiBlocException>>());
      state = WriteErrorState.fromJSON<ApiBlocException>(state.toJSON);
      expect(state, isA<WriteErrorState>());
      expect(state, isA<WriteErrorState<ApiBlocException>>());
      expect(state.message, 'Something Went Wrong');
      expect(state.data, isNotNull);
      expect(state.data, isA<ApiBlocException>());
      expect(state.data.message, equals('Mocked error'));
      expect(state.data.stackTrace, isA<StackTrace>());
      expect(state.toJSON['type'], isA<String>());
      expect(state.toJSON['type'], startsWith('WriteErrorState'));
      expect(state.toJSON['data'], isA<ApiBlocException>());
      expect(state.toJSON['data'].message, equals('Mocked error'));
      expect(state.toJSON['data'].stackTrace, isA<StackTrace>());
    });
  });
}
