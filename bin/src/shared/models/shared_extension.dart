part of '../shared.dart';

extension SharedExtension on String {
  String get toPath => endsWith('/') ? this : '$this/';
  String toCamelCase() => length > 1
      ? this[0].toUpperCase() + substring(1).toLowerCase()
      : toUpperCase();
}
