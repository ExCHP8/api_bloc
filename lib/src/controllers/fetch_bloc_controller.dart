part of 'package:api_bloc/api_bloc.dart';

/// An extended abstract class of [BlocController] specifically made for
/// fetching api request.
///
/// ```dart
/// class GetUserController extends FetchController {
///
///   @override
///   Future<void> request() async {
///     Response response = await Response.get('https://base.url/api/user',
///       onProgress: (double progress) {
///         emit(FetchLoadingState<double>(data: progress));
///         }
///       );
///
///     UserModel model = UserModel.fromJson(response.data);
///     emit(FetchSuccessState<UserModel>(data: model));
///   }
///
///   @override
///   bool get autoDispose => true;
/// }
/// ```
///
/// now, when we emitting the [FetchStates] don't forget to define the object
/// type to emphasize the data that we're going to use in [ApiBloc].
/// ```dart
/// // in controller
/// Future<void> request() async {
///   emit(FetchSuccessState<UserModel>(data: model));
/// }
///
/// // in blocbuilder
/// ApiBloc.builder(
///   controller: controller,
///   builder: (context, state, child) {
///     if (state is FetchSuccessState<UserModel>){
///       return Text(state.data!.userName);
///     } else {
///       return const CircularProgressIndicator();
///     }
///   }
/// )
/// ```
abstract class FetchController extends BlocController<FetchStates> {
  /// This is constructor of fetching api request with its initial value
  /// is [FetchLoadingState] and also automatically calling [run] on init.
  FetchController() : super(value: const FetchLoadingState()) {
    run();
  }

  /// A neccessary function to override when we extends this controller.
  ///
  ///```dart
  /// @override
  /// Future<void> request() async {
  ///   Response response = await Response.get('https://base.url/api/user',
  ///     onProgress: (double progress) {
  ///       emit(FetchLoadingState<double>(data: progress));
  ///       }
  ///     );
  ///
  ///   UserModel model = UserModel.fromJson(response.data);
  ///   emit(FetchSuccessState<UserModel>(data: model));
  /// }
  /// ```
  Future<void> request();

  /// now, when we emitting the [FetchStates] don't forget to define the object
  /// type to emphasize the data that we're going to use in [ApiBloc].
  /// ```dart
  /// // in controller
  /// Future<void> request() async {
  ///   emit(FetchSuccessState<UserModel>(data: model));
  /// }
  ///
  /// // in blocbuilder
  /// ApiBloc(
  ///   controller: controller,
  ///   builder: (context, state, child) {
  ///     if (state is FetchSuccessState<UserModel>){
  ///       return Text(state.data!.userName);
  ///     } else {
  ///       return const CircularProgressIndicator();
  ///     }
  ///   }
  /// )
  /// ```
  @override
  void emit(FetchStates<Object?> value) => super.emit(value);

  @override
  Future<void> run() async {
    emit(const FetchLoadingState());
    try {
      await request();
    } catch (e) {
      emit(FetchErrorState(message: '$e'));
    }
  }

  /// Whether the controller that we created and associated to certain route
  /// should be automatically dispose or not. By default it's `true`.
  @override
  bool get autoDispose => super.autoDispose;
}
