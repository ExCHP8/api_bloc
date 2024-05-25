part of 'package:api_bloc/api_bloc.dart';

/// An extended abstract class of [BlocController] specifically made for
/// fetching api request. Normally used for interacting with http method `GET`.
///
/// ```dart
/// class GetUserController extends ReadController {
///
///   @override
///   Future<void> onRequest() async {
///     Response response = await Response.get('https://base.url/api/user',
///       onProgress: (double progress) {
///         emit(ReadLoadingState<double>(data: progress));
///       }
///     );
///
///     UserModel model = UserModel.fromJSON(response.data);
///     emit(ReadSuccessState<UserModel>(data: model));
///   }
/// }
/// ```
abstract class ReadController extends BlocController<ReadStates> {
  /// An extended abstract class of [BlocController] specifically made for
  /// fetching api request. Normally used for interacting with http method `GET`.
  /// By default it's calling [run] on initialization, with its default state is [ReadLoadingState].
  ReadController({
    Map<String, dynamic> args = const {},
    this.autorun = true,
  }) : super(const ReadLoadingState()) {
    if (autorun) run(args);
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
  ///   UserModel model = UserModel.fromJSON(response.data);
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
  ///
  /// ```dart
  /// // in controller
  /// Future<void> onRequest() async {
  ///   emit(ReadSuccessState<UserModel>(data: model));
  /// }
  ///
  /// // in view
  /// BlocBuilder(
  ///   controller: controller,
  ///   builder: (context, state, child) {
  ///     if (state is ReadSuccessState<UserModel>){
  ///       return Text(state.data.userName);
  ///     } else {
  ///       return const CircularProgressIndicator();
  ///     }
  ///   }
  /// )
  /// ```
  @override
  @nonVirtual
  void emit(ReadStates<Object?> value) => super.emit(value);

  @override
  @nonVirtual
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

  /// Wether the controller should trigger run on initialization or not.
  final bool autorun;
}
