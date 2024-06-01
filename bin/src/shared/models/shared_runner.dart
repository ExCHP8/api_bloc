part of '../shared.dart';

/// Base view class for all class generator.
abstract class SharedRunner {
  /// Create a new class instance with the given [data] arguments from the command line.
  const SharedRunner(this.data, {this.type = SharedType.model});

  /// The parsed command line arguments.
  final ArgResults data;

  /// The type of the module, either `Model`, `View` or `Controller.
  final SharedType type;

  /// The name of the module.
  String get module {
    return data['create'];
  }

  /// The submodules of the module.
  List<String> get submodules;

  /// The directory of the module.
  Directory get directory {
    return Directory(
      '${data['output']}'.toPath + module.toPath,
    )..createSync(recursive: true);
  }

  /// Execute and create the view into the [directory].
  void run(StringBuffer buffer) {
    final folder =
        Directory('${directory.path.toPath}${type.name.toLowerCase()}')
          ..createSync(recursive: true);
    buffer.write('📂 ${folder.path.toPath}\n');

    for (String submodule in submodules) {
      final file = File('${folder.path.toPath}${module}_$submodule.dart');

      if (file.existsSync()) {
        buffer.write('\x1B[30m   📄 ${file.path} \x1B[33m[SKIPPED]\x1B[32m\n');
      } else {
        buffer.write('   📄 ${file.path} \n');
        file
          ..createSync(recursive: true)
          ..writeAsStringSync(template(module: module, submodule: submodule));
      }
    }
  }

  /// Template for the view.
  String template({
    required String module,
    required String submodule,
  });
}