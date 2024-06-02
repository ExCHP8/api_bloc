part of 'shared.dart';

/// The type of the module, either `Model`, `View` or `Controller.
enum SharedType {
  models,
  views,
  controllers;

  @override
  String toString() {
    switch (this) {
      case SharedType.models:
        return 'Model';
      case SharedType.views:
        return 'View';
      case SharedType.controllers:
        return 'Controller';
    }
  }
}
