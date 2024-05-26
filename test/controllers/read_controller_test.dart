import 'package:api_bloc/api_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../api_bloc_test.dart';

class ReadControllerTest extends ReadController {
  @override
  Future<void> onRequest(Map<String, dynamic> args) async {
    bool? value = args['success'];

    switch (value) {
      case true:
        return emit(ReadSuccessState<TestModel>(data: TestModel.test()));
      case false:
        throw 'Mocked Error';
      case null:
        break;
    }
  }
}

void main() {
  group('ReadController', () {
    late ReadControllerTest controller;

    setUp(() {
      controller = ReadControllerTest();
    });

    tearDown(() {
      controller.dispose();
    });

    test('Validate Initial State', () {
      expect(controller.value, isA<ReadLoadingState>());
      expect(controller.value.data, isNull);
      expect(controller.value.message, equals('Fetching On Progress'));
    });

    test('Validate Success State', () async {
      await controller.run({'success': true});
      expect(controller.value, isA<ReadSuccessState>());
      expect(controller.value, isA<ReadSuccessState<TestModel>>());
      expect(controller.value.data, isA<TestModel>());
      expect(controller.value.data.id, equals(6));
      expect(controller.value.data.name, equals('Bob the Builder'));
      expect(controller.value.message, equals('Data Successfully Fetched'));
    });

    test('Validate Error State', () async {
      await controller.run({'success': false});
      expect(controller.value, isA<ReadErrorState>());
      expect(controller.value.message, equals('Mocked Error'));
      expect(controller.value.data, isNotNull);
      expect(controller.value.data, isA<StackTrace>());
    });
  });
}
