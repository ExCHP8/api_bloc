part of '../read.dart';

class ReadModelTest extends SharedRunner {
  ReadModelTest(
    super.data, {
    super.type = SharedType.models,
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
    return data['read'];
  }

  @override
  String template({
    required String module,
    required String submodule,
  }) {
    return '''
// ignore: avoid_relative_lib_imports
import '../../../../${directory.path.replaceFirst(RegExp(r'(^|/)\btest/'), 'lib/')}/${module.toLowerCase()}.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('${module.toCamelCase()}${submodule.toCamelCase()}Model', () {
    test('Validate Type', () {
      const ${module.toCamelCase()}${submodule.toCamelCase()}Model data = ${module.toCamelCase()}${submodule.toCamelCase()}Model.test();
      expect(data, isA<${module.toCamelCase()}${submodule.toCamelCase()}Model>());
    });
  });
}
''';
  }
}
