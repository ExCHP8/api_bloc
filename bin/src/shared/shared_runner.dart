part of 'shared.dart';

/// Base view class for all class generator.
abstract class SharedRunner {
  /// Create a new class instance with the given [data] arguments from the command line.
  const SharedRunner(this.data, {this.type = SharedType.models});

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
      '${data['output']}'.toLowerCase().toPath + module.toLowerCase().toPath,
    )..createSync(recursive: true);
  }

  /// Execute to create the template and transform it into a file.
  void run(StringBuffer buffer) {
    final folder =
        Directory('${directory.path.toPath}${type.name.toLowerCase()}')
          ..createSync(recursive: true);

    for (String submodule in submodules) {
      final file = File(
          '${folder.path.toPath}${module.toLowerCase()}_${submodule.toLowerCase()}.dart');

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

  /// Template for the generated file.
  String template({
    required String module,
    required String submodule,
  });
}
