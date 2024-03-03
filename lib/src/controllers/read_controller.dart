part of 'package:api_bloc/api_bloc.dart';

/// An extended abstract class of [BlocController] specifically made for
/// fetching api request. Normally used for interacting with http method `GET`.
///
/// ```dart
/// class ReadUserController extends ReadController {
///   @override
///   Future<void> onRequest() async {
///     Response response = await Response.get('https://base.url/api/user',
///       onProgress: (double progress) {
///         emit(ReadLoadingState<double>(data: progress));
///         }
///       );
///
///     UserModel model = UserModel.fromJson(response.data);
///     emit(ReadSuccessState<UserModel>(data: model));
///   }
///
///   @override
///   bool get autoDispose => true;
/// }
/// ```
///
/// now, when we emitting the [ReadStates] don't forget to define the object
/// type to emphasize the data that we're going to use in [ApiBloc].
/// ```dart
/// // in controller
/// Future<void> onRequest() async {
///   emit(ReadSuccessState<UserModel>(data: model));
/// }
///
/// // in blocbuilder
/// ApiBloc.builder(
///   controller: controller,
///   builder: (context, state, child) {
///     if (state is ReadSuccessState<UserModel>){
///       return Text(state.data!.userName);
///     } else {
///       return const CircularProgressIndicator();
///     }
///   }
/// )
/// ```
abstract class ReadController extends BlocController<ReadStates> {
  /// This is constructor of fetching api request with its initial value
  /// is [ReadLoadingState] and also automatically calling [run] on init.
  /// Normally used for interacting with http method `GET`.
  ReadController({
    Map<String, dynamic> args = const {},
    this.autoRun = true,
  }) : super(value: const ReadLoadingState()) {
    if (autoRun) run(args);
  }

  /// A function where we execute api request.
  ///
  ///```dart
  /// @override
  /// Future<void> onRequest() async {
  ///   Response response = await Response.get('https://base.url/api/user',
  ///     onProgress: (double progress) {
  ///       emit(ReadLoadingState<double>(data: progress));
  ///       }
  ///     );
  ///
  ///   UserModel model = UserModel.fromJson(response.data);
  ///   emit(ReadSuccessState<UserModel>(data: model));
  /// }
  /// ```
  Future<void> onRequest(Map<String, dynamic> args);

  /// A function that will be called when [onRequest] throws an error.
  ///
  /// ```dart
  /// @override
  /// Future<void> onError(dynamic e, StackTrace s) async {
  ///   emit(ReadErrorState(message: '$e'));
  /// }
  /// ```
  Future<void> onError(dynamic e, StackTrace s) async {
    emit(ReadErrorState(message: '$e', data: s));
  }

  /// Now, when we emitting the [ReadStates] don't forget to define the object
  /// type to emphasize the data that we're going to use in [ApiBloc].
  /// ```dart
  /// // in controller
  /// Future<void> onRequest() async {
  ///   emit(ReadSuccessState<UserModel>(data: model));
  /// }
  ///
  /// // in blocbuilder
  /// ApiBloc(
  ///   controller: controller,
  ///   builder: (context, state, child) {
  ///     if (state is ReadSuccessState<UserModel>){
  ///       return Text(state.data!.userName);
  ///     } else {
  ///       return const CircularProgressIndicator();
  ///     }
  ///   }
  /// )
  /// ```
  @override
  void emit(ReadStates<Object?> value) => super.emit(value);

  @override
  Future<void> run([
    Map<String, dynamic> args = const {},
  ]) async {
    emit(const ReadLoadingState());
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

/// A standalone class that extends [ReadController] and is used to read
/// data to the server. Normally used for interacting with http method `GET`.
///
/// ```dart
/// final controller = ApiReader(
///   onRequest: () async {
///     Response response = await Response.get('https://base.url/api/user',
///       onProgress: (double progress) {
///         emit(ReadLoadingState<double>(data: progress));
///         }
///       );
///     UserModel model = UserModel.fromJson(response.data);
///     emit(ReadSuccessState<UserModel>(data: model));
///   },
///  );
///
/// return ApiBloc(
///   controller: controller,
///   builder: (context, state, child) {
///     if (state is ReadSuccessState<UserModel>){
///       return Text(state.data!.userName);
///     } else {
///       return const CircularProgressIndicator();
///     }
///   }
/// );
/// ```
class ApiReader extends ReadController {
  /// This is constructor of fetching api request with its initial value
  /// is [ReadLoadingState] and also automatically calling [run] on init.
  /// [autoRun] is [true] by default and [autoDispose] is [false] by default.
  /// This controller normally being used for interacting with http method `GET`.
  ///
  /// ```dart
  /// final controller = ApiReader(
  ///   onRequest: () async {
  ///     Response response = await Response.get('https://base.url/api/user',
  ///       onProgress: (double progress) {
  ///         emit(ReadLoadingState<double>(data: progress));
  ///         }
  ///       );
  ///     UserModel model = UserModel.fromJson(response.data);
  ///     emit(ReadSuccessState<UserModel>(data: model));
  ///   },
  ///  );
  ///
  /// return ApiBloc(
  ///   controller: controller,
  ///   builder: (context, state, child) {
  ///     if (state is ReadSuccessState<UserModel>){
  ///       return Text(state.data!.userName);
  ///     } else {
  ///       return const CircularProgressIndicator();
  ///     }
  ///   }
  /// );
  /// ```
  ApiReader({
    required Future<void> onRequest,
    Future<void> Function(dynamic e, StackTrace s)? onError,
    super.autoRun = true,
    bool autoDispose = false,
  })  : _onRequest = onRequest,
        _onError = onError,
        _autoDispose = autoDispose;

  /// Whether the controller that we created and associated to certain route
  /// should be automatically dispose or not. By default it's `false`.
  final bool _autoDispose;

  /// A function where we execute api request.
  ///
  /// ```dart
  /// final controller = ApiReader(
  ///   onRequest: () async {
  ///     Response response = await Response.get('https://base.url/api/user',
  ///       onProgress: (double progress) {
  ///         emit(ReadLoadingState<double>(data: progress));
  ///         }
  ///       );
  ///     UserModel model = UserModel.fromJson(response.data);
  ///     emit(ReadSuccessState<UserModel>(data: model));
  ///   },
  /// );
  /// ```
  final Future<void> _onRequest;

  /// A function that will be called when [onRequest] throws an error.
  ///
  /// ```dart
  /// final controller = ApiReader(
  ///   onRequest: () async {
  ///     throws 'Mock Error';
  ///   },
  ///   onError: (e, s) {
  ///     print(e); // 'Mock Error'
  ///   }
  /// );
  /// ```
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
