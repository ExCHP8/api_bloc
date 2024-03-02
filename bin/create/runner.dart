// ignore_for_file: non_constant_identifier_names, avoid_print

part of '../api_bloc.dart';

final class ApiBloc {
  static void create(ArgResults data) {
    List<String> result = [];
    String output = data['output']!.toString();
    String name = data['create']!.toString();
    StringBuffer buffer = StringBuffer()
      ..write('\n[...] Succesfully generating bloc structure 🚀 [...]\n\n')
      ..write('\x1B[32m');

    // [1] Create module directory
    Directory directory = Directory(output.directoryPath + name.directoryPath)
      ..createSync(recursive: true);

    // [2] Create controller items
    result.addAll(
        Controller.create(from: data, buffer, root: directory, module: name));

    // [3] Create model items
    result.addAll(
        Model.create(from: data, buffer, root: directory, module: name));

    // [4] Create widget items
    result
        .addAll(View.create(from: data, buffer, root: directory, module: name));

    // [5] Create page items
    Page.add(buffer, root: directory, module: name, from: data);

    // Send message
    print(buffer);
  }
}
