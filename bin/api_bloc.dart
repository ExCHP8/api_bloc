// ignore_for_file: avoid_print
import 'dart:io';
import 'package:args/args.dart';

part 'misc/extension.dart';
part 'create/runner.dart';
part 'create/controller.dart';
part 'create/model.dart';
part 'create/views.dart';
part 'create/page.dart';

Future<void> main(List<String> arguments) async {
  ArgParser creator = ArgParser()
    ..addOption('create',
        help: 'Name of the desired generated module', mandatory: true)
    ..addMultiOption('read', help: 'List of generated reader method in module')
    ..addMultiOption('write', help: 'List of generated writer method in module')
    ..addOption('output',
        abbr: 'o',
        defaultsTo: 'lib/src/',
        help: 'Output directory of created bloc structure')
    ..addFlag('help',
        abbr: 'h',
        negatable: false,
        defaultsTo: false,
        help: 'Print this usage information');
  try {
    ArgResults argument = creator.parse(arguments);
    if (argument["help"]) {
      throw '\x1B[0mAvailable commands:';
    } else {
      ApiBloc.create(argument);
    }
  } catch (e) {
    print('\n\x1B[31m$e\x1B[0m\n\n${creator.usage}');
  }
}
