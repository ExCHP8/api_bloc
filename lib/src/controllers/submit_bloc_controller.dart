part of 'package:api_bloc/api_bloc.dart';

/// An extended abstract class of [BlocController] specifically made for
/// submitting api request.
///
/// ```dart
/// class UpdateUserController extends SubmitController {
///
///   @override
///   Future<void> request() async {
///     Map<String, dynamic> user = UserModel().toJson();
///     Response response = await Response.put('https://base.url/api/user',
///       formdata: Formdata.fromJson(user),
///       onProgress: (double progress) {
///         emit(SubmitLoadingState<double>(data: progress));
///         }
///       );
///
///     StatusModel model = StatusModel.fromJson(response.data);
///     if (model.status == Status.success){
///       emit(SubmitSuccessState<StatusModel>(message: model.message));
///     } else {
///       emit(SubmitFailedState<StatusModel>(message: model.message));
///     }
///   }
///
///   @override
///   bool get autoDispose => true;
/// }
/// ```
///
/// now, when we emitting the [SubmitStates] don't forget to define the object
/// type to emphasize the data that we're going to use in [ApiBloc].
/// ```dart
/// // in controller
/// Future<void> request() async {
///   emit(SubmitSuccessState<StatusModel>(message: model.message));
/// }
///
/// // in blocbuilder
/// ApiBloc(
///   controller: controller,
///   listener: (context, state) {
///     if (state is SubmitSuccessState<StatusModel>){
///       Snackbar(message: state.message);
///     }
///   }
/// )
/// ```
abstract class SubmitController extends BlocController<SubmitStates> {
  /// This is constructor of fetching api request with its initial value
  /// is [SubmitIdleState] and different compare to [FetchController]
  /// it's not calling [run] on init.
  SubmitController() : super(value: const SubmitIdleState());

  /// A neccessary function to override when we extends this controller.
  ///
  /// ```dart
  /// class UpdateUserController extends SubmitController {
  ///
  ///   @override
  ///   Future<void> request() async {
  ///     Map<String, dynamic> user = UserModel().toJson();
  ///     Response response = await Response.put('https://base.url/api/user',
  ///       formdata: Formdata.fromJson(user),
  ///       onProgress: (double progress) {
  ///         emit(SubmitLoadingState<double>(data: progress));
  ///         }
  ///       );
  ///
  ///     StatusModel model = StatusModel.fromJson(response.data);
  ///     if (model.status == Status.success){
  ///       emit(SubmitSuccessState<StatusModel>(message: model.message));
  ///     } else {
  ///       emit(SubmitFailedState<StatusModel>(message: model.message));
  ///     }
  ///   }
  /// }
  /// ```
  Future<void> request({required Map<String, dynamic> args});

  /// now, when we emitting the [SubmitStates] don't forget to define the object
  /// type to emphasize the data that we're going to use in [ApiBloc].
  /// ```dart
  /// // in controller
  /// Future<void> request() async {
  ///   emit(SubmitSuccessState<StatusModel>(message: model.message));
  /// }
  ///
  /// // in bloclistener
  /// ApiBloc.listener(
  ///   controller: controller,
  ///   listener: (context, state) {
  ///     if (state is SubmitSuccessState<StatusModel>){
  ///       Snackbar(message: state.message);
  ///     }
  ///   }
  /// )
  /// ```
  @override
  void emit(SubmitStates<Object?> value) => super.emit(value);

  @override
  Future<void> run([Map<String, dynamic> args = const {}]) async {
    emit(const SubmitLoadingState());
    try {
      await request(args: args);
    } catch (e) {
      emit(SubmitErrorState(message: '$e'));
    }
  }

  /// Whether the controller that we created and associated to certain route
  /// should be automatically dispose or not. By default it's `true`.
  @override
  bool get autoDispose => super.autoDispose;
}
