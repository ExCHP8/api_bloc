// part of '../api_bloc.dart';

// final class Page {
//   static void add(StringBuffer buffer,
//       {required ArgResults from,
//       required Directory root,
//       required String module}) {
//     File file = File('${root.safePath}$module.dart');
//     bool existed = file.existsSync();
//     List<String> readlist = from['read'];
//     List<String> writelist = from['write'];
//     if (existed) {
//       file
//         ..writeAsStringSync(Page.update(
//           file.readAsLinesSync(),
//           readlist: readlist,
//           writelist: writelist,
//           module: module,
//         ))
//         ..createSync(recursive: true);
//     } else {
//       file
//         ..writeAsStringSync(Page.create(
//           readlist: readlist,
//           writelist: writelist,
//           module: module,
//         ))
//         ..createSync(recursive: true);
//     }

//     buffer
//       ..write('📂 ${root.path}\n')
//       ..write('   📄 ${file.path} ${existed ? '\x1B[34m[RENEWED]' : ''}');
//   }

//   static String update(
//     List<String> input, {
//     required String module,
//     required List<String> readlist,
//     required List<String> writelist,
//   }) {
//     int import = input.lastIndexWhere((e) {
//       String result = e.trim();
//       return result.startsWith('import') && result.endsWith(';');
//     });
//     int part = input.lastIndexWhere((e) {
//       String result = e.trim();
//       return result.startsWith('part') && result.endsWith(';');
//     });
//     int index = import == -1
//         ? part == 1
//             ? 0
//             : part + 1
//         : import + 1;
//     for (var item in readlist) {
//       String controller =
//           "part 'controllers/read_${module}_${item}_controller.dart';";
//       String model = "part 'models/read_${module}_${item}_model.dart';";
//       String widget = "part 'views/read_${module}_${item}_widget.dart';";
//       if (!input.contains(controller)) input.insert(index, controller);
//       if (!input.contains(model)) input.insert(index, model);
//       if (!input.contains(widget)) input.insert(index, widget);
//     }
//     for (var item in writelist) {
//       String controller =
//           "part 'controllers/write_${module}_${item}_controller.dart';";
//       String model = "part 'models/write_${module}_${item}_model.dart';";
//       String widget = "part 'views/write_${module}_${item}_widget.dart';";
//       if (!input.contains(controller)) input.insert(index, controller);
//       if (!input.contains(model)) input.insert(index, model);
//       if (!input.contains(widget)) input.insert(index, widget);
//     }
//     return input.join('\n');
//   }

//   static String create({
//     required String module,
//     required List<String> readlist,
//     required List<String> writelist,
//   }) {
//     StringBuffer buffer = StringBuffer();
//     buffer.write('''
// // Auto-Generated API Bloc structure
// // Created at ${DateTime.now()}
// // 🍔 [Buy me a coffee](https://www.buymeacoffee.com/nialixus) 🚀

// import 'package:api_bloc/api_bloc.dart';
// import 'package:flutter/material.dart';

// ''');

//     for (var item in readlist) {
//       buffer
//         ..writeln("part 'controllers/read_${module}_${item}_controller.dart';")
//         ..writeln("part 'models/read_${module}_${item}_model.dart';")
//         ..writeln("part 'views/read_${module}_${item}_widget.dart';");
//     }

//     for (var item in writelist) {
//       buffer
//         ..writeln("part 'controllers/write_${module}_${item}_controller.dart';")
//         ..writeln("part 'models/write_${module}_${item}_model.dart';")
//         ..writeln("part 'views/write_${module}_${item}_widget.dart';");
//     }

//     buffer.write('''

// // class ${module.capitalize} extends StatefulWidget {
// //  const ${module.capitalize}({super.key});
// //
// //   @override
// //   State<${module.capitalize}> createState() => _${module.capitalize}();
// // }
// //
// // class _${module.capitalize} extends State<${module.capitalize}> {
// ''');

//     for (var item in readlist) {
//       buffer.writeln(
//           '// final _${(module)}${item.capitalize}Reader = Read${module.capitalize}${item.capitalize}Controller();');
//     }
//     for (var item in writelist) {
//       buffer.writeln(
//           '// final _${(module)}${item.capitalize}Writer = Write${module.capitalize}${item.capitalize}Controller();');
//     }

//     buffer.write('''
// //
// // @override
// // Widget build(BuildContext context) {
// //   return const Placeholder();
// // }

// // @override
// // void dispose() {''');

//     for (var item in readlist) {
//       buffer.write('\n//\t\t_${(module)}${item.capitalize}Reader.dispose();');
//     }
//     for (var item in writelist) {
//       buffer.write('\n//\t\t_${(module)}${item.capitalize}Writer.dispose();');
//     }

//     buffer.write('''
// //
// //     super.dispose();
// //   }
// // }''');

//     return buffer.toString();
//   }
// }
