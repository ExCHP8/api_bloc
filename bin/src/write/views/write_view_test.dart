part of '../write.dart';

class WriteViewTest extends SharedRunner {
  WriteViewTest(
    super.data, {
    super.type = SharedType.views,
  });

  @override
  Directory get directory {
    return Directory(
      '${data['output']}'
              .toLowerCase()
              .toPath
              .replaceFirst(RegExp(r'(^|/)\blib/'), 'test/') +
          module.toLowerCase().toPath,
    )..createSync(recursive: true);
  }

  @override
  List<String> get submodules {
    return data['write'];
  }

  @override
  String template({
    required String module,
    required String submodule,
  }) {
    return '''
// ignore: avoid_relative_lib_imports
import '../../../../${directory.path.replaceFirst(RegExp(r'(^|/)\btest/'), 'lib/')}/${module.toLowerCase()}.dart';
import 'package:api_bloc/api_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('${module.toCamelCase()}${submodule.toCamelCase()}View', () {
    testWidgets('Validate Initial Consumer', (tester) async {
      late ${module.toCamelCase()}${submodule.toCamelCase()}Controller controller;

      setUp(() {
        controller = ${module.toCamelCase()}${submodule.toCamelCase()}Controller();
      });

      tearDown(() {
        controller.dispose();
      });

      await controller.run();
      expect(controller.value, isA<WriteIdleState>());
      expect(controller.value, isA<WriteIdleState<dynamic>>());
      expect(controller.value.data, isNull);
      expect(controller.value.message, equals('Waiting For Interaction'));

      expect(() async {
        await tester.pumpWidget(const MaterialApp(home: ${module.toCamelCase()}${submodule.toCamelCase()}View()));
        await tester.pump();
        expect(find.byType(Text), findsOneWidget);
        expect(find.text('Waiting For Interaction'), findsOneWidget);
        expect(find.byType(CircularProgressIndicator), findsNothing);
        expect(find.byType(SnackBar), findsNothing);
      }, returnsNormally);
    });

    testWidgets('Validate Loading Consumer', (tester) async {
      late ${module.toCamelCase()}${submodule.toCamelCase()}Controller controller;

      setUp(() {
        controller = ${module.toCamelCase()}${submodule.toCamelCase()}Controller();
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
        await tester.pumpWidget(const MaterialApp(home: ${module.toCamelCase()}${submodule.toCamelCase()}View()));
        await tester.pump();
        expect(find.byType(Text), findsNothing);
        expect(find.text('Submitting In Progress'), findsNothing);
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        expect(find.byType(SnackBar), findsNothing);
      }, returnsNormally);
    });

    testWidgets('Validate Success Consumer', (tester) async {
      late ${module.toCamelCase()}${submodule.toCamelCase()}Controller controller;

      setUp(() {
        controller = ${module.toCamelCase()}${submodule.toCamelCase()}Controller();
      });

      tearDown(() {
        controller.dispose();
      });

      await controller.run();
      expect(controller.value, isA<WriteSuccessState>());
      expect(controller.value, isA<WriteSuccessState<${module.toCamelCase()}${submodule.toCamelCase()}SuccessModel>>());
      expect(controller.value.data, isA<${module.toCamelCase()}${submodule.toCamelCase()}SuccessModel>());
      expect(controller.value.message, equals('Data Successfully Submitted'));

      expect(() async {
        await tester.pumpWidget(const MaterialApp(home: ${module.toCamelCase()}${submodule.toCamelCase()}View()));
        await tester.pump();
        expect(find.byType(Text), findsWidgets);
        expect(find.text('Data Successfully Submitted'), findsWidgets);
        expect(find.byType(CircularProgressIndicator), findsNothing);
        expect(find.byType(SnackBar), findsOneWidget);
      }, returnsNormally);
    });

    testWidgets('Validate Failed Consumer', (tester) async {
      late ${module.toCamelCase()}${submodule.toCamelCase()}Controller controller;

      setUp(() {
        controller = ${module.toCamelCase()}${submodule.toCamelCase()}Controller();
      });

      tearDown(() {
        controller.dispose();
      });

      await controller.run();
      expect(controller.value, isA<WriteFailedState>());
      expect(controller.value, isA<WriteFailedState<${module.toCamelCase()}${submodule.toCamelCase()}FailedModel>>());
      expect(controller.value.data, isA<${module.toCamelCase()}${submodule.toCamelCase()}FailedModel>());
      expect(controller.value.message, equals('Submitted Data Returns Failed'));

      expect(() async {
        await tester.pumpWidget(const MaterialApp(home: ${module.toCamelCase()}${submodule.toCamelCase()}View()));
        await tester.pump();
        expect(find.byType(Text), findsWidgets);
        expect(find.text('Submitted Data Returns Failed'), findsWidgets);
        expect(find.byType(CircularProgressIndicator), findsNothing);
        expect(find.byType(SnackBar), findsOneWidget);
      }, returnsNormally);
    });

    testWidgets('Validate Error Consumer', (tester) async {
      late ${module.toCamelCase()}${submodule.toCamelCase()}Controller controller;

      setUp(() {
        controller = ${module.toCamelCase()}${submodule.toCamelCase()}Controller();
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
        await tester.pumpWidget(const MaterialApp(home: ${module.toCamelCase()}${submodule.toCamelCase()}View()));
        await tester.pump();
        expect(find.byType(Text), findsWidgets);
        expect(find.text('Something Went Wrong'), findsWidgets);
        expect(find.byType(CircularProgressIndicator), findsNothing);
        expect(find.byType(SnackBar), findsOneWidget);
      }, returnsNormally);
    });
  });
}
''';
  }
}
