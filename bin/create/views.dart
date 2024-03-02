part of '../api_bloc.dart';

final class View {
  static List<String> create(StringBuffer buffer,
      {required ArgResults from,
      required Directory root,
      required String module}) {
    List<String> result = [];
    List<String> getlist = from['get'];
    List<String> sendlist = from['send'];
    Directory directory = Directory('${root.path}views')
      ..createSync(recursive: true);
    buffer.write('📂 ${directory.safePath}\n');

    for (var name in getlist) {
      File file =
          File('${directory.safePath}get_${module}_${name}_widget.dart');
      result.add(file.path);
      if (file.existsSync()) {
        buffer.write('\x1B[30m   📄 ${file.path} \x1B[33m[SKIPPED]\x1B[32m\n');
      } else {
        buffer.write('   📄 ${file.path} \n');
        file
          ..createSync(recursive: true)
          ..writeAsStringSync(getAsStringSync(module: module, name: name));
      }
    }

    for (var name in sendlist) {
      File file =
          File('${directory.safePath}send_${module}_${name}_widget.dart');
      result.add(file.path);
      if (file.existsSync()) {
        buffer.write('\x1B[30m   📄 ${file.path} \x1B[33m[SKIPPED]\x1B[32m\n');
      } else {
        buffer.write('   📄 ${file.path} \n');
        file
          ..createSync(recursive: true)
          ..writeAsStringSync(sendAsStringSync(module: module, name: name));
      }
    }

    return result;
  }

  static String getAsStringSync({
    required String module,
    required String name,
  }) {
    return '''
part of '../$module.dart';

class Get${module.capitalize}${name.capitalize}Widget extends StatelessWidget {
  const Get${module.capitalize}${name.capitalize}Widget({super.key, required this.controller});
  final Get${module.capitalize}${name.capitalize}Controller controller;

  @override
  Widget build(BuildContext context) {
    return ApiBloc(
      controller: controller,
      listener: (context, state) {
        if (state is GetSuccessState<Get${module.capitalize}${name.capitalize}Model>) {
        } else if (state is GetErrorState) {
        } else if (state is GetLoadingState) {}
      },
      builder: (context, state, child) {
        if (state is GetSuccessState<Get${module.capitalize}${name.capitalize}Model>) {
        } else if (state is GetErrorState) {
        } else if (state is GetLoadingState) {}
        return child;
      },
    );
  }
}

''';
  }

  static String sendAsStringSync({
    required String module,
    required String name,
  }) {
    return '''
part of '../$module.dart';

class Send${module.capitalize}${name.capitalize}Widget extends StatelessWidget {
  const Send${module.capitalize}${name.capitalize}Widget({super.key, required this.controller});
  final Send${module.capitalize}${name.capitalize}Controller controller;

  @override
  Widget build(BuildContext context) {
    return ApiBloc(
      controller: controller,
      listener: (context, state) {
        if (state is SendIdleState) {
        } else if (state is SendLoadingState) {
        } else if (state is SendSuccessState<Send${module.capitalize}${name.capitalize}SuccessModel>) {
        } else if (state is SendFailedState<Send${module.capitalize}${name.capitalize}FailedModel>) {
        } else if (state is SendErrorState) {}
      },
      builder: (context, state, child) {
        if (state is SendIdleState) {
        } else if (state is SendLoadingState) {
        } else if (state is SendSuccessState<Send${module.capitalize}${name.capitalize}SuccessModel>) {
        } else if (state is SendFailedState<Send${module.capitalize}${name.capitalize}FailedModel>) {
        } else if (state is SendErrorState) {}
        return child;
      },
    );
  }
}

''';
  }
}
