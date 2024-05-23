part of '../../api_bloc.dart';

/// A private class that extends [InheritedWidget] to manage the state of [BlocRequest].
///
/// This class is used in [ApiBloc] to manage the state of [BlocRequest].
/// It provides a way to pass the state of [BlocRequest] down the widget tree.
/// It overrides the [updateShouldNotify] method to compare the old and new
/// [BlocRequest] and determine whether the state should be updated.
class _BlocCreate<T extends BlocRequest> extends InheritedWidget {
  /// Creates a [_BlocCreate] widget.
  ///
  /// The [controller] parameter is the [BlocRequest] to be managed.
  /// The [child] parameter is the widget that will be passed down the widget tree.
  const _BlocCreate({
    super.key,
    required this.controller,
    required super.child,
  });

  /// The [BlocRequest] to be managed.
  final T controller;

  @override
  bool updateShouldNotify(_BlocCreate oldWidget) {
    return oldWidget.controller != controller;
  }
}

/// A collection of extension used in this package.
extension BlocExtension on BuildContext {
  /// Retrieves an instance of [BlocRequest] from the current context.
  ///
  /// The [T] type parameter specifies the type of [BlocRequest] to retrieve.
  ///
  /// Returns an instance of [T] that is managed by the nearest ancestor
  /// [ApiBloc] widget in the widget tree.
  ///
  /// Throws an error if no [ApiBloc] widget is found in the ancestor tree.
  T read<T extends BlocRequest>() {
    return BlocRequest.of<T>(this);
  }
}

class BlocException implements Exception {
  const BlocException(this.message, this.stackTrace);
  final String message;
  final StackTrace stackTrace;

  @override
  String toString() {
    return '$message\n\nStackTrace: \n\n$stackTrace)';
  }
}
