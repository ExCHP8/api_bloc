part of '../write.dart';

class WriteModel extends SharedRunner {
  const WriteModel(
    super.data, {
    super.type = SharedType.models,
  });

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
part of '../$module.dart';

class ${module.toCamelCase()}${submodule.toCamelCase()}SuccessModel {
  const ${module.toCamelCase()}${submodule.toCamelCase()}SuccessModel.test();
}

class ${module.toCamelCase()}${submodule.toCamelCase()}FailedModel {
  const ${module.toCamelCase()}${submodule.toCamelCase()}FailedModel.test();
}

''';
  }
}
