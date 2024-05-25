/// A Flutter library for managing API calls using the BLoC pattern.
/// This library provides a set of classes and utilities to simplify API
/// calls and manage state changes.
library api_bloc;

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

part 'package:api_bloc/src/controllers/bloc_controller.dart';
part 'package:api_bloc/src/controllers/read_controller.dart';
part 'package:api_bloc/src/controllers/write_controller.dart';
part 'package:api_bloc/src/models/read_states.dart';
part 'package:api_bloc/src/models/write_states.dart';
part 'package:api_bloc/src/models/bloc_states.dart';
part 'package:api_bloc/src/views/bloc_builder.dart';
part 'package:api_bloc/src/views/bloc_consumer.dart';
part 'package:api_bloc/src/views/bloc_listener.dart';

/// A class that initiate the [BlocController] and inject its value into its descendants.
///
/// ```dart
/// ApiBloc(
///   controller: GetUserController(),
///   builder: (context, controller) {
///     return Scaffold(...);
///   }
/// );
/// ```
class ApiBloc<Request extends BlocController> extends InheritedWidget {
  /// Creates an instance of [ApiBloc].
  ///
  /// The [controller] parameter is required and must be an instance that extends [BlocController].
  /// [dispose] is a parameter that determines if the [controller] should be disposed when the widget is disposed, by default it's `true`.
  /// [builder] provides a safe context and controller access to the widget tree.
  /// [child] is an optional parameter that specifies the child widget to be rendered, if [builder] is not null [child] will be ignored.
  ///
  /// ```dart
  /// ApiBloc(
  ///   controller: GetUserController(),
  ///   builder: (context, controller) {
  ///     return Scaffold(...);
  ///   }
  /// );
  ///
  /// // or
  ///
  /// ApiBloc(
  ///   controller: GetUserController(),
  ///   child: Scaffold(...),
  /// );
  /// ```
  ApiBloc({
    super.key,
    this.dispose = true,
    required this.controller,
    Widget Function(BuildContext context, Request controller)? builder,
    Widget child = const Placeholder(),
  }) : super(
          child: _ApiBlocManager(
            dispose: dispose,
            controller: controller,
            child: Builder(
              builder: (context) {
                if (builder == null) return child;
                return builder(context, context.read<Request>());
              },
            ),
          ),
        );

  /// An instance of [BlocController] that will be passed to the descendants.
  final Request controller;

  /// Determines if the [controller] should be disposed when the widget is disposed, by default it's `true`.
  final bool dispose;

  @override
  bool updateShouldNotify(covariant ApiBloc<Request> oldWidget) {
    return oldWidget.controller != controller;
  }

  // static Widget multi<Request extends BlocController>({
  //   required List<Request> controllers,
  //   required Widget Function(BuildContext context, Request controller) builder,
  // }) {
  //   Widget recursive<T extends BlocController>([int index = 0]) {
  //     return ApiBloc<T>(
  //       controller: controllers[index] as T,
  //       child: !(index + 1 >= controllers.length)
  //           ? recursive<T>(index + 1)
  //           : Builder(
  //               builder: (context) => builder(
  //                 context,
  //                 controllers[index],
  //               ),
  //             ),
  //     );
  //   }

  //   return recursive<Request>();
  // }
}

class _ApiBlocManager<Request extends BlocController> extends StatefulWidget {
  const _ApiBlocManager({
    super.key,
    required this.dispose,
    required this.controller,
    required this.child,
  });
  final Request controller;
  final bool dispose;
  final Widget child;

  @override
  State<_ApiBlocManager> createState() => _ApiBlocStateManager();
}

class _ApiBlocStateManager extends State<_ApiBlocManager> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    if (widget.dispose) widget.controller.dispose();
    super.dispose();
  }
}

/// A collection of extension used in [ApiBloc] library.
extension ApiBlocExtension on BuildContext {
  /// Retrieves an instance of [BlocController] from the current context.
  ///
  /// The [Request] type parameter specifies the type of [BlocController] to retrieve.
  ///
  /// Returns an instance of [Request] that is managed by the nearest ancestor
  /// [ApiBloc] widget in the widget tree.
  ///
  /// Throws an error if no [ApiBloc] widget is found in the ancestor tree.
  Request read<Request extends BlocController>() {
    return BlocController.of<Request>(this);
  }
}

/// An exception thrown when an error occurs in the [ApiBloc] library.
class ApiBlocException implements Exception {
  /// Creates an instance of [ApiBlocException].
  ///
  /// [message] and [stackTrace] are required parameters.
  const ApiBlocException(this.message, this.stackTrace);

  /// The error message.
  final String message;

  /// Stacktrace of the error.
  final StackTrace stackTrace;

  @override
  String toString() => '$message\n\nStackTrace: \n\n$stackTrace)';
}
