// part of '../api_bloc.dart';

// final class Controller {
//   static List<String> create(StringBuffer buffer,
//       {required ArgResults from,
//       required Directory root,
//       required String module}) {
//     List<String> result = [];
//     List<String> readlist = from['read'];
//     List<String> writelist = from['write'];
//     Directory directory = Directory('${root.path}controllers')
//       ..createSync(recursive: true);
//     buffer.write('📂 ${directory.safePath}\n');

//     for (var name in readlist) {
//       File file =
//           File('${directory.safePath}read_${module}_${name}_controller.dart');
//       result.add(file.path);
//       if (file.existsSync()) {
//         buffer.write('\x1B[30m   📄 ${file.path} \x1B[33m[SKIPPED]\x1B[32m\n');
//       } else {
//         buffer.write('   📄 ${file.path} \n');
//         file
//           ..createSync(recursive: true)
//           ..writeAsStringSync(readAsStringSync(module: module, name: name));
//       }
//     }

//     for (var name in writelist) {
//       File file =
//           File('${directory.safePath}write_${module}_${name}_controller.dart');
//       result.add(file.path);
//       if (file.existsSync()) {
//         buffer.write('\x1B[30m   📄 ${file.path} \x1B[33m[SKIPPED]\x1B[32m\n');
//       } else {
//         buffer.write('   📄 ${file.path} \n');
//         file
//           ..createSync(recursive: true)
//           ..writeAsStringSync(writeAsStringSync(module: module, name: name));
//       }
//     }

//     return result;
//   }

//   static String readAsStringSync({
//     required String module,
//     required String name,
//   }) {
//     return '''
// part of '../$module.dart';

// class Read${module.capitalize}${name.capitalize}Controller extends ReadController {

//   @override
//   Future<void> onRequest(Map<String, dynamic> args) async {
//     // Delay to make the loading state more noticable.
//     await Future.delayed(const Duration(milliseconds: 300));

//     // Emit your success state here ↓↓
//   }

//   @override
//   bool get autoDispose => false;
// }

// ''';
//   }

//   static String writeAsStringSync({
//     required String module,
//     required String name,
//   }) {
//     return '''
// part of '../$module.dart';

// class Write${module.capitalize}${name.capitalize}Controller extends WriteController {

//   @override
//   Future<void> onRequest(Map<String, dynamic> args) async {
//     // Delay to make the loading state more noticable.
//     await Future.delayed(const Duration(milliseconds: 300));

//     // Emit your success and failed state here ↓↓
//   }

//   @override
//   bool get autoDispose => false;
// }

// ''';
//   }
// }
