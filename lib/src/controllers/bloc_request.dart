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
  BlocRequest({required T value}) : super(value);

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
  static T of<T extends BlocRequest>(BuildContext context) {
    try {
      var value = context.dependOnInheritedWidgetOfExactType<_BlocCreate<T>>();

      return value!.controller;
    } catch (error, stackTrace) {
      throw BlocException(
          'BlocException: Unable to retrieve $T from context.\n\n'
          'Error: $error\n\n'
          'When using BlocRequest.of<$T>(), ensure that:\n'
          '- The context is within the correct scope under the ApiBloc.\n'
          '- Make sure you are not accessing context.read<$T>() outside the ApiBloc context.\n'
          '- Good Example:\n\n'
          '    ApiBloc(\n'
          '      controller: $T(),\n'
          '      child: Builder(\n'
          '        builder: (context) {\n'
          '          final controller = context.read<$T>();\n'
          '          ...\n'
          '        },\n'
          '      ),\n'
          '    ),\n\n'
          '- Bad Example:\n\n'
          '    ApiBloc(\n'
          '      controller: $T(),\n'
          '      child: GestureDetector(\n'
          '        onTap: () => context.read<$T>(),\n'
          '        ...\n'
          '      ),\n'
          '    ),\n',
          stackTrace);
    }
  }
}
