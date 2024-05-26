import 'package:api_bloc/api_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../api_bloc_test.dart';

void main() {
  group('ReadStates', () {
    test('Validate Loading State', () {
      ReadStates state = ReadStates.loading<double>(data: 0.0);
      expect(state, isA<ReadLoadingState>());
      expect(state, isA<ReadLoadingState<double>>());
      state = ReadLoadingState.fromJSON(state.toJSON);
      expect(state, isA<ReadLoadingState<dynamic>>());
      expect(state.message, 'Fetching On Progress');
      expect(state.data, isNotNull);
      expect(state.data, isA<double>());
      expect(state.data, equals(0.0));
      expect(state.toJSON['type'], isA<String>());
      expect(state.toJSON['type'], startsWith('ReadLoadingState'));
      expect(state.toJSON['data'], isA<double>());
      expect(state.toJSON['data'], equals(0.0));
    });

    test('Validate Success State', () {
      ReadStates state = ReadStates.success<TestModel>(
        data: TestModel.test(),
      );
      expect(state, isA<ReadSuccessState>());
      expect(state, isA<ReadSuccessState<TestModel>>());
      state = ReadSuccessState.fromJSON(state.toJSON);
      expect(state, isA<ReadSuccessState>());
      expect(state, isA<ReadSuccessState<dynamic>>());
      expect(state.message, 'Data Successfully Fetched');
      expect(state.data, isNotNull);
      expect(state.data, isA<TestModel>());
      expect(state.data.id, equals(6));
      expect(state.data.name, equals('Bob the Builder'));
      expect(state.toJSON['type'], isA<String>());
      expect(state.toJSON['type'], startsWith('ReadSuccessState'));
      expect(state.toJSON['data'], isA<TestModel>());
      expect(state.toJSON['data'].id, equals(6));
      expect(state.toJSON['data'].name, equals('Bob the Builder'));
    });

    test('Validate Error State', () {
      ReadStates state = ReadStates.error<ApiBlocException>(
        message: 'Something Went Wrong',
        data: const ApiBlocException('Mocked error', StackTrace.empty),
      );
      expect(state, isA<ReadErrorState>());
      expect(state, isA<ReadErrorState<ApiBlocException>>());
      state = ReadErrorState.fromJSON(state.toJSON);
      expect(state, isA<ReadErrorState>());
      expect(state, isA<ReadErrorState<dynamic>>());
      expect(state.message, 'Something Went Wrong');
      expect(state.data, isNotNull);
      expect(state.data, isA<ApiBlocException>());
      expect(state.data.message, equals('Mocked error'));
      expect(state.data.stackTrace, isA<StackTrace>());
      expect(state.toJSON['type'], isA<String>());
      expect(state.toJSON['type'], startsWith('ReadErrorState'));
      expect(state.toJSON['data'], isA<ApiBlocException>());
      expect(state.toJSON['data'].message, equals('Mocked error'));
      expect(state.toJSON['data'].stackTrace, isA<StackTrace>());
    });
  });
}
