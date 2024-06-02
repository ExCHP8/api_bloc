part of '../read.dart';

class ReadController extends SharedRunner {
  ReadController(
    super.data, {
    super.type = SharedType.controllers,
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

class ${module.toCamelCase()}${submodule.toCamelCase()}Controller extends ReadController {
  @override
  Future<void> onRequest(Map<String, dynamic> args) async {
    // Delay to make the loading state more noticable.
    await Future.delayed(const Duration(milliseconds: 300));

    // Emit your success state here ↓↓
    emit(const ReadSuccessState<${module.toCamelCase()}${submodule.toCamelCase()}Model>(data: ${module.toCamelCase()}${submodule.toCamelCase()}Model.test()));
  }
}
''';
  }
}
