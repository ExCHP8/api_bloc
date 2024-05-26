import 'package:api_bloc/api_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../api_bloc_test.dart';
import '../controllers/write_controller_test.dart';

class BlocConsumerTest {
  final WriteControllerTest controller = WriteControllerTest();
  late final Widget child = Scaffold(
    body: ApiBloc(
      controller: controller,
      dispose: false,
      builder: (context, _) {
        return BlocConsumer<WriteControllerTest, WriteStates>(
          listener: (context, state) {
            switch (state) {
              case WriteFailedState _:
              case WriteErrorState _:
              case WriteSuccessState _:
                return context.alert(state.message, color: Colors.green);
              default:
                return;
            }
          },
          builder: (_, state, __) {
            switch (state) {
              case WriteLoadingState _:
                return const CircularProgressIndicator();
              default:
                return Text(state.message);
            }
          },
        );
      },
    ),
  );
}

void main() {
  group('BlocConsumer', () {
    testWidgets('Validate Initial Consumer', (tester) async {
      BlocConsumerTest test = BlocConsumerTest();

      await test.controller.run({'case': 0});
      expect(test.controller.value, isA<WriteIdleState>());
      expect(test.controller.value, isA<WriteIdleState<dynamic>>());
      expect(test.controller.value.data, isNull);
      expect(test.controller.value.message, equals('Waiting For Interaction'));

      expect(() async {
        await tester.pumpWidget(MaterialApp(home: test.child));
        await tester.pump();
        expect(find.byType(Text), findsOneWidget);
        expect(find.text('Waiting For Interaction'), findsOneWidget);
        expect(find.byType(CircularProgressIndicator), findsNothing);
        expect(find.byType(SnackBar), findsNothing);
      }, returnsNormally);
    });

    testWidgets('Validate Loading Consumer', (tester) async {
      BlocConsumerTest test = BlocConsumerTest();

      await test.controller.run({'case': 1});
      expect(test.controller.value, isA<WriteLoadingState>());
      expect(test.controller.value, isA<WriteLoadingState<dynamic>>());
      expect(test.controller.value.data, isNull);
      expect(test.controller.value.message, equals('Submitting In Progress'));

      expect(() async {
        await tester.pumpWidget(MaterialApp(home: test.child));
        await tester.pump();
        expect(find.byType(Text), findsNothing);
        expect(find.text('Submitting In Progress'), findsNothing);
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        expect(find.byType(SnackBar), findsNothing);
      }, returnsNormally);
    });

    testWidgets('Validate Success Consumer', (tester) async {
      BlocConsumerTest test = BlocConsumerTest();

      await test.controller.run({'case': 2});
      expect(test.controller.value, isA<WriteSuccessState>());
      expect(test.controller.value, isA<WriteSuccessState<TestModel>>());
      expect(test.controller.value.data, isA<TestModel>());
      expect(test.controller.value.data.id, equals(6));
      expect(test.controller.value.data.name, equals('Bob the Builder'));
      expect(
        test.controller.value.message,
        equals('Data Successfully Submitted'),
      );

      expect(() async {
        await tester.pumpWidget(MaterialApp(home: test.child));
        await tester.pump();
        expect(find.byType(Text), findsWidgets);
        expect(find.text('Data Successfully Submitted'), findsWidgets);
        expect(find.byType(CircularProgressIndicator), findsNothing);
        expect(find.byType(SnackBar), findsOne);
      }, returnsNormally);
    });

    testWidgets('Validate Failed Consumer', (tester) async {
      BlocConsumerTest test = BlocConsumerTest();

      await test.controller.run({'case': 3});
      expect(test.controller.value, isA<WriteFailedState>());
      expect(test.controller.value, isA<WriteFailedState<TestModel>>());
      expect(test.controller.value.data, isA<TestModel>());
      expect(test.controller.value.data.id, equals(6));
      expect(test.controller.value.data.name, equals('Bob the Builder'));
      expect(test.controller.value.message,
          equals('Submitted Data Returns Failed'));

      expect(() async {
        await tester.pumpWidget(MaterialApp(home: test.child));
        await tester.pump();
        expect(find.byType(Text), findsWidgets);
        expect(find.text('Submitted Data Returns Failed'), findsWidgets);
        expect(find.byType(CircularProgressIndicator), findsNothing);
        expect(find.byType(SnackBar), findsOne);
      }, returnsNormally);
    });

    testWidgets('Validate Error Consumer', (tester) async {
      BlocConsumerTest test = BlocConsumerTest();

      await test.controller.run({'case': 4});
      expect(test.controller.value, isA<WriteErrorState>());
      expect(test.controller.value.message, equals('Mocked Error'));
      expect(test.controller.value.data, isNotNull);
      expect(test.controller.value.data, isA<StackTrace>());

      expect(() async {
        await tester.pumpWidget(MaterialApp(home: test.child));
        await tester.pump();
        expect(find.byType(Text), findsWidgets);
        expect(find.text('Mocked Error'), findsWidgets);
        expect(find.byType(CircularProgressIndicator), findsNothing);
        expect(find.byType(SnackBar), findsOne);
      }, returnsNormally);
    });
  });
}
