import 'package:api_bloc/api_bloc.dart';
import 'package:example/src/get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BlocConsumer', () {
    // testWidgets('Validate Initial Consumer', (tester) async {
    //   late GetUserController controller;

    //   setUp(() {
    //     controller = GetUserController();
    //   });

    //   tearDown(() {
    //     controller.dispose();
    //   });

    //   await controller.run();
    //   expect(controller.value, isA<WriteIdleState>());
    //   expect(controller.value, isA<WriteIdleState<dynamic>>());
    //   expect(controller.value.data, isNull);
    //   expect(controller.value.message, equals('Waiting For Interaction'));

    //   expect(() async {
    //     await tester.pumpWidget(const MaterialApp(home: GetUserView()));
    //     await tester.pump();
    //     expect(find.byType(Text), findsOneWidget);
    //     expect(find.text('Waiting For Interaction'), findsOneWidget);
    //     expect(find.byType(CircularProgressIndicator), findsNothing);
    //     expect(find.byType(SnackBar), findsNothing);
    //   }, returnsNormally);
    // });

    testWidgets('Validate Loading Consumer', (tester) async {
      late GetUserController controller;

      setUp(() {
        controller = GetUserController();
      });

      tearDown(() {
        controller.dispose();
      });

      await controller.run();
      expect(controller.value, isA<WriteLoadingState>());
      expect(controller.value, isA<WriteLoadingState<dynamic>>());
      expect(controller.value.data, isNull);
      expect(controller.value.message, equals('Submitting In Progress'));

      expect(() async {
        await tester.pumpWidget(const MaterialApp(home: GetUserView()));
        await tester.pump();
        expect(find.byType(Text), findsNothing);
        expect(find.text('Submitting In Progress'), findsNothing);
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        expect(find.byType(SnackBar), findsNothing);
      }, returnsNormally);
    });

    testWidgets('Validate Success Consumer', (tester) async {
      late GetUserController controller;

      setUp(() {
        controller = GetUserController();
      });

      tearDown(() {
        controller.dispose();
      });

      await controller.run();
      expect(controller.value, isA<WriteSuccessState>());
      expect(controller.value, isA<WriteSuccessState<GetUserModel>>());
      expect(controller.value.data, isA<GetUserModel>());
      expect(controller.value.message, equals('Data Successfully Submitted'));

      expect(() async {
        await tester.pumpWidget(const MaterialApp(home: GetUserView()));
        await tester.pump();
        expect(find.byType(Text), findsWidgets);
        expect(find.text('Data Successfully Submitted'), findsWidgets);
        expect(find.byType(CircularProgressIndicator), findsNothing);
        expect(find.byType(SnackBar), findsOneWidget);
      }, returnsNormally);
    });

    // testWidgets('Validate Failed Consumer', (tester) async {
    //   late GetUserController controller;

    //   setUp(() {
    //     controller = GetUserController();
    //   });

    //   tearDown(() {
    //     controller.dispose();
    //   });

    //   await controller.run();
    //   expect(controller.value, isA<WriteFailedState>());
    //   expect(controller.value, isA<WriteFailedState<GetUserModel>>());
    //   expect(controller.value.data, isA<GetUserModel>());
    //   expect(controller.value.message, equals('Submitted Data Returns Failed'));

    //   expect(() async {
    //     await tester.pumpWidget(const MaterialApp(home: GetUserView()));
    //     await tester.pump();
    //     expect(find.byType(Text), findsWidgets);
    //     expect(find.text('Submitted Data Returns Failed'), findsWidgets);
    //     expect(find.byType(CircularProgressIndicator), findsNothing);
    //     expect(find.byType(SnackBar), findsOneWidget);
    //   }, returnsNormally);
    // });

    testWidgets('Validate Error Consumer', (tester) async {
      late GetUserController controller;

      setUp(() {
        controller = GetUserController();
      });

      tearDown(() {
        controller.dispose();
      });

      await controller.run();
      expect(controller.value, isA<WriteErrorState>());
      expect(controller.value.message, equals('Something Went Wrong'));
      expect(controller.value.data, isNotNull);
      expect(controller.value.data, isA<StackTrace>());

      expect(() async {
        await tester.pumpWidget(const MaterialApp(home: GetUserView()));
        await tester.pump();
        expect(find.byType(Text), findsWidgets);
        expect(find.text('Something Went Wrong'), findsWidgets);
        expect(find.byType(CircularProgressIndicator), findsNothing);
        expect(find.byType(SnackBar), findsOneWidget);
      }, returnsNormally);
    });
  });
}
