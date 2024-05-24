part of 'package:api_bloc/api_bloc.dart';

/// Ancestor class of controller used in this package.
///
/// When extending this class, you're going to need overriding [run],
/// it's a function where we executing request on api.
///
/// ```dart
/// class GetHomeRequest extends BlocRequest<BlocStates>{
/// MyController({super.value = LoadingState()});
///
/// @override
/// Future<void> run() async {
///     emit(LoadingState());
///     try {
///       /* do api request here */
///     } catch (e) {
///       emit(ErrorState());
///     }
///   }
/// }
/// ```
abstract class BlocRequest<T extends BlocStates> extends ValueNotifier<T> {
  /// [BlocRequest] requiring a [value] that extends [BlocStates],
  ///
  /// ```dart
  /// class MyContrroller extends BlocRequest<BlocStates>{
  ///   MyController({super.value = LoadingState()});
  /// }
  /// ```
  BlocRequest(super.value);

  /// Updating [BlocStates] value in this controller.
  void emit(T value) => this.value = value;

  /// A function where we execute api request.
  ///
  /// ```dart
  /// @override
  /// Future<void> run({List<Object> args = const []}) async {
  ///     emit(LoadingState());
  ///     try {
  ///       /* do api request here */
  ///     } catch (e) {
  ///       emit(ErrorState());
  ///     }
  ///   }
  /// }
  /// ```
  Future<void> run();

  /// Retrieves [BlocRequest] from [context]. If [BlocRequest] doesnt exist in [context] will throw an error.
  ///
  /// ```dart
  /// BlocRequest controller = BlocRequest.of(context);
  /// ```
  static Request of<Request extends BlocRequest>(BuildContext context) {
    try {
      var value =
          context.dependOnInheritedWidgetOfExactType<ApiBloc<Request>>();

      return value!.controller;
    } catch (error, stackTrace) {
      throw ApiBlocException(
          'ApiBlocException: Unable to retrieve $Request from context.\n\n'
          'Error: $error\n\n'
          'When using BlocRequest.of<$Request>(), ensure that:\n'
          '- The context is within the correct scope under the ApiBloc.\n'
          '- Make sure you are not accessing context.read<$Request>() outside the ApiBloc context.\n'
          '- Good Example:\n\n'
          '    ApiBloc(\n'
          '      controller: $Request(),\n'
          '      child: Builder(\n'
          '        builder: (context) {\n'
          '          final controller = context.read<$Request>();\n'
          '          ...\n'
          '        },\n'
          '      ),\n'
          '    ),\n\n'
          '- Bad Example:\n\n'
          '    ApiBloc(\n'
          '      controller: $Request(),\n'
          '      child: GestureDetector(\n'
          '        onTap: () => context.read<$Request>(),\n'
          '        ...\n'
          '      ),\n'
          '    ),\n',
          stackTrace);
    }
  }
}
