part of '../write.dart';

class WriteController extends SharedRunner {
  WriteController(
    super.data, {
    super.type = SharedType.controllers,
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

class ${module.toCamelCase()}${submodule.toCamelCase()}Controller extends WriteController {
  @override
  Future<void> onRequest(Map<String, dynamic> args) async {
    // Delay to make the loading state more noticable.
    await Future.delayed(const Duration(milliseconds: 300));

    // Emit your success and failed state here ↓↓
    if (args['success'] ?? false) {
    emit(const WriteSuccessState<${module.toCamelCase()}${submodule.toCamelCase()}SuccessModel>(
        data: ${module.toCamelCase()}${submodule.toCamelCase()}SuccessModel.test()));
    } else {
    emit(const WriteFailedState<${module.toCamelCase()}${submodule.toCamelCase()}FailedModel>(
        data: ${module.toCamelCase()}${submodule.toCamelCase()}FailedModel.test()));
    }
  }
}
''';
  }
}
