part of 'package:api_bloc/api_bloc.dart';

/// An extended abstract class of [BlocController] specifically made for
/// submitting api request.  Normally used for interacting with http method `POST`, `PUT`, `PATCH`, `DELETE`.
///
/// ```dart
/// class CreateUserController extends WriteController {
///
///   @override
///   Future<void> onRequest() async {
///     Map<String, dynamic> user = UserModel().toJSON;
///
///     Response response = await Response.put('https://base.url/api/user',
///       formdata: Formdata.fromJSON(user),
///       onProgress: (double progress) {
///         emit(WriteControllerLoadingState<double>(data: progress));
///       }
///     );
///
///     StatusModel model = StatusModel.fromJSON(response.data);
///
///     switch (model.status) {
///       case Status.success:
///         emit(WriteControllerSuccessState<StatusModel>(message: model.message));
///         break;
///       default:
///         emit(WriteControllerFailedState<StatusModel>(message: model.message));
///         break;
///     }
///   }
/// }
/// ```
abstract class WriteController extends BlocController<WriteStates> {
  /// An extended abstract class of [BlocController] specifically made for
  /// submitting api request. Normally used for interacting with http method `POST`, `PUT`, `PATCH`, `DELETE`.
  /// And its default state is [ReadLoadingState].
  WriteController() : super(const WriteIdleState());

  /// A neccessary function where we execute api request.
  ///
  /// ```dart
  /// class CreateUserController extends WriteController {
  ///
  ///   @override
  ///   Future<void> onRequest() async {
  ///
  ///     Response response = await Response.put('https://base.url/api/user',
  ///       formdata: Formdata.fromJSON(UserModel().toJSON),
  ///       onProgress: (double progress) {
  ///         emit(WriteControllerLoadingState<double>(data: progress));
  ///       }
  ///     );
  ///
  ///     StatusModel model = StatusModel.fromJSON(response.data);
  ///
  ///     switch (model.status) {
  ///       case Status.success:
  ///         emit(WriteControllerSuccessState<StatusModel>(message: model.message));
  ///         break;
  ///       default:
  ///         emit(WriteControllerFailedState<StatusModel>(message: model.message));
  ///         break;
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
  ///   emit(WriteControllerFailedState<StatusModel>(message: e.toString()));
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
  ///   emit(WriteControllerSuccessState<StatusModel>(message: model.message));
  /// }
  ///
  /// // in bloclistener
  /// ApiBloc.listener(
  ///   controller: controller,
  ///   listener: (context, state) {
  ///     if (state is WriteControllerSuccessState<StatusModel>){
  ///       Snackbar(message: state.message);
  ///     }
  ///   }
  /// )
  /// ```
  @override
  @nonVirtual
  void emit(WriteStates<Object?> value) => super.emit(value);

  @override
  @nonVirtual
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
