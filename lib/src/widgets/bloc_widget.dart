part of 'package:api_bloc/api_bloc.dart';

/// Signature for a function that builds a widget tree based on the current [BlocStates].
typedef BlocBuilder<T extends BlocStates> = Widget Function(
    BuildContext context, T state, Widget child);

/// Signature for a function that builds a widget tree based on the current [BlocStates].
///
/// The [S] type parameter represents an optional generic type that can be used
/// to provide additional data or constraints to the builder.
///
/// The [context] parameter is the build context.
/// The [state] parameter is the current state of the [BlocStates].
/// The [child] parameter is the child widget that should be included in the widget tree.
typedef OnBlocBuilder<S extends Object?> = Widget Function(
    BuildContext context, BlocStates<S> state, Widget child);

/// Signature for a function that listens to changes in the [BlocStates].
typedef BlocListener<T extends BlocStates> = void Function(
    BuildContext context, T state);

/// Signature for a function that listens to changes in the [BlocStates].
///
/// The [S] type parameter represents an optional generic type that can be used
/// to provide additional data or constraints to the listener.
typedef OnBlocListener<S extends Object?> = void Function(
    BuildContext context, BlocStates<S> state);

/// Main widget on dealing [BlocStates] changes in [controller].
class ApiBloc<T extends BlocStates> extends StatefulWidget {
  /// Default constructor for [ApiBloc].
  ///
  /// The [controller] is a required parameter of type [BlocController] that
  /// manages the state.
  ///
  /// The [builder] is an optional parameter of type [BlocBuilder] that builds
  /// a widget tree based on the current [BlocStates].
  ///
  /// The [listener] is an optional parameter of type [BlocListener] that
  /// listens to changes in the [BlocStates].
  ///
  /// The [child] is a required parameter of type [Widget] which will be used
  /// when no [builder] is provided. By default returning a [Placeholder].
  ///
  /// ```dart
  /// ApiBloc(
  ///   controller: FetchController(),
  ///   listener: (context, state) => log(state.toString());
  ///   builder: (context, state, child) {
  ///     if (state is FetchSuccessState<Model>){
  ///       return Text(state.model!.userName);
  ///     } else if (state is FetchErrorState){
  ///       return Text('Oops something is wrong\nReason: ${state.message}');
  ///     } else {
  ///       return const CircularProgressIndicator();
  ///     }
  ///   }
  /// );
  /// ```
  const ApiBloc({
    super.key,
    required this.controller,
    this.child = const Placeholder(),
    this.listener,
    this.builder,
  });

  /// The [BlocController] that manages the state of the [ApiBloc].
  final BlocController<T> controller;

  /// The child widget to be rendered when no [builder] is provided.
  final Widget child;

  /// The [BlocBuilder] function that rebuild its widget by listening to changes
  /// in [BlocController].
  final BlocBuilder<T>? builder;

  /// The [BlocListener] function that listens to changes in the [BlocStates].
  final BlocListener<T>? listener;

  /// Constructor for [ApiBloc] with [BlocBuilder] only.
  ///
  /// Use this constructor when you want to use only the [builder] function to build the widget tree
  /// based on the current [BlocStates].
  const ApiBloc.builder({
    super.key,
    required this.controller,
    this.child = const Placeholder(),
    required this.builder,
  })  : assert(builder != null, 'Builder is required'),
        listener = null;

  /// Constructor for [ApiBloc] with [BlocListener] only.
  ///
  /// Use this constructor when you want to use only the [listener] function
  /// to listen to changes in the [BlocStates].
  const ApiBloc.listener(
      {super.key,
      required this.controller,
      required this.listener,
      required this.child})
      : assert(listener != null, 'Listener is required'),
        builder = null;

  @override
  State<ApiBloc<T>> createState() => _ApiBlocState<T>();

  /// Creates a new instance of [ApiBloc] with the given parameters replaced.
  ///
  /// The [key] parameter is an optional key to be used for the new [ApiBloc] instance.
  /// The [controller] parameter is an optional [BlocController] that manages the state.
  /// The [listener] parameter is an optional [BlocListener] that listens to changes in the [BlocStates].
  /// The [builder] parameter is an optional [BlocBuilder] that rebuilds its widget based on the current [BlocStates].
  /// The [child] parameter is an optional child widget to be rendered when no [builder] is provided.
  ///
  /// Returns a new [ApiBloc] instance with the specified parameters replaced.
  ApiBloc<T> copyWith({
    Key? key,
    BlocController<T>? controller,
    BlocListener<T>? listener,
    BlocBuilder<T>? builder,
    Widget? child,
  }) {
    return ApiBloc(
      key: key ?? this.key,
      controller: controller ?? this.controller,
      listener: listener ?? this.listener,
      builder: builder ?? this.builder,
      child: child ?? this.child,
    );
  }

  /// Creates a new instance of [ApiBloc] with listeners and builders for the SubmitIdleState.
  ///
  /// The [listener] parameter is an optional [OnBlocListener] that listens to the [SubmitIdleState].
  /// The [builder] parameter is an optional [OnBlocBuilder] that rebuilds its widget tree based on the [SubmitIdleState].
  ///
  /// Returns a new [ApiBloc] instance with the specified listeners and builders for the SubmitIdleState.
  ApiBloc<T> onIdle<S extends Object?>({
    OnBlocListener<S>? listener,
    OnBlocBuilder<S>? builder,
  }) {
    return this.copyWith(
      listener: (context, state) {
        if (listener != null) {
          assert(controller is SubmitController,
              "In onIdle listener, The provided controller must be a SubmitController. This requirement is due to the design based on known states pattern.");
          if (controller is SubmitController && state is SubmitIdleState<S>) {
            listener(context, state);
          }
        }
        if (this.listener != null) this.listener!(context, state);
      },
      builder: (context, state, child) {
        if (builder != null) {
          assert(controller is SubmitController,
              "In onIdle builder, The provided controller must be a SubmitController. This requirement is due to the design based on known states pattern.");
          if (controller is SubmitController && state is SubmitIdleState<S>) {
            return builder(context, state, child);
          }
        }
        if (this.builder != null) return this.builder!(context, state, child);
        return child;
      },
    );
  }

  /// Extends the [ApiBloc] with custom logic to handle loading states.
  ///
  /// The `onLoading` method allows you to specify custom listener and builder functions
  /// to handle loading states based on the provided [BlocController].
  ///
  /// If [listener] is specified and the controller is of type [FetchController] or [SubmitController],
  /// it will be called when the state is a loading state.
  ///
  /// If [builder] is specified and the controller is of type [FetchController] or [SubmitController],
  /// it will be used to build the widget tree when the state is a loading state.
  ///
  /// When neither [listener] nor [builder] is specified, the default listener and builder
  /// functions provided during [ApiBloc] instantiation will be used.
  ApiBloc<T> onLoading<S extends Object?>({
    OnBlocListener<S>? listener,
    OnBlocBuilder<S>? builder,
  }) {
    return this.copyWith(
      listener: (context, state) {
        if (listener != null) {
          assert(
              controller is FetchController || controller is SubmitController,
              "In onLoading listener, The provided controller must be either a FetchController or a SubmitController. This requirement is due to the design based on known states pattern.");
          if (controller is FetchController && state is FetchLoadingState<S>) {
            listener(context, state);
          } else if (controller is SubmitController &&
              state is SubmitLoadingState<S>) {
            listener(context, state);
          }
        }
        if (this.listener != null) this.listener!(context, state);
      },
      builder: (context, state, child) {
        if (builder != null) {
          assert(
              controller is FetchController || controller is SubmitController,
              "In onLoading builder, The provided controller must be either a FetchController or a SubmitController. This requirement is due to the design based on known states pattern.");
          if (controller is FetchController && state is FetchLoadingState<S>) {
            return builder(context, state, child);
          } else if (controller is SubmitController &&
              state is SubmitLoadingState<S>) {
            return builder(context, state, child);
          }
        }
        if (this.builder != null) return this.builder!(context, state, child);
        return child;
      },
    );
  }

  /// Extends the [ApiBloc] with custom logic to handle success states.
  ///
  /// The `onSuccess` method allows you to specify custom listener and builder functions
  /// to handle success states based on the provided [BlocController].
  ///
  /// If [listener] is specified and the controller is of type [FetchController] or [SubmitController],
  /// it will be called when the state is a success state.
  ///
  /// If [builder] is specified and the controller is of type [FetchController] or [SubmitController],
  /// it will be used to build the widget tree when the state is a success state.
  ///
  /// When neither [listener] nor [builder] is specified, the default listener and builder
  /// functions provided during [ApiBloc] instantiation will be used.
  ApiBloc<T> onSuccess<S extends Object>({
    OnBlocListener<S>? listener,
    OnBlocBuilder<S>? builder,
  }) {
    return this.copyWith(
      listener: (context, state) {
        if (listener != null) {
          assert(
              controller is FetchController || controller is SubmitController,
              "In onSuccess listener, The provided controller must be either a FetchController or a SubmitController. This requirement is due to the design based on known states pattern.");
          if (controller is FetchController && state is FetchSuccessState<S>) {
            listener(context, state);
          } else if (controller is SubmitController &&
              state is SubmitSuccessState<S>) {
            listener(context, state);
          }
        }
        if (this.listener != null) this.listener!(context, state);
      },
      builder: (context, state, child) {
        if (builder != null) {
          assert(
              controller is FetchController || controller is SubmitController,
              "In onSuccess builder, The provided controller must be either a FetchController or a SubmitController. This requirement is due to the design based on known states pattern.");
          if (controller is FetchController && state is FetchSuccessState<S>) {
            return builder(context, state, child);
          } else if (controller is SubmitController &&
              state is SubmitSuccessState<S>) {
            return builder(context, state, child);
          }
        }
        if (this.builder != null) return this.builder!(context, state, child);
        return child;
      },
    );
  }

  /// Creates a new instance of [ApiBloc] with listeners and builders for the SubmitIdleState.
  ///
  /// The [listener] parameter is an optional [OnBlocListener] that listens to the [SubmitFailedState].
  /// The [builder] parameter is an optional [OnBlocBuilder] that rebuilds its widget tree based on the [SubmitFailedState].
  ///
  /// Returns a new [ApiBloc] instance with the specified listeners and builders for the SubmitIdleState.
  ApiBloc<T> onFailed<S extends Object>({
    OnBlocListener<S>? listener,
    OnBlocBuilder<S>? builder,
  }) {
    return this.copyWith(
      listener: (context, state) {
        if (listener != null) {
          assert(controller is SubmitController,
              "In onFailed listener, The provided controller must be a SubmitController. This requirement is due to the design based on known states pattern.");
          if (controller is SubmitController && state is SubmitFailedState<S>) {
            listener(context, state);
          }
        }
        if (this.listener != null) this.listener!(context, state);
      },
      builder: (context, state, child) {
        if (builder != null) {
          assert(controller is SubmitController,
              "In onFailed builder, The provided controller must be a SubmitController. This requirement is due to the design based on known states pattern.");
          if (controller is SubmitController && state is SubmitFailedState<S>) {
            return builder(context, state, child);
          }
        }
        if (this.builder != null) return this.builder!(context, state, child);
        return child;
      },
    );
  }

  /// Extends the [ApiBloc] with custom logic to handle error states.
  ///
  /// The `onError` method allows you to specify custom listener and builder functions
  /// to handle error states based on the provided [BlocController].
  ///
  /// If [listener] is specified and the controller is of type [FetchController] or [SubmitController],
  /// it will be called when the state is an error state.
  ///
  /// If [builder] is specified and the controller is of type [FetchController] or [SubmitController],
  /// it will be used to build the widget tree when the state is an error state.
  ///
  /// When neither [listener] nor [builder] is specified, the default listener and builder
  /// functions provided during [ApiBloc] instantiation will be used.
  ApiBloc<T> onError<S extends Object?>({
    OnBlocListener<S>? listener,
    OnBlocBuilder<S>? builder,
  }) {
    return this.copyWith(
      listener: (context, state) {
        if (listener != null) {
          assert(
              controller is FetchController || controller is SubmitController,
              "In onError listener, The provided controller must be either a FetchController or a SubmitController. This requirement is due to the design based on known states pattern.");
          if (controller is FetchController && state is FetchErrorState<S>) {
            listener(context, state);
          } else if (controller is SubmitController &&
              state is SubmitErrorState<S>) {
            listener(context, state);
          }
        }
        if (this.listener != null) this.listener!(context, state);
      },
      builder: (context, state, child) {
        if (builder != null) {
          assert(
              controller is FetchController || controller is SubmitController,
              "In onError builder, The provided controller must be either a FetchController or a SubmitController. This requirement is due to the design based on known states pattern.");
          if (controller is FetchController && state is FetchErrorState<S>) {
            return builder(context, state, child);
          } else if (controller is SubmitController &&
              state is SubmitErrorState<S>) {
            return builder(context, state, child);
          }
        }
        if (this.builder != null) return this.builder!(context, state, child);
        return child;
      },
    );
  }
}

class _ApiBlocState<T extends BlocStates> extends State<ApiBloc<T>> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<T>(
        valueListenable: widget.controller,
        builder: (context, value, child) {
          if (widget.listener != null) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              widget.listener!(context, value);
            });
          }
          return widget.builder != null
              ? widget.builder!(context, value, child!)
              : child!;
        },
        child: widget.child);
  }

  @override
  void dispose() {
    try {
      if (widget.controller.autoDispose) widget.controller.dispose();
    } catch (e) {
      /* do nothing */
    }
    super.dispose();
  }
}
