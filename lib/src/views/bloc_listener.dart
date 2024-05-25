part of '../../api_bloc.dart';

/// A shortcut for calling listener function which is used in [BlocConsumer] and [BlocListener].
typedef OnBlocListener<State extends BlocStates> = void Function(
  BuildContext context,
  State state,
);

/// A widget to listen changes in [BlocController].
///
/// ```dart
/// BlocListener<CreateUserController, WriteStates>(
///   listener: (context, state) {
///     switch (state) {
///       case WriteSuccessStates<UserModel> _:
///         return openSenackbar('${state.data.fullName} has been sucessfully created!');
///       default:
///         return;
///     }
///   }
///   child: ...,
/// );
/// ```
class BlocListener<Request extends BlocController<State>,
    State extends BlocStates> extends BlocConsumer<Request, State> {
  /// A widget to listen changes in [BlocController].
  ///
  /// The [controller] is an optional parameter of type [BlocController].
  /// If [controller] is not provided, you need to provide type parameter instead.
  /// The [listener] parameter is used to listen changes in [BlocStates].
  ///
  /// ```dart
  /// // With controller
  /// BlocListener(
  ///   controller: controller,
  ///   listener: (context, state) {
  ///     switch (state) {
  ///       case WriteSuccessStates<UserModel> _:
  ///         return openSenackbar('${state.data.fullName} has been sucessfully created!');
  ///       default:
  ///         return;
  ///     }
  ///   }
  ///   child: ...,
  /// );
  ///
  /// // With type parameter
  /// BlocListener<CreateUserController, WriteStates>(
  ///   listener: (context, state) {
  ///     switch (state) {
  ///       case WriteSuccessStates<UserModel> _:
  ///         return openSenackbar('${state.data.fullName} has been sucessfully created!');
  ///       default:
  ///         return;
  ///     }
  ///   }
  ///   child: ...,
  /// );
  /// ```
  BlocListener({
    super.key,
    super.controller,
    required super.listener,
    super.child,
  }) : super(builder: (context, state, child) => child);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<State>(
      valueListenable: controller ?? context.read<Request>(),
      builder: (context, state, child) {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => listener(context, state),
        );

        return child!;
      },
      child: child,
    );
  }
}
