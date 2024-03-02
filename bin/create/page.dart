part of '../api_bloc.dart';

final class Page {
  static void add(StringBuffer buffer,
      {required ArgResults from,
      required Directory root,
      required String module}) {
    File file = File('${root.safePath}$module.dart');
    bool existed = file.existsSync();
    List<String> getlist = from['get'];
    List<String> sendlist = from['send'];
    if (existed) {
      file
        ..writeAsStringSync(Page.update(
          file.readAsLinesSync(),
          getlist: getlist,
          sendlist: sendlist,
          module: module,
        ))
        ..createSync(recursive: true);
    } else {
      file
        ..writeAsStringSync(Page.create(
          getlist: getlist,
          sendlist: sendlist,
          module: module,
        ))
        ..createSync(recursive: true);
    }

    buffer
      ..write('📂 ${root.path}\n')
      ..write('   📄 ${file.path} ${existed ? '\x1B[34m[RENEWED]' : ''}');
  }

  static String update(
    List<String> input, {
    required String module,
    required List<String> getlist,
    required List<String> sendlist,
  }) {
    int import = input.lastIndexWhere((e) {
      String result = e.trim();
      return result.startsWith('import') && result.endsWith(';');
    });
    int part = input.lastIndexWhere((e) {
      String result = e.trim();
      return result.startsWith('part') && result.endsWith(';');
    });
    int index = import == -1
        ? part == 1
            ? 0
            : part + 1
        : import + 1;
    for (var item in getlist) {
      String controller =
          "part 'controllers/get_${module}_${item}_controller.dart';";
      String model = "part 'models/get_${module}_${item}_model.dart';";
      String widget = "part 'views/get_${module}_${item}_widget.dart';";
      if (!input.contains(controller)) input.insert(index, controller);
      if (!input.contains(model)) input.insert(index, model);
      if (!input.contains(widget)) input.insert(index, widget);
    }
    for (var item in sendlist) {
      String controller =
          "part 'controllers/send_${module}_${item}_controller.dart';";
      String model = "part 'models/send_${module}_${item}_model.dart';";
      String widget = "part 'views/send_${module}_${item}_widget.dart';";
      if (!input.contains(controller)) input.insert(index, controller);
      if (!input.contains(model)) input.insert(index, model);
      if (!input.contains(widget)) input.insert(index, widget);
    }
    return input.join('\n');
  }

  static String create({
    required String module,
    required List<String> getlist,
    required List<String> sendlist,
  }) {
    StringBuffer buffer = StringBuffer();
    buffer.write('''
// Auto-Generated API Bloc structure
// Created at ${DateTime.now()}
// 🍔 [Buy me a coffee](https://www.buymeacoffee.com/nialixus) 🚀

import 'package:api_bloc/api_bloc.dart';
import 'package:flutter/material.dart';

''');

    for (var item in getlist) {
      buffer
        ..writeln("part 'controllers/get_${module}_${item}_controller.dart';")
        ..writeln("part 'models/get_${module}_${item}_model.dart';")
        ..writeln("part 'views/get_${module}_${item}_widget.dart';");
    }

    for (var item in sendlist) {
      buffer
        ..writeln("part 'controllers/send_${module}_${item}_controller.dart';")
        ..writeln("part 'models/send_${module}_${item}_model.dart';")
        ..writeln("part 'views/send_${module}_${item}_widget.dart';");
    }

    buffer.write('''

// class ${module.capitalize} extends StatefulWidget {
//  const ${module.capitalize}({super.key});
//
//   @override
//   State<${module.capitalize}> createState() => _${module.capitalize}();
// }
//
// class _${module.capitalize} extends State<${module.capitalize}> {
''');

    for (var item in getlist) {
      buffer.writeln(
          '// final _${(module)}${item.capitalize}Getter = Get${module.capitalize}${item.capitalize}Controller();');
    }
    for (var item in sendlist) {
      buffer.writeln(
          '// final _${(module)}${item.capitalize}Sender = Send${module.capitalize}${item.capitalize}Controller();');
    }

    buffer.write('''
//
// @override
// Widget build(BuildContext context) {
//   return const Placeholder();
// }

// @override
// void dispose() {''');

    for (var item in getlist) {
      buffer.write('\n//\t\t_${(module)}${item.capitalize}Getter.dispose();');
    }
    for (var item in sendlist) {
      buffer.write('\n//\t\t_${(module)}${item.capitalize}Sender.dispose();');
    }

    buffer.write('''
//
//     super.dispose();
//   }
// }''');

    return buffer.toString();
  }
}
