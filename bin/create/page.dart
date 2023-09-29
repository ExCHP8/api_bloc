part of '../api_bloc.dart';

class Page {
  static void create(List<String> list, StringBuffer buffer,
      {required ArgResults from,
      required Directory root,
      required String module}) {
    File file = File('${root.safePath}$module.dart');
    bool existed = file.existsSync();
    List<String> getlist = from['get'];
    List<String> sendlist = from['send'];
    List<String> read = existed
        ? file
            .readAsLinesSync()
            .where((element) => element.contains(RegExp(r'part.*?;')))
            .toList()
        : [];
    file
      ..writeAsStringSync(writeAsStringSync(
          read: read,
          getlist: getlist,
          sendlist: sendlist,
          list: list.map((e) => e.replaceAll(root.path, '')).toList(),
          module: module))
      ..createSync(recursive: true);
    buffer
      ..write('📂 ${root.path}\n')
      ..write('📄 ${file.path} ${existed ? '\x1B[34m[RENEWED]' : ''}');
  }

  static String writeAsStringSync({
    required String module,
    required List<String> read,
    required List<String> list,
    required List<String> getlist,
    required List<String> sendlist,
  }) {
    List<String> newlist = list
        .map((e) => e.replaceAll(RegExp(r"""(part\s?('|"))|(('|");)"""), ""))
        .toList();
    StringBuffer buffer = StringBuffer();
    buffer.write('''
// Auto-Generated API Bloc structure
// Created at ${DateTime.now()}
// 🍔 [Buy me a coffee](https://www.buymeacoffee.com/nialixus) 🚀

import 'package:api_bloc/api_bloc.dart';
import 'package:flutter/material.dart';

''');

    for (var item in list) {
      buffer.writeln("part '$item';");
    }
    for (var item in read) {
      if (!newlist.contains(
          item.replaceAll(RegExp(r"""(part\s?('|"))|(('|");)"""), ""))) {
        buffer.writeln(item);
      }
    }

    buffer.write('''

// // This is just a sample, copy and paste it in different file to use it.
// // DO NOT EDIT IN HERE !!!
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
