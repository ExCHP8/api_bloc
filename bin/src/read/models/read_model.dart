part of '../read.dart';

class ReadModel extends SharedRunner {
  const ReadModel(
    super.data, {
    super.type = SharedType.models,
  });

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
part of '../$module.dart';

class ${module.toCamelCase()}${submodule.toCamelCase()}Model {
  const ${module.toCamelCase()}${submodule.toCamelCase()}Model.test();
}
''';
  }
}
