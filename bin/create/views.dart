part of '../api_bloc.dart';

final class View {
  static List<String> create(StringBuffer buffer,
      {required ArgResults from,
      required Directory root,
      required String module}) {
    List<String> result = [];
    List<String> readlist = from['read'];
    List<String> writelist = from['write'];
    Directory directory = Directory('${root.path}views')
      ..createSync(recursive: true);
    buffer.write('📂 ${directory.safePath}\n');

    for (var name in readlist) {
      File file =
          File('${directory.safePath}read_${module}_${name}_widget.dart');
      result.add(file.path);
      if (file.existsSync()) {
        buffer.write('\x1B[30m   📄 ${file.path} \x1B[33m[SKIPPED]\x1B[32m\n');
      } else {
        buffer.write('   📄 ${file.path} \n');
        file
          ..createSync(recursive: true)
          ..writeAsStringSync(readAsStringSync(module: module, name: name));
      }
    }

    for (var name in writelist) {
      File file =
          File('${directory.safePath}write_${module}_${name}_widget.dart');
      result.add(file.path);
      if (file.existsSync()) {
        buffer.write('\x1B[30m   📄 ${file.path} \x1B[33m[SKIPPED]\x1B[32m\n');
      } else {
        buffer.write('   📄 ${file.path} \n');
        file
          ..createSync(recursive: true)
          ..writeAsStringSync(writeAsStringSync(module: module, name: name));
      }
    }

    return result;
  }

  static String readAsStringSync({
    required String module,
    required String name,
  }) {
    return '''
part of '../$module.dart';

class Read${module.capitalize}${name.capitalize}Widget extends StatelessWidget {
  const Read${module.capitalize}${name.capitalize}Widget({super.key, required this.controller});
  final Read${module.capitalize}${name.capitalize}Controller controller;

  @override
  Widget build(BuildContext context) {
    return ApiBloc(
      controller: controller,
      listener: (context, state) {
        if (state is ReadSuccessState<Read${module.capitalize}${name.capitalize}Model>) {
        } else if (state is ReadErrorState) {
        } else if (state is ReadLoadingState) {}
      },
      builder: (context, state, child) {
        if (state is ReadSuccessState<Read${module.capitalize}${name.capitalize}Model>) {
        } else if (state is ReadErrorState) {
        } else if (state is ReadLoadingState) {}
        return child;
      },
    );
  }
}

''';
  }

  static String writeAsStringSync({
    required String module,
    required String name,
  }) {
    return '''
part of '../$module.dart';

class Write${module.capitalize}${name.capitalize}Widget extends StatelessWidget {
  const Write${module.capitalize}${name.capitalize}Widget({super.key, required this.controller});
  final Write${module.capitalize}${name.capitalize}Controller controller;

  @override
  Widget build(BuildContext context) {
    return ApiBloc(
      controller: controller,
      listener: (context, state) {
        if (state is WriteIdleState) {
        } else if (state is WriteLoadingState) {
        } else if (state is WriteSuccessState<Write${module.capitalize}${name.capitalize}SuccessModel>) {
        } else if (state is WriteFailedState<Write${module.capitalize}${name.capitalize}FailedModel>) {
        } else if (state is WriteErrorState) {}
      },
      builder: (context, state, child) {
        if (state is WriteIdleState) {
        } else if (state is WriteLoadingState) {
        } else if (state is WriteSuccessState<Write${module.capitalize}${name.capitalize}SuccessModel>) {
        } else if (state is WriteFailedState<Write${module.capitalize}${name.capitalize}FailedModel>) {
        } else if (state is WriteErrorState) {}
        return child;
      },
    );
  }
}

''';
  }
}
