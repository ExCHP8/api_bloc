import 'package:api_bloc/api_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BlocStates', () {
    test('Validate Base Class', () {
      BlocStates state = const BlocStates();
      expect(state.message, 'No Information Provided');
      print(state.data);
      print(state.data.runtimeType);
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
