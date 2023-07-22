part of 'package:api_bloc/api_bloc.dart';

enum FetchStateType { loading, success, error }

class FetchStates<T extends Object?> extends BlocStates<T> {
  const FetchStates({required this.type, super.message, super.data});
  final FetchStateType type;

  @override
  Map<String, dynamic> get asMap {
    return {...super.asMap, 'type': type};
  }
}

class FetchLoadingState extends FetchStates<double> {
  const FetchLoadingState({super.message, super.data = 0.0})
      : super(type: FetchStateType.loading);
}

class FetchSuccessState<T extends Object> extends FetchStates<T> {
  const FetchSuccessState({super.message, required super.data})
      : super(type: FetchStateType.success);
}

class FetchErrorState<T extends Object?> extends FetchStates<T> {
  const FetchErrorState({super.message, super.data})
      : super(type: FetchStateType.error);
}
