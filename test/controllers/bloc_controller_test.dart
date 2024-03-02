import 'package:flutter_test/flutter_test.dart';
import 'package:api_bloc/api_bloc.dart';

class MockController extends BlocController<BlocStates> {
  MockController({super.value = const GetLoadingState()});
  bool success = true;

  @override
  Future<void> run() async {
    emit(const GetLoadingState());
    try {
      await Future.delayed(const Duration(seconds: 1));

      if (success) {
        emit(const GetSuccessState<String>(data: 'Success'));
      } else {
        throw 'Mocked error';
      }
    } catch (e) {
      emit(GetErrorState(data: e));
    }
  }
}

void main() {
  group('BlocController', () {
    late MockController myController;

    setUp(() {
      myController = MockController();
    });

    test('Validate Initial State', () {
      expect(myController.value, isA<GetLoadingState>());
    });

    test('Validate Success State', () async {
      await myController.run();
      expect(myController.value, isA<GetSuccessState<String>>());
      expect(myController.value.data, isA<String>());
      expect(myController.value.data, isNotEmpty);
      expect(myController.value.data, equals('Success'));
    });

    test('Validate Error State', () async {
      myController.success = false;
      await myController.run();
      expect(myController.value, isA<GetErrorState>());
      expect(myController.value.data, isNotEmpty);
      expect(myController.value.data, equals('Mocked error'));
    });

    test('Validate AutoDispose Value', () {
      expect(myController.autoDispose, isTrue);
    });
  });
}
