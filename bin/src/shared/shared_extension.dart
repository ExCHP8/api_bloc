part of 'shared.dart';

extension SharedExtension on String {
  String get toPath => endsWith('/') ? this : '$this/';
  String toCamelCase() {
    final data = split(RegExp(r'[^a-zA-Z]+'));
    return data.map((value) {
      return value.length > 1
          ? value[0].toUpperCase() + value.substring(1).toLowerCase()
          : value.toUpperCase();
    }).join();
  }
}
