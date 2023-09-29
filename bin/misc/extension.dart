part of '../api_bloc.dart';

extension DirectoryExtension on Directory {
  String get safePath => path.endsWith('/') ? path : '$path/';
}

extension StringExtension on String {
  String get directoryPath => endsWith('/') ? this : '$this/';

  String get capitalize => length > 1
      ? this[0].toUpperCase() + substring(1).toLowerCase()
      : toUpperCase();
}
