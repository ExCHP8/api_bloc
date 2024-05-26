import 'package:api_bloc/api_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BlocStates', () {
    test('Validate Bloc State', () {
      BlocStates state = const BlocStates();
      expect(state, isA<BlocStates>());
      expect(state, isA<BlocStates<dynamic>>());
      expect(state.message, 'No Information Provided');
      expect(state.data, isNull);
      state = BlocStates.fromJSON(state.toJSON);
      expect(state, isA<BlocStates>());
      expect(state, isA<BlocStates<dynamic>>());
      expect(state.props, isNotEmpty);
      expect(state.props.length, equals(3));
      expect(state.toString(), contains('BlocStates'));
    });
  });
}
