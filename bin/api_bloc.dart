// ignore_for_file: avoid_print

import 'package:args/args.dart';
import 'src/shared/shared.dart';
import 'src/read/read.dart';
import 'src/write/write.dart';

Future<void> main(List<String> arguments) async {
  ArgParser creator = ArgParser()
    ..addOption('create',
        help: 'Name of the desired generated module', mandatory: true)
    ..addMultiOption('read', help: 'List of generated reader method in module')
    ..addMultiOption('write', help: 'List of generated writer method in module')
    ..addOption('output',
        abbr: 'o',
        defaultsTo: 'lib/src/',
        help: 'Output directory of created bloc with mvc structure')
    ..addFlag('help',
        abbr: 'h',
        negatable: false,
        defaultsTo: false,
        help: 'Print this usage information');
  try {
    final argument = creator.parse(arguments);
    if (argument["help"] == true) {
      throw '\x1B[0mAvailable commands:';
    } else {
      StringBuffer buffer = StringBuffer()
        ..write('\n[...] Successfully generating bloc structure 🚀 [...]\n\n')
        ..write('\x1B[32m');

      Shared(
        argument,
        runner: [
          ReadController(argument),
          WriteController(argument),
          ReadModel(argument),
          WriteModel(argument),
          ReadView(argument),
          WriteView(argument),
        ],
      ).run(buffer);

      print(buffer);
    }
  } catch (e) {
    print('\n\x1B[31m$e\x1B[0m\n\n\x1B[32m${creator.usage}\x1B[0m');
  }
}
