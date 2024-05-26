import 'package:api_bloc/api_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../api_bloc_test.dart';

class WriteControllerTest extends WriteController {
  @override
  Future<void> onRequest(Map<String, dynamic> args) async {
    int value = args['case'] ?? 0;

    switch (value) {
      case 0:
        return emit(const WriteIdleState());
      case 1:
        return emit(const WriteLoadingState());
      case 2:
        return emit(WriteSuccessState<TestModel>(data: TestModel.test()));
      case 3:
        return emit(WriteFailedState<TestModel>(data: TestModel.test()));
      default:
        throw 'Mocked Error';
    }
  }
}

void main() {
  group('WriteController', () {
    late WriteControllerTest controller;

    setUp(() {
      controller = WriteControllerTest();
    });

    tearDown(() {
      controller.dispose();
    });

    test('Validate Initial State', () async {
      await controller.run({'case': 0});
      expect(controller.value, isA<WriteIdleState>());
      expect(controller.value.data, isNull);
      expect(controller.value.message, equals('Waiting For Interaction'));
    });

    test('Validate Loading State', () async {
      await controller.run({'case': 1});
      expect(controller.value, isA<WriteLoadingState>());
      expect(controller.value.data, isNull);
      expect(controller.value.message, equals('Submitting In Progress'));
    });

    test('Validate Success State', () async {
      await controller.run({'case': 2});
      expect(controller.value, isA<WriteSuccessState>());
      expect(controller.value, isA<WriteSuccessState<TestModel>>());
      expect(controller.value.data, isA<TestModel>());
      expect(controller.value.data.id, equals(6));
      expect(controller.value.data.name, equals('Bob the Builder'));
      expect(controller.value.message, equals('Data Successfully Submitted'));
    });

    test('Validate Failed State', () async {
      await controller.run({'case': 3});
      expect(controller.value, isA<WriteFailedState>());
      expect(controller.value, isA<WriteFailedState<TestModel>>());
      expect(controller.value.data, isA<TestModel>());
      expect(controller.value.data.id, equals(6));
      expect(controller.value.data.name, equals('Bob the Builder'));
      expect(controller.value.message, equals('Submitted Data Returns Failed'));
    });

    test('Validate Error State', () async {
      await controller.run({'case': 4});
      expect(controller.value, isA<WriteErrorState>());
      expect(controller.value.message, equals('Mocked Error'));
      expect(controller.value.data, isNotNull);
      expect(controller.value.data, isA<StackTrace>());
    });
  });
}
