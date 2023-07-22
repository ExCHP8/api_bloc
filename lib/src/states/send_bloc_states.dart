part of 'package:api_bloc/api_bloc.dart';

enum SendStateType { idle, loading, success, failed, error }

class SendStates<T extends Object?> extends BlocStates<T> {
  const SendStates({required this.type, super.message, super.data});
  final SendStateType type;

  @override
  Map<String, dynamic> get asMap {
    return {...super.asMap, 'type': type};
  }
}

class SendIdleState<T extends Object?> extends SendStates<T> {
  const SendIdleState({super.message, super.data})
      : super(type: SendStateType.idle);
}

class SendLoadingState extends SendStates<double> {
  const SendLoadingState({super.message, super.data = 0.0})
      : super(type: SendStateType.loading);
}

class SendSuccessState<T extends Object> extends SendStates<T> {
  const SendSuccessState({super.message, required super.data})
      : super(type: SendStateType.success);
}

class SendFailedState<T extends Object> extends SendStates<T> {
  const SendFailedState({super.message, required super.data})
      : super(type: SendStateType.failed);
}

class SendErrorState<T extends Object?> extends SendStates<T> {
  const SendErrorState({super.message, super.data})
      : super(type: SendStateType.error);
}
