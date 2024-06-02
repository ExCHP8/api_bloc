library shared;

import 'dart:io';
import 'package:args/args.dart';

part 'models/shared_enum.dart';
part 'models/shared_extension.dart';
part 'models/shared_runner.dart';

final class Shared extends SharedRunner {
  const Shared(
    super.data, {
    required this.runner,
  }) : super(type: SharedType.models);

  final List<SharedRunner> runner;

  @override
  List<String> get submodules {
    return [...data['read'], ...data['write']];
  }

  @override
  String template({
    required String module,
    required String submodule,
  }) {
    return [
      '''
// Auto-Generated API Bloc structure
// Created at ${DateTime.now()}
// 🍔 [Buy me a coffee](https://www.buymeacoffee.com/nialixus) 🚀

import 'package:api_bloc/api_bloc.dart';
import 'package:flutter/material.dart';
''',
      for (var submodule in submodules)
        "part 'models/${module.toLowerCase()}_${submodule.toLowerCase()}.dart';",
      for (var submodule in submodules)
        "part 'views/${module.toLowerCase()}_${submodule.toLowerCase()}.dart';",
      for (var submodule in submodules)
        "part 'controllers/${module.toLowerCase()}_${submodule.toLowerCase()}.dart';"
    ].join('\n');
  }

  @override
  void run(StringBuffer buffer) {
    final folder = Directory(directory.path.toPath)
      ..createSync(recursive: true);
    buffer.write('📂 ${folder.path.toPath}\n');
    final file = File('${folder.path.toPath}$module.dart');

    if (file.existsSync()) {
      buffer.write('\x1B[30m   📄 ${file.path} \x1B[33m[SKIPPED]\x1B[32m\n');
    } else {
      buffer.write('   📄 ${file.path} \n');
      file
        ..createSync(recursive: true)
        ..writeAsStringSync(template(module: module, submodule: ''));
    }
    for (var runner in this.runner) {
      runner.run(buffer);
    }
  }
}
