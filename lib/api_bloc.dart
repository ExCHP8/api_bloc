/// A Flutter library for managing API calls using the BLoC pattern.
/// This library provides a set of classes and utilities to simplify API
/// calls and manage state changes.
library api_bloc;

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'package:api_bloc/src/controllers/bloc_request.dart';
part 'package:api_bloc/src/controllers/read_request.dart';
part 'package:api_bloc/src/controllers/write_request.dart';
part 'package:api_bloc/src/models/read_states.dart';
part 'package:api_bloc/src/models/write_states.dart';
part 'package:api_bloc/src/models/bloc_states.dart';
part 'package:api_bloc/src/views/bloc_builder.dart';
part 'package:api_bloc/src/views/bloc_consumer.dart';
part 'package:api_bloc/src/views/bloc_listener.dart';

class ApiBloc<Request extends BlocRequest> extends InheritedWidget {
  ApiBloc({
    super.key,
    required this.controller,
    required Widget child,
  }) : super(child: ApiBlocManager(controller: controller, child: child));
  final Request controller;

  @override
  bool updateShouldNotify(covariant ApiBloc<Request> oldWidget) {
    return oldWidget.controller != controller;
  }
}

class ApiBlocManager<Request extends BlocRequest> extends StatefulWidget {
  const ApiBlocManager({
    super.key,
    required this.controller,
    required this.child,
  });
  final Request controller;
  final Widget child;

  @override
  State<ApiBlocManager> createState() => ApiBlocStateManager();
}

class ApiBlocStateManager extends State<ApiBlocManager> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }
}

/// A collection of extension used in this package.
extension ApiBlocExtension on BuildContext {
  /// Retrieves an instance of [BlocRequest] from the current context.
  ///
  /// The [Request] type parameter specifies the type of [BlocRequest] to retrieve.
  ///
  /// Returns an instance of [Request] that is managed by the nearest ancestor
  /// [ApiBloc] widget in the widget tree.
  ///
  /// Throws an error if no [ApiBloc] widget is found in the ancestor tree.
  Request read<Request extends BlocRequest>() {
    return BlocRequest.of<Request>(this);
  }
}

class ApiBlocException implements Exception {
  const ApiBlocException(this.message, this.stackTrace);
  final String message;
  final StackTrace stackTrace;

  @override
  String toString() => '$message\n\nStackTrace: \n\n$stackTrace)';
}
