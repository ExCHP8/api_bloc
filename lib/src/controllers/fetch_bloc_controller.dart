part of 'package:api_bloc/api_bloc.dart';

abstract class FetchController extends BlocController<FetchStates> {
  FetchController({FetchStates? value})
      : super(value ?? const FetchLoadingState()) {
    run();
  }
  Future<void> request();

  Future<void> run() async {
    try {
      emit(const FetchLoadingState());
      await request();
    } catch (e) {
      emit(FetchErrorState(message: '$e'));
    }
  }
}
