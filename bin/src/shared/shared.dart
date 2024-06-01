library shared;

import 'dart:io';
import 'package:args/args.dart';

part 'models/shared_enum.dart';
part 'models/shared_extension.dart';
part 'models/shared_runner.dart';

final class Shared extends SharedRunner {
  Shared(
    super.data, {
    super.type = SharedType.model,
  });

  @override
  List<String> get submodules {
    return [...data['read'], ...data['write']];
  }

  @override
  String template({
    required String module,
    required String submodule,
  }) {
    // TODO: implement template
    throw UnimplementedError();
  }
}
