part of '../write.dart';

class WriteModel extends SharedRunner {
  const WriteModel(
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

class $module${submodule}SuccessModel {
  const $module${submodule}SuccessModel.test();
}

class $module${submodule}FailedModel {
  const $module${submodule}FailedModel.test();
}

''';
  }
}
