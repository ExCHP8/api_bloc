part of '../read.dart';

class ReadModel extends SharedRunner {
  const ReadModel(
    super.data, {
    super.type = SharedType.model,
  });

  @override
  List<String> get submodules {
    return data['read'];
  }

  @override
  String template({required String module, required String submodule}) {
    return '''
part of '../$module.dart';

class $module${submodule}Model {
  const $module${submodule}Model.test();
}
''';
  }
}
