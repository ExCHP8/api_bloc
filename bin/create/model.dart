part of '../api_bloc.dart';

final class Model {
  static List<String> create(StringBuffer buffer,
      {required ArgResults from,
      required Directory root,
      required String module}) {
    List<String> result = [];
    List<String> getlist = from['get'];
    List<String> sendlist = from['send'];
    Directory directory = Directory('${root.path}models')
      ..createSync(recursive: true);
    buffer.write('📂 ${directory.safePath}\n');

    for (var name in getlist) {
      File file = File('${directory.safePath}get_${module}_${name}_model.dart');
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
          File('${directory.safePath}send_${module}_${name}_model.dart');
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

class Get${module.capitalize}${name.capitalize}Model {}
''';
  }

  static String sendAsStringSync({
    required String module,
    required String name,
  }) {
    return '''
part of '../$module.dart';

class Send${module.capitalize}${name.capitalize}SuccessModel {}

class Send${module.capitalize}${name.capitalize}FailedModel {}
''';
  }
}
