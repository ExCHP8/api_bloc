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
part 'package:api_bloc/src/views/bloc_create.dart';
part 'package:api_bloc/src/views/bloc_listener.dart';

/// A [ApiBloc] is a [StatefulWidget] that is used to manage the state of a [BlocRequest]
/// in the widget tree.
///
/// It takes a [BlocRequest] of type [T] and a [Widget] child as parameters in its constructor.
///
/// The [ApiBloc] is responsible for creating a [State] object (`_BPS`) which is used to manage the state of the [BlocRequest].
///
/// The [ApiBloc] is typically used as an ancestor widget in the widget tree to provide a [BlocRequest] to its descendants.
///
/// The [ApiBloc] should be preferred over a [_BlocCreate] when the state of the [BlocRequest] needs to be
/// accessed by multiple widgets in the widget tree.
class ApiBloc<T extends BlocRequest> extends StatefulWidget {
  /// Creates a [ApiBloc] that takes a [BlocRequest] of type [T] and a [Widget] child as parameters.
  ///
  /// The [controller] parameter is the [BlocRequest] that will be managed by the [ApiBloc].
  ///
  /// The [child] parameter is the [Widget] that will be a descendant of the [ApiBloc].
  const ApiBloc({
    super.key,
    required this.controller,
    required this.child,
  });

  /// The [BlocRequest] that will be managed by the [ApiBloc].
  ///
  /// This is the [BlocRequest] that will be provided to the descendants of the [ApiBloc].
  final T controller;

  /// The [Widget] that will be a descendant of the [ApiBloc].
  ///
  /// This is the [Widget] that will have access to the [BlocRequest] managed by the [ApiBloc].
  final Widget child;

  @override
  State<ApiBloc> createState() => _AB();

  static Widget multi({
    Key? key,
    required List<BlocRequest> controllers,
    required Widget child,
  }) {
    Widget recursive({int index = 0}) {
      if (index < controllers.length) {
        return ApiBloc(
          key: index == 0 ? key : null,
          controller: controllers[index],
          child: recursive(index: index + 1),
        );
      } else {
        return child;
      }
    }

    return recursive(index: 0);
  }
}

class _AB extends State<ApiBloc> {
  @override
  Widget build(BuildContext context) {
    return _BlocCreate(
      controller: widget.controller,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }
}
