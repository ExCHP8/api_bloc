import 'package:api_bloc/api_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../api_bloc_test.dart';
import '../controllers/write_controller_test.dart';

class BlocListenerTest {
  final WriteControllerTest controller = WriteControllerTest();
  late final Widget child = Scaffold(
    body: ApiBloc(
      controller: controller,
      dispose: false,
      builder: (context, _) {
        return BlocListener(
          controller: context.bloc<WriteControllerTest>(),
          listener: (context, WriteStates state) {
            switch (state) {
              case WriteFailedState _:
              case WriteErrorState _:
              case WriteSuccessState _:
                return context.alert(state.message, color: Colors.green);
              default:
                return;
            }
          },
        );
      },
    ),
  );
}

void main() {
  group('BlocListener', () {
    testWidgets('Validate Success Listener', (tester) async {
      BlocListenerTest test = BlocListenerTest();

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
        expect(find.byType(Text), findsOneWidget);
        expect(find.text('Data Successfully Submitted'), findsOneWidget);
        expect(find.byType(SnackBar), findsOneWidget);
      }, returnsNormally);
    });

    testWidgets('Validate Failed Listener', (tester) async {
      BlocListenerTest test = BlocListenerTest();

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
        expect(find.byType(Text), findsOneWidget);
        expect(find.text('Submitted Data Returns Failed'), findsOneWidget);
        expect(find.byType(SnackBar), findsOneWidget);
      }, returnsNormally);
    });

    testWidgets('Validate Error Listener', (tester) async {
      BlocListenerTest test = BlocListenerTest();

      await test.controller.run({'case': 4});
      expect(test.controller.value, isA<WriteErrorState>());
      expect(test.controller.value.message, equals('Mocked Error'));
      expect(test.controller.value.data, isNotNull);
      expect(test.controller.value.data, isA<StackTrace>());

      expect(() async {
        await tester.pumpWidget(MaterialApp(home: test.child));
        await tester.pump();
        expect(find.byType(Text), findsOneWidget);
        expect(find.text('Mocked Error'), findsOneWidget);
        expect(find.byType(SnackBar), findsOneWidget);
      }, returnsNormally);
    });
  });
}
