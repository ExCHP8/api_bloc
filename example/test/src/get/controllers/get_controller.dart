import 'package:api_bloc/api_bloc.dart';
import 'package:example/src/get/get.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GetUserController', () {
    late GetUserController controller;

    setUp(() {
      controller = GetUserController();
    });

    tearDown(() {
      controller.dispose();
    });

    // test('Validate Initial State', () async {
    //   await controller.run();
    //   expect(controller.value, isA<WriteIdleState>());
    //   expect(controller.value.data, isNull);
    //   expect(controller.value.message, equals('Waiting For Interaction'));
    // });

    test('Validate Loading State', () async {
      await controller.run();
      expect(controller.value, isA<ReadLoadingState>());
      expect(controller.value.data, isNull);
      expect(controller.value.message, equals('Fetching On Progress'));
    });

    test('Validate Success State', () async {
      await controller.run();
      expect(controller.value, isA<ReadSuccessState>());
      expect(controller.value, isA<ReadSuccessState<GetUserModel>>());
      expect(controller.value.data, isA<GetUserModel>());
      expect(controller.value.message, equals('Data Successfully Fetched'));
    });

    // test('Validate Failed State', () async {
    //   await controller.run();
    //   expect(controller.value, isA<WriteFailedState>());
    //   expect(controller.value, isA<WriteFailedState<GetUserModel>>());
    //   expect(controller.value.data, isA<GetUserModel>());
    //   expect(controller.value.message, equals('Submitted Data Returns Failed'));
    // });

    test('Validate Error State', () async {
      await controller.run();
      expect(controller.value, isA<ReadErrorState>());
      expect(controller.value.message, equals('Something Went Wrong'));
      expect(controller.value.data, isNotNull);
      expect(controller.value.data, isA<StackTrace>());
    });
  });
}
