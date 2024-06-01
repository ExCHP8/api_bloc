part of '../write.dart';

class WriteController extends SharedRunner {
  WriteController(
    super.data, {
    super.type = SharedType.controller,
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

class $module${submodule}Controller extends WriteController {
  @override
  Future<void> onRequest(Map<String, dynamic> args) async {
    // Delay to make the loading state more noticable.
    await Future.delayed(const Duration(milliseconds: 300));

    // Emit your success and failed state here ↓↓
    if (args['success'] ?? false) {
    emit(const WriteSuccessState<$module${submodule}SuccessModel>(
        data: $module${submodule}SuccessModel.test()));
    } else {
    emit(const WriteFailedState<$module${submodule}FailedModel>(
        data: $module${submodule}FailedModel.test()));
    }
  }
}
''';
  }
}
