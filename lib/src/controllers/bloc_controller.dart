part of 'package:api_bloc/api_bloc.dart';

/// Ancestor class of controller used in this package.
///
/// When extending this class, you're going to need overriding [run],
/// it's a function where we executing REST API request.
///
/// ```dart
/// class GetUserRequest extends BlocController<ReadStates>{
///   GetUserRequest([super.value = const ReadLoadingState()]);
///
///   @override
///   Future<void> run() async {
///       emit(const ReadLoadingState());
///       try {
///         /* emit ReadSuccessState here */
///       } catch (e) {
///         emit(ReadErrorState());
///       }
///    }
///   }
/// }
/// ```
abstract class BlocController<T extends BlocStates> extends ValueNotifier<T> {
  /// [BlocController] requiring a [value] that extends [BlocStates],
  ///
  /// ```dart
  /// class GetUserRequest extends BlocController<ReadStates>{
  ///   GetUserRequest([super.value = const ReadLoadingState()]);
  ///
  ///   @override
  ///   Future<void> run() async {
  ///       emit(const ReadLoadingState());
  ///       try {
  ///         /* emit ReadSuccessState here */
  ///       } catch (e) {
  ///         emit(ReadErrorState());
  ///       }
  ///    }
  ///   }
  /// }
  /// ```
  BlocController(super.value);

  /// Updating [value] in this controller.
  void emit(T value) => this.value = value;

  /// A function where we execute REST API request.
  ///
  /// ```dart
  /// @override
  /// Future<void> run() async {
  ///     emit(const ReadLoadingState());
  ///     try {
  ///       /* emit ReadSuccessState here */
  ///     } catch (e) {
  ///       emit(ReadErrorState());
  ///     }
  ///  }
  /// ```
  Future<void> run();

  /// Retrieves [BlocController] from [context]. If [BlocController] doesnt exist in [context] will throw an error.
  ///
  /// ```dart
  /// GetUserController controller = BlocController.of<GetUserController>(context);
  /// ```
  static Request of<Request extends BlocController>(BuildContext context) {
    try {
      var value =
          context.dependOnInheritedWidgetOfExactType<ApiBloc<Request>>();

      return value!.controller;
    } catch (error, stackTrace) {
      throw ApiBlocException(
          'ApiBlocException: Unable to retrieve $Request from context.\n\n'
          'Error: $error\n\n'
          'When using BlocController.of<$Request>(), ensure that:\n'
          '- The context is within the correct scope under the ApiBloc.\n'
          '- Make sure you are not accessing context.bloc<$Request>() outside the ApiBloc context.\n'
          '- Good Example:\n\n'
          '    ApiBloc(\n'
          '      controller: $Request(),\n'
          '      builder: (context, _) {\n'
          '        final controller = context.bloc<$Request>();\n'
          '        ...\n'
          '      },\n'
          '    ),\n\n'
          '- Bad Example:\n\n'
          '    ApiBloc(\n'
          '      controller: $Request(),\n'
          '      child: GestureDetector(\n'
          '        onTap: context.bloc<$Request>().run,\n'
          '        ...\n'
          '      ),\n'
          '    ),\n',
          stackTrace);
    }
  }
}
