// ignore_for_file: non_constant_identifier_names

part of '../api_bloc.dart';

Future<void> create(ArgResults from) async {
  final buffer = StringBuffer()
    ..write('\n[...] Succesfully generating bloc structure 🚀 [...]\n\n')
    ..write('\x1B[33m');
  final output_path = from['output']!.toString();
  Directory output = Directory(
    output_path.endsWith('/') ? output_path : '$output_path/',
  );

  // Create module directory
  final module_path = from['create'].toString();
  Directory module = Directory(
    output.path + (module_path.endsWith('/') ? module_path : '$module_path/'),
  )..createSync(recursive: true);
  File file = File('${module.path}$module_path.dart')
    ..writeAsStringSync('')
    ..createSync();
  buffer
    ..write('📂 ${module.path}\n')
    ..write('📄 ${file.path}\n');

  // Create controller items
  Directory controller = Directory('${module.path}controllers')
    ..createSync(recursive: true);
  buffer.write('📂 ${controller.path}\n');

  final controller_files = from['get'];
  for (var path in controller_files) {
    File controller_path = File(
        '${(controller.path.endsWith('/') ? controller.path : '${controller.path}/') + path}.dart')
      ..createSync(recursive: true);
    buffer.write('   📄 ${controller_path.path}\n');
  }

  // Create model items
  Directory models = Directory('${module.path}models')
    ..createSync(recursive: true);
  buffer.write('📂 ${models.path}\n');

  // Create widget items
  Directory widgets = Directory('${module.path}widgets')
    ..createSync(recursive: true);
  buffer.write('📂 ${widgets.path}\n');

  buffer.write('\x1B[0m');
  print(buffer);
}
