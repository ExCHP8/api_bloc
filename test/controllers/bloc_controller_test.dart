import 'package:api_bloc/api_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../api_bloc_test.dart';

class BlocControllerTest extends BlocController<ReadStates> {
  BlocControllerTest([super.value = const ReadLoadingState()]);

  @override
  Future<void> run([ReadStates value = const ReadLoadingState()]) async {
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
      expect(controller.value.data, isNull);
      expect(controller.value.message, equals('Fetching On Progress'));
    });

    test('Validate Success State', () async {
      await controller.run(ReadSuccessState<TestModel>(data: TestModel.test()));
      expect(controller.value, isA<ReadSuccessState>());
      expect(controller.value, isA<ReadSuccessState<TestModel>>());
      expect(controller.value.data, isA<TestModel>());
      expect(controller.value.data.id, equals(6));
      expect(controller.value.data.name, equals('Bob the Builder'));
      expect(controller.value.message, equals('Data Successfully Fetched'));
    });

    test('Validate Error State', () async {
      await controller.run(const ReadErrorState(message: 'Mocked error'));
      expect(controller.value, isA<ReadErrorState>());
      expect(controller.value.message, equals('Mocked error'));
      expect(controller.value.data, isNull);
    });

    testWidgets('Validate Success Controller', (tester) async {
      await controller.run(ReadSuccessState<TestModel>(data: TestModel.test()));

      expect(() async {
        Widget child = ApiBloc(
          controller: controller,
          dispose: false,
          builder: (context, _) {
            return BlocBuilder(
              controller: context.bloc<BlocControllerTest>(),
              builder: (_, state, child) {
                if (state is ReadSuccessState) return Text(state.message);
                return child;
              },
            );
          },
        );

        await tester.pumpWidget(MaterialApp(home: child));
        await tester.pump();
        expect(find.text('Data Successfully Fetched'), findsOneWidget);
      }, returnsNormally);
    });

    testWidgets('Validate Error Controller', (tester) async {
      await controller.run(ReadSuccessState<TestModel>(data: TestModel.test()));

      Widget child = Builder(
        builder: (context) => ApiBloc(
          controller: controller,
          dispose: false,
          child: BlocBuilder(
            controller: context.bloc<BlocControllerTest>(),
            builder: (_, state, child) {
              if (state is ReadSuccessState) return Text(state.message);
              return child;
            },
          ),
        ),
      );

      await tester.pumpWidget(MaterialApp(home: child));
      await tester.pump();
      expect(tester.takeException(), isA<ApiBlocException>());
    });
  });
}
