library shared;

import 'dart:io';
import 'package:args/args.dart';

part 'shared_enum.dart';
part 'shared_extension.dart';
part 'shared_runner.dart';

final class Shared extends SharedRunner {
  const Shared(
    super.data, {
    required this.runner,
    required this.testRunner,
  }) : super(type: SharedType.models);

  final List<SharedRunner> runner;
  final List<SharedRunner> testRunner;

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
library ${module.toLowerCase()};

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
    Directory folder = Directory(directory.path.toPath)
      ..createSync(recursive: true);
    buffer.write('📂 ${folder.path.toPath}\n');
    File file = File('${folder.path.toPath}$module.dart');

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

    folder = Directory('${data['output']}'
            .toLowerCase()
            .toPath
            .replaceFirst(RegExp(r'(^|/)\blib/'), 'test/') +
        module.toLowerCase().toPath)
      ..createSync(recursive: true);

    buffer.write('📂 ${folder.path.toPath}\n');

    for (var runner in testRunner) {
      runner.run(buffer);
    }
  }
}
