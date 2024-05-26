import 'package:api_bloc/api_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../api_bloc_test.dart';
import '../controllers/write_controller_test.dart';

class BlocBuilderTest {
  final WriteControllerTest controller = WriteControllerTest();
  late final Widget child = ApiBloc(
    controller: controller,
    dispose: false,
    builder: (context, _) {
      return BlocBuilder<WriteControllerTest, WriteStates>(
        builder: (_, state, __) {
          if (state is! WriteLoadingState) return Text(state.message);
          return const CircularProgressIndicator();
        },
      );
    },
  );
}

void main() {
  group('BlocBuilder', () {
    testWidgets('Validate Loading Builder', (tester) async {
      BlocBuilderTest test = BlocBuilderTest();

      await test.controller.run({'case': 1});
      expect(test.controller.value, isA<WriteLoadingState>());
      expect(test.controller.value, isA<WriteLoadingState<dynamic>>());
      expect(test.controller.value.data, isNull);
      expect(test.controller.value.message, equals('Submitting In Progress'));

      expect(() async {
        await tester.pumpWidget(MaterialApp(home: test.child));
        await tester.pump();
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        expect(find.text('Submitting In Progress'), findsNothing);
      }, returnsNormally);
    });

    testWidgets('Validate Success Builder', (tester) async {
      BlocBuilderTest test = BlocBuilderTest();

      await test.controller.run({'case': 2});
      expect(test.controller.value, isA<WriteSuccessState>());
      expect(test.controller.value, isA<WriteSuccessState<TestModel>>());
      expect(test.controller.value.data, isA<TestModel>());
      expect(test.controller.value.data.id, equals(6));
      expect(test.controller.value.data.name, equals('Bob the Builder'));
      expect(
          test.controller.value.message, equals('Data Successfully Submitted'));

      expect(() async {
        await tester.pumpWidget(MaterialApp(home: test.child));
        await tester.pump();
        expect(find.byType(CircularProgressIndicator), findsNothing);
        expect(find.byType(Text), findsOneWidget);
        expect(find.text('Data Successfully Submitted'), findsOneWidget);
      }, returnsNormally);
    });

    testWidgets('Validate Error Builder', (tester) async {
      BlocBuilderTest test = BlocBuilderTest();

      await test.controller.run({'case': 4});
      expect(test.controller.value, isA<WriteErrorState>());
      expect(test.controller.value.message, equals('Mocked Error'));
      expect(test.controller.value.data, isNotNull);
      expect(test.controller.value.data, isA<StackTrace>());

      expect(() async {
        await tester.pumpWidget(MaterialApp(home: test.child));
        await tester.pump();
        expect(find.byType(CircularProgressIndicator), findsNothing);
        expect(find.text('Mocked Error'), findsOneWidget);
      }, returnsNormally);
    });
  });
}
