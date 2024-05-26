part of '../../api_bloc.dart';

/// A widget to listen and rebuilds its descendants when [BlocStates] changes.
///
/// ```dart
/// BlocConsumer<CreateUserController, WriteStates>(
///   listener: (context, state) {
///     switch (state) {
///       case WriteSuccessStates<UserModel> _:
///         return openSenackbar('${state.data.fullName} has been sucessfully created!');
///       default:
///         return;
///     }
///   },
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
class BlocConsumer<Request extends BlocController<State>,
    State extends BlocStates> extends StatelessWidget {
  /// A widget to listen changes in [BlocController].
  ///
  /// The [controller] parameter is used to listen changes in [BlocController].
  /// If [controller] is not provided, you need to provide type parameter instead.
  /// The [listener] parameter is used to listen changes in [BlocStates].
  /// The [builder] parameter is used to rebuild the widget tree when [BlocStates] changes.
  ///
  /// ```dart
  /// BlocConsumer<CreateUserController, WriteStates>(
  ///   listener: (context, state) {
  ///     switch (state) {
  ///       case WriteSuccessStates<UserModel> _:
  ///         return openSenackbar('${state.data.fullName} has been sucessfully created!');
  ///       default:
  ///         return;
  ///     }
  ///   },
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
  const BlocConsumer({
    super.key,
    this.controller,
    required this.listener,
    required this.builder,
    this.child = const Placeholder(),
  });

  /// An optional paremeter of an insance that extends [BlocController]. If not provided, you need to provide type parameter instead.
  ///
  /// ```dart
  /// // With controller
  /// BlocConsumer(
  ///   controller: CreateUserController(),
  ///   ...
  /// );
  ///
  /// // With type parameter
  /// BlocConsumer<CreateUserController, WriteStates>(
  ///   ...,
  /// );
  /// ```
  final Request? controller;

  /// A function to listen changes in [BlocController].
  ///
  /// ```dart
  /// BlocConsumer<CreateUserController, WriteStates>(
  ///   listener: (context, state) {
  ///     switch (state) {
  ///       case WriteSuccessStates<UserModel> _:
  ///         return openSenackbar('${state.data.fullName} has been sucessfully created!');
  ///       default:
  ///         return;
  ///     }
  ///   }
  ///   builder: ...,
  ///   child: ...,
  /// );
  /// ```
  final OnBlocListener<State> listener;

  /// A function to rebuild the widget tree when [BlocStates] changes.
  ///
  /// ```dart
  /// BlocConsumer<CreateUserController, WriteStates>(
  ///   listener: ...,
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
  final OnBlocBuilder<State> builder;

  /// A widget that won't be rebuild when [BlocStates] changes.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<State>(
      valueListenable: controller ?? context.bloc<Request>(),
      builder: (context, value, child) {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => listener(context, value),
        );

        return builder(context, value, child!);
      },
      child: child,
    );
  }
}
