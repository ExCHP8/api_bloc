// ignore_for_file: non_constant_identifier_names, avoid_print

part of '../api_bloc.dart';

class ApiBloc {
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
    Directory('${directory.path}pages').createSync();

    // [2] Create controller items
    result.addAll(
        Controller.create(from: data, buffer, root: directory, module: name));

    // [3] Create model items
    result.addAll(
        Model.create(from: data, buffer, root: directory, module: name));

    // [4] Create widget items
    result.addAll(
        Widget.create(from: data, buffer, root: directory, module: name));

    // [5] Create page items
    Page.create(result, buffer, root: directory, module: name, from: data);

    // Send message
    print(buffer);
  }
}
