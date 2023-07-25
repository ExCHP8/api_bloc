part of 'package:api_bloc/api_bloc.dart';

/// Ancestor class of controller used in this package.
///
/// When extending this class, you're going to need overriding [run],
/// it's a function where we executing request on api.
///
/// ```dart
/// class MyController extends BlocController<BlocStates>{
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
///
/// @override
/// bool get autoDispose => super.autoDispose;
/// ```
abstract class BlocController<T extends BlocStates> extends ValueNotifier<T> {
  /// [BlocController] requiring a [value] that extends [BlocStates],
  ///
  /// ```dart
  /// class MyContrroller extends BlocController<BlocStates>{
  ///   MyController({super.value = LoadingState()});
  /// }
  /// ```
  ///
  /// and [BlocController] also automatically set [autoDispose] as `true`.
  BlocController({required T value, this.autoDispose = true}) : super(value);

  /// Updating [BlocStates] value in this controller.
  void emit(T value) => this.value = value;

  /// A function where we execute api request.
  ///
  /// ```dart
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
  Future<void> run({List<Object> args = const []});

  /// Whether the controller that we created and associated to certain route
  /// should be automatically dispose or not. By default it's `true`.
  final bool autoDispose;
}
