part of 'package:api_bloc/api_bloc.dart';

/// An extended abstract class of [BlocRequest] specifically made for
/// submitting api request.  Normally used for interacting with http method `POST`, `PUT`, `PATCH`, `DELETE`.
///
/// ```dart
/// class UpdateUserController extends WriteRequest {
///
///   @override
///   Future<void> onRequest() async {
///     Map<String, dynamic> user = UserModel().toJson();
///     Response response = await Response.put('https://base.url/api/user',
///       formdata: Formdata.fromJson(user),
///       onProgress: (double progress) {
///         emit(WriteLoadingState<double>(data: progress));
///         }
///       );
///
///     StatusModel model = StatusModel.fromJson(response.data);
///     if (model.status == Status.success){
///       emit(WriteSuccessState<StatusModel>(message: model.message));
///     } else {
///       emit(WriteFailedState<StatusModel>(message: model.message));
///     }
///   }
///
///   @override
///   bool get autoDispose => true;
/// }
/// ```
///
/// now, when we emitting the [WriteStates] don't forget to define the object
/// type to emphasize the data that we're going to use in [ApiBloc].
/// ```dart
/// // in controller
/// Future<void> onRequest() async {
///   emit(WriteSuccessState<StatusModel>(message: model.message));
/// }
///
/// // in blocbuilder
/// ApiBloc(
///   controller: controller,
///   listener: (context, state) {
///     if (state is WriteSuccessState<StatusModel>){
///       Snackbar(message: state.message);
///     }
///   }
/// )
/// ```
abstract class WriteRequest extends BlocRequest<WriteStates> {
  /// This is constructor of fetching api request with its initial value
  /// is [WriteIdleState] and different compare to [ReadRequest]
  /// it's not calling [run] on init.  Normally used for interacting with http method `POST`, `PUT`, `PATCH`, `DELETE`.
  WriteRequest() : super(const WriteIdleState());

  /// A neccessary function to override when we extends this controller.
  ///
  /// ```dart
  /// class UpdateUserController extends WriteRequest {
  ///
  ///   @override
  ///   Future<void> onRequest() async {
  ///     Map<String, dynamic> user = UserModel().toJson();
  ///     Response response = await Response.put('https://base.url/api/user',
  ///       formdata: Formdata.fromJson(user),
  ///       onProgress: (double progress) {
  ///         emit(WriteLoadingState<double>(data: progress));
  ///         }
  ///       );
  ///
  ///     StatusModel model = StatusModel.fromJson(response.data);
  ///     if (model.status == Status.success){
  ///       emit(WriteSuccessState<StatusModel>(message: model.message));
  ///     } else {
  ///       emit(WriteFailedState<StatusModel>(message: model.message));
  ///     }
  ///   }
  /// }
  /// ```
  Future<void> onRequest(Map<String, dynamic> args);

  /// A function that will be called when [onRequest] throws an error.
  ///
  /// ```dart
  /// @override
  /// Future<void> onError(e, s) async {
  ///   emit(WriteFailedState<StatusModel>(message: e.toString()));
  /// }
  /// ```
  Future<void> onError(Object e, StackTrace s) async {
    emit(WriteErrorState(message: '$e', data: s));
  }

  /// now, when we emitting the [WriteStates] don't forget to define the object
  /// type to emphasize the data that we're going to use in [ApiBloc].
  /// ```dart
  /// // in controller
  /// Future<void> onRequest() async {
  ///   emit(WriteSuccessState<StatusModel>(message: model.message));
  /// }
  ///
  /// // in bloclistener
  /// ApiBloc.listener(
  ///   controller: controller,
  ///   listener: (context, state) {
  ///     if (state is WriteSuccessState<StatusModel>){
  ///       Snackbar(message: state.message);
  ///     }
  ///   }
  /// )
  /// ```
  @override
  void emit(WriteStates<Object?> value) => super.emit(value);

  @override
  Future<void> run([
    Map<String, dynamic> args = const {},
  ]) async {
    emit(const WriteLoadingState());
    try {
      await onRequest(args);
    } catch (e, s) {
      await onError(e, s);
    }
  }
}

/// A standalone class that extends [WriteRequest] and is used to write
/// data to the server. Normally used for interacting with http method `POST`, `PUT`, `PATCH`, `DELETE`.
///
/// ```dart
/// final controller = ApiWriter(
///   onRequest: () async {
///     Map<String, dynamic> user = UserModel().toJson();
///     Response response = await Response.post('https://base.url/api/user',
///       formdata: Formdata.fromJson(user),
///       onProgress: (double progress) {
///         emit(WriteLoadingState<double>(data: progress));
///         }
///       );
///
///     StatusModel model = StatusModel.fromJson(response.data);
///     if (model.status == Status.success){
///       emit(WriteSuccessState<StatusModel>(message: model.message));
///     } else {
///       emit(WriteFailedState<StatusModel>(message: model.message));
///     }
///   }
/// );
///
/// return ApiBloc(
///   controller: controller,
///   listener: (context, state) {
///     if (state is WriteSuccessState<StatusModel>){
///       Snackbar(message: state.message);
///     }
///   }
/// )
/// ```
final class ApiWriter extends WriteRequest {
  /// This is constructor for declaring standalone [WriteRequest].
  /// A controller that normally being used for interacting with http method `POST`, `PUT`, `PATCH`, `DELETE`.
  ///
  /// Where [onRequest] is a function that will be called when [run] is called.
  /// [onError] is a function that will be called when [onRequest] throws an error.
  /// [autoDispose] is a boolean that determines whether the controller should
  /// be automatically dispose or not, by default it's `false`.
  ///
  /// ```dart
  /// final controller = ApiWriter(
  ///   onRequest: () async {
  ///     Map<String, dynamic> user = UserModel().toJson();
  ///     Response response = await Response.post('https://base.url/api/user',
  ///       formdata: Formdata.fromJson(user),
  ///       onProgress: (double progress) {
  ///         emit(WriteLoadingState<double>(data: progress));
  ///         }
  ///       );
  ///
  ///     StatusModel model = StatusModel.fromJson(response.data);
  ///     if (model.status == Status.success){
  ///       emit(WriteSuccessState<StatusModel>(message: model.message));
  ///     } else {
  ///       emit(WriteFailedState<StatusModel>(message: model.message));
  ///     }
  ///   }
  /// );
  ///
  /// return ApiBloc(
  ///   controller: controller,
  ///   listener: (context, state) {
  ///     if (state is WriteSuccessState<StatusModel>){
  ///       Snackbar(message: state.message);
  ///     }
  ///   }
  /// )
  /// ```
  ApiWriter({
    required Future<void> onRequest,
    Future<void> Function(dynamic e, StackTrace s)? onError,
    bool autoDispose = false,
  })  : _onRequest = onRequest,
        _onError = onError;

  /// A function where we execute api request.
  ///
  /// ```dart
  /// final controller = ApiWriter(
  ///   onRequest: () async {
  ///     Map<String, dynamic> user = UserModel().toJson();
  ///     Response response = await Response.post('https://base.url/api/user',
  ///       formdata: Formdata.fromJson(user),
  ///       onProgress: (double progress) {
  ///         emit(WriteLoadingState<double>(data: progress));
  ///         }
  ///       );
  ///
  ///     StatusModel model = StatusModel.fromJson(response.data);
  ///     if (model.status == Status.success){
  ///       emit(WriteSuccessState<StatusModel>(message: model.message));
  ///     } else {
  ///       emit(WriteFailedState<StatusModel>(message: model.message));
  ///     }
  ///   }
  /// );
  /// ```
  final Future<void> _onRequest;

  /// A function that will be called when [onRequest] throws an error.
  ///
  /// ```dart
  /// final controller = ApiWriter(
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
}
