part of 'package:api_bloc/api_bloc.dart';

/// Signature for a function that builds a widget tree based on the current [BlocStates].
typedef BlocBuilder<T extends BlocStates> = Widget Function(
    BuildContext context, T state, Widget child);

/// Signature for a function that listens to changes in the [BlocStates].
typedef BlocListener<T extends BlocStates> = void Function(
    BuildContext context, T state);

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
}

class _ApiBlocState<T extends BlocStates> extends State<ApiBloc<T>> {
  @override
  void initState() {
    if (widget.listener != null) {
      widget.controller.addListener(() {
        if (mounted) setState(() {});
        widget.listener!(context, widget.controller.value);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log("BUILD");
    if (widget.builder != null) {
      return ValueListenableBuilder<T>(
          valueListenable: widget.controller,
          builder: (context, value, child) {
            log("Rebuild");
            return widget.builder!(context, value, child!);
          },
          child: widget.child);
    } else {
      return widget.child;
    }
  }

  @override
  void dispose() {
    try {
      if (widget.controller.autoDispose) {
        widget.controller.dispose();
        print("Disposed");
      }
    } catch (e) {/* do nothing */}
    super.dispose();
  }
}
