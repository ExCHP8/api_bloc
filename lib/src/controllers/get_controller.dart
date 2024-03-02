part of 'package:api_bloc/api_bloc.dart';

/// An extended abstract class of [BlocController] specifically made for
/// fetching api request.
///
/// ```dart
/// class GetUserController extends GetController {
///   @override
///   Future<void> onRequest() async {
///     Response response = await Response.get('https://base.url/api/user',
///       onProgress: (double progress) {
///         emit(GetLoadingState<double>(data: progress));
///         }
///       );
///
///     UserModel model = UserModel.fromJson(response.data);
///     emit(GetSuccessState<UserModel>(data: model));
///   }
///
///   @override
///   bool get autoDispose => true;
/// }
/// ```
///
/// now, when we emitting the [GetStates] don't forget to define the object
/// type to emphasize the data that we're going to use in [ApiBloc].
/// ```dart
/// // in controller
/// Future<void> onRequest() async {
///   emit(GetSuccessState<UserModel>(data: model));
/// }
///
/// // in blocbuilder
/// ApiBloc.builder(
///   controller: controller,
///   builder: (context, state, child) {
///     if (state is GetSuccessState<UserModel>){
///       return Text(state.data!.userName);
///     } else {
///       return const CircularProgressIndicator();
///     }
///   }
/// )
/// ```
abstract class GetController extends BlocController<GetStates> {
  /// This is constructor of fetching api request with its initial value
  /// is [GetLoadingState] and also automatically calling [run] on init.
  GetController({
    Map<String, dynamic> args = const {},
    this.autoRun = true,
  }) : super(value: const GetLoadingState()) {
    if (autoRun) run(args);
  }

  /// A function where we execute api request.
  ///
  ///```dart
  /// @override
  /// Future<void> onRequest() async {
  ///   Response response = await Response.get('https://base.url/api/user',
  ///     onProgress: (double progress) {
  ///       emit(GetLoadingState<double>(data: progress));
  ///       }
  ///     );
  ///
  ///   UserModel model = UserModel.fromJson(response.data);
  ///   emit(GetSuccessState<UserModel>(data: model));
  /// }
  /// ```
  Future<void> onRequest(Map<String, dynamic> args);

  /// A function that will be called when [onRequest] throws an error.
  ///
  /// ```dart
  /// @override
  /// Future<void> onError(dynamic e, StackTrace s) async {
  ///   emit(GetErrorState(message: '$e'));
  /// }
  /// ```
  Future<void> onError(dynamic e, StackTrace s) async {
    emit(GetErrorState(message: '$e', data: s));
  }

  /// Now, when we emitting the [GetStates] don't forget to define the object
  /// type to emphasize the data that we're going to use in [ApiBloc].
  /// ```dart
  /// // in controller
  /// Future<void> onRequest() async {
  ///   emit(GetSuccessState<UserModel>(data: model));
  /// }
  ///
  /// // in blocbuilder
  /// ApiBloc(
  ///   controller: controller,
  ///   builder: (context, state, child) {
  ///     if (state is GetSuccessState<UserModel>){
  ///       return Text(state.data!.userName);
  ///     } else {
  ///       return const CircularProgressIndicator();
  ///     }
  ///   }
  /// )
  /// ```
  @override
  void emit(GetStates<Object?> value) => super.emit(value);

  @override
  Future<void> run([
    Map<String, dynamic> args = const {},
  ]) async {
    emit(const GetLoadingState());
    try {
      await onRequest(args);
    } catch (e, s) {
      await onError(e, s);
    }
  }

  /// Whether the controller that we created and associated to certain route
  /// should be automatically dispose or not. By default it's `true`.
  @override
  bool get autoDispose => super.autoDispose;

  /// Wether the controller should trigger run on initialization or not.
  final bool autoRun;
}

class ApiFetcher extends GetController {
  ApiFetcher({
    required Future<void> onRequest,
    Future<void> Function(dynamic e, StackTrace s)? onError,
    super.autoRun = true,
    bool autoDispose = false,
  })  : _onRequest = onRequest,
        _onError = onError,
        _autoDispose = autoDispose;

  final bool _autoDispose;
  final Future<void> _onRequest;
  final Future<void> Function(dynamic e, StackTrace s)? _onError;

  @override
  Future<void> onRequest(Map<String, dynamic> args) => _onRequest;

  @override
  Future<void> onError(e, StackTrace s) {
    return _onError != null ? _onError!(e, s) : super.onError(e, s);
  }

  @override
  bool get autoDispose => _autoDispose;
}

class SendFinalController extends SendController {
  SendFinalController({
    required Future<void> onRequest,
    Future<void> Function(dynamic e, StackTrace s)? onError,
    bool autoDispose = false,
  })  : _onRequest = onRequest,
        _onError = onError,
        _autoDispose = autoDispose;

  final bool _autoDispose;
  final Future<void> _onRequest;
  final Future<void> Function(dynamic e, StackTrace s)? _onError;

  @override
  Future<void> onRequest(Map<String, dynamic> args) => _onRequest;

  @override
  Future<void> onError(e, StackTrace s) {
    return _onError != null ? _onError!(e, s) : super.onError(e, s);
  }

  @override
  bool get autoDispose => _autoDispose;
}
