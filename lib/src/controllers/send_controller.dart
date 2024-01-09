part of 'package:api_bloc/api_bloc.dart';

/// An extended abstract class of [BlocController] specifically made for
/// submitting api request.
///
/// ```dart
/// class UpdateUserController extends SendController {
///
///   @override
///   Future<void> request() async {
///     Map<String, dynamic> user = UserModel().toJson();
///     Response response = await Response.put('https://base.url/api/user',
///       formdata: Formdata.fromJson(user),
///       onProgress: (double progress) {
///         emit(SendLoadingState<double>(data: progress));
///         }
///       );
///
///     StatusModel model = StatusModel.fromJson(response.data);
///     if (model.status == Status.success){
///       emit(SendSuccessState<StatusModel>(message: model.message));
///     } else {
///       emit(SendFailedState<StatusModel>(message: model.message));
///     }
///   }
///
///   @override
///   bool get autoDispose => true;
/// }
/// ```
///
/// now, when we emitting the [SendStates] don't forget to define the object
/// type to emphasize the data that we're going to use in [ApiBloc].
/// ```dart
/// // in controller
/// Future<void> request() async {
///   emit(SendSuccessState<StatusModel>(message: model.message));
/// }
///
/// // in blocbuilder
/// ApiBloc(
///   controller: controller,
///   listener: (context, state) {
///     if (state is SendSuccessState<StatusModel>){
///       Snackbar(message: state.message);
///     }
///   }
/// )
/// ```
abstract class SendController extends BlocController<SendStates> {
  /// This is constructor of fetching api request with its initial value
  /// is [SendIdleState] and different compare to [GetController]
  /// it's not calling [run] on init.
  SendController() : super(value: const SendIdleState());

  /// A neccessary function to override when we extends this controller.
  ///
  /// ```dart
  /// class UpdateUserController extends SendController {
  ///
  ///   @override
  ///   Future<void> request() async {
  ///     Map<String, dynamic> user = UserModel().toJson();
  ///     Response response = await Response.put('https://base.url/api/user',
  ///       formdata: Formdata.fromJson(user),
  ///       onProgress: (double progress) {
  ///         emit(SendLoadingState<double>(data: progress));
  ///         }
  ///       );
  ///
  ///     StatusModel model = StatusModel.fromJson(response.data);
  ///     if (model.status == Status.success){
  ///       emit(SendSuccessState<StatusModel>(message: model.message));
  ///     } else {
  ///       emit(SendFailedState<StatusModel>(message: model.message));
  ///     }
  ///   }
  /// }
  /// ```
  Future<void> request(Map<String, dynamic> args);

  /// now, when we emitting the [SendStates] don't forget to define the object
  /// type to emphasize the data that we're going to use in [ApiBloc].
  /// ```dart
  /// // in controller
  /// Future<void> request() async {
  ///   emit(SendSuccessState<StatusModel>(message: model.message));
  /// }
  ///
  /// // in bloclistener
  /// ApiBloc.listener(
  ///   controller: controller,
  ///   listener: (context, state) {
  ///     if (state is SendSuccessState<StatusModel>){
  ///       Snackbar(message: state.message);
  ///     }
  ///   }
  /// )
  /// ```
  @override
  void emit(SendStates<Object?> value) => super.emit(value);

  @override
  Future<void> run([Map<String, dynamic> args = const {}]) async {
    emit(const SendLoadingState());
    try {
      await request(args);
    } catch (e) {
      emit(SendErrorState(message: '$e'));
    }
  }

  /// Whether the controller that we created and associated to certain route
  /// should be automatically dispose or not. By default it's `true`.
  @override
  bool get autoDispose => super.autoDispose;
}
