import 'package:flutter_test/flutter_test.dart';
import 'package:api_bloc/api_bloc.dart';

class MockController extends BlocRequest<BlocStates> {
  MockController({super.value = const ReadLoadingState()});
  bool success = true;

  @override
  Future<void> run() async {
    emit(const ReadLoadingState());
    try {
      await Future.delayed(const Duration(seconds: 1));

      if (success) {
        emit(const ReadSuccessState<String>(data: 'Success'));
      } else {
        throw 'Mocked error';
      }
    } catch (e) {
      emit(ReadErrorState(data: e));
    }
  }
}

void main() {
  group('BlocRequest', () {
    late MockController myController;

    setUp(() {
      myController = MockController();
    });

    test('Validate Initial State', () {
      expect(myController.value, isA<ReadLoadingState>());
    });

    test('Validate Success State', () async {
      await myController.run();
      expect(myController.value, isA<ReadSuccessState<String>>());
      expect(myController.value.data, isA<String>());
      expect(myController.value.data, isNotEmpty);
      expect(myController.value.data, equals('Success'));
    });

    test('Validate Error State', () async {
      myController.success = false;
      await myController.run();
      expect(myController.value, isA<ReadErrorState>());
      expect(myController.value.data, isNotEmpty);
      expect(myController.value.data, equals('Mocked error'));
    });
  });
}
