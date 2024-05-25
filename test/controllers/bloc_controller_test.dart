import 'package:api_bloc/api_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test.dart';

class BlocControllerTest extends BlocController<ReadStates> {
  BlocControllerTest([super.value = const ReadLoadingState()]);

  @override
  Future<void> run() async {
    emit(value);
  }
}

void main() {
  group('BlocController', () {
    late BlocControllerTest controller;

    setUp(() {
      controller = BlocControllerTest();
    });

    tearDown(() {
      controller.dispose();
    });

    test('Validate Initial State', () {
      expect(controller.value, isA<ReadLoadingState>());
    });

    test('Validate Success State', () async {
      controller.emit(ReadSuccessState<TestModel>(data: TestModel.test()));
      await controller.run();
      expect(controller.value, isA<ReadSuccessState>());
      expect(controller.value, isA<ReadSuccessState<TestModel>>());
      expect(controller.value.data, isA<TestModel>());
      expect(controller.value.data.id, equals(6));
      expect(controller.value.data.name, equals('Bob the Builder'));
    });

    test('Validate Error State', () async {
      controller.emit(const ReadErrorState(message: 'Mocked error'));
      await controller.run();
      expect(controller.value, isA<ReadErrorState>());
      expect(controller.value.message, equals('Mocked error'));
      expect(controller.value.data, isNull);
    });
  });
}
