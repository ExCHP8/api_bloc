part of '../write.dart';

class WriteControllerTest extends SharedRunner {
  WriteControllerTest(
    super.data, {
    super.type = SharedType.controllers,
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
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('${module.toCamelCase()}${submodule.toCamelCase()}Controller', () {
    late ${module.toCamelCase()}${submodule.toCamelCase()}Controller controller;

    setUp(() {
      controller = ${module.toCamelCase()}${submodule.toCamelCase()}Controller();
    });

    tearDown(() {
      controller.dispose();
    });

    test('Validate Initial State', () async {
      await controller.run();
      expect(controller.value, isA<WriteIdleState>());
      expect(controller.value.data, isNull);
      expect(controller.value.message, equals('Waiting For Interaction'));
    });


    test('Validate Loading State', () async {
      await controller.run();
      expect(controller.value, isA<WriteLoadingState>());
      expect(controller.value.data, isNull);
      expect(controller.value.message, equals('Fetching On Progress'));
    });

    test('Validate Success State', () async {
      await controller.run();
      expect(controller.value, isA<WriteSuccessState>());
      expect(controller.value, isA<WriteSuccessState<${module.toCamelCase()}${submodule.toCamelCase()}SuccessModel>>());
      expect(controller.value.data, isA<${module.toCamelCase()}${submodule.toCamelCase()}SuccessModel>());
      expect(controller.value.message, equals('Data Successfully Fetched'));
    });

    test('Validate Failed State', () async {
      await controller.run();
      expect(controller.value, isA<WriteFailedState>());
      expect(controller.value, isA<WriteFailedState<${module.toCamelCase()}${submodule.toCamelCase()}FailedModel>>());
      expect(controller.value.data, isA<${module.toCamelCase()}${submodule.toCamelCase()}FailedModel>());
      expect(controller.value.message, equals('Submitted Data Returns Failed'));
    });

    test('Validate Error State', () async {
      await controller.run();
      expect(controller.value, isA<WriteErrorState>());
      expect(controller.value.message, equals('Something Went Wrong'));
      expect(controller.value.data, isNotNull);
      expect(controller.value.data, isA<StackTrace>());
    });
  });
}
''';
  }
}
