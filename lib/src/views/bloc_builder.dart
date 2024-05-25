part of 'package:api_bloc/api_bloc.dart';

/// A shortcut for calling builder function which is used in [BlocConsumer] and [BlocBuilder].
typedef OnBlocBuilder<State extends BlocStates> = Widget Function(
  BuildContext context,
  State state,
  Widget child,
);

/// A widget that rebuilds its descendants when [BlocStates] changes.
///
/// ```dart
/// BlocBuilder<GetUserController, ReadStates>(
///   builder: (context, state, child) {
///     switch (state) {
///       case WriteSuccessStates<UserModel> _:
///         return Text('${state.data.fullName} has been sucessfully loaded!');
///       default:
///         return child;
///     }
///   },
///   child: ...,
/// );
/// ```
class BlocBuilder<Request extends BlocController<State>,
    State extends BlocStates> extends BlocConsumer<Request, State> {
  /// A widget that rebuilds its descendants when [BlocStates] changes.
  ///
  /// The [controller] is an optional parameter of type [BlocController].
  /// If [controller] is not provided, you need to provide type parameter instead.
  /// The [builder] parameter is used to rebuild the widget tree when [BlocStates] changes.
  ///
  /// ```dart
  /// // With controller
  /// BlocBuilder(
  ///   controller: controller,
  ///   listener: (context, state, child) {
  ///     switch (state) {
  ///       case ReadSuccessStates<UserModel> _:
  ///         return Text('${state.data.fullName} has been sucessfully loaded!');
  ///       default:
  ///         return child;
  ///     }
  ///   }
  ///   child: ...,
  /// );
  ///
  /// // With type parameter
  /// BlocBuilder<GetUserController, ReadStates>(
  ///   listener: (context, state, child) {
  ///     switch (state) {
  ///       case ReadSuccessStates<UserModel> _:
  ///         return Text('${state.data.fullName} has been sucessfully loaded!');
  ///       default:
  ///         return child;
  ///     }
  ///   }
  ///   child: ...,
  /// );
  /// ```
  BlocBuilder({
    super.key,
    super.controller,
    required super.builder,
    super.child,
  }) : super(listener: (context, state) {});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<State>(
      valueListenable: controller ?? context.read<Request>(),
      builder: (context, state, child) {
        return builder(context, state, child!);
      },
      child: child,
    );
  }
}
