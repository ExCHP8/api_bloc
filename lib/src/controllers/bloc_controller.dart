part of 'package:api_bloc/api_bloc.dart';

class BlocController<T extends BlocStates> extends ValueNotifier<T> {
  BlocController(super.value);

  void emit(T value) => this.value = value;
}
