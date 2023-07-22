part of 'package:api_bloc/api_bloc.dart';

class FetchBloc extends BlocWidget<FetchStates> {
  const FetchBloc(
      {super.key,
      required FetchController controller,
      this.loadingBuilder,
      this.successBuilder,
      this.errorBuilder,
      this.loadingListener,
      this.successListener,
      this.errorListener,
      super.builder,
      super.listener,
      super.child})
      : super(controller: controller);

  const FetchBloc.builder(
      {super.key,
      required FetchController controller,
      required BlocBuilder<FetchStates> builder,
      super.child})
      : loadingBuilder = null,
        successBuilder = null,
        errorBuilder = null,
        loadingListener = null,
        successListener = null,
        errorListener = null,
        super.builder(builder: builder, controller: controller);

  const FetchBloc.stateBuilder(
      {super.key,
      required FetchController controller,
      this.loadingBuilder,
      this.successBuilder,
      this.errorBuilder,
      super.child})
      : loadingListener = null,
        successListener = null,
        errorListener = null,
        super(controller: controller);

  const FetchBloc.listener(
      {super.key,
      required FetchController controller,
      required BlocListener<FetchStates> listener,
      super.child})
      : loadingBuilder = null,
        successBuilder = null,
        errorBuilder = null,
        loadingListener = null,
        successListener = null,
        errorListener = null,
        super.listener(listener: listener, controller: controller);

  const FetchBloc.stateListener(
      {super.key,
      required FetchController controller,
      this.loadingListener,
      this.successListener,
      this.errorListener,
      super.child})
      : loadingBuilder = null,
        successBuilder = null,
        errorBuilder = null,
        super(controller: controller);

  final BlocBuilder<FetchLoadingState>? loadingBuilder;
  final BlocBuilder<FetchSuccessState>? successBuilder;
  final BlocBuilder<FetchErrorState>? errorBuilder;
  final BlocListener<FetchLoadingState>? loadingListener;
  final BlocListener<FetchSuccessState>? successListener;
  final BlocListener<FetchErrorState>? errorListener;

  @override
  BlocBuilder<FetchStates>? get builder {
    if (super.builder == null) return null;
    return (context, value, child) {
      if (loadingBuilder != null && value is FetchLoadingState) {
        return loadingBuilder!(context, value, child);
      } else if (successBuilder != null && value is FetchSuccessState) {
        return successBuilder!(context, value, child);
      } else if (errorBuilder != null && value is FetchErrorState) {
        return errorBuilder!(context, value, child);
      } else {
        return super.builder!(context, value, child);
      }
    };
  }

  @override
  BlocListener<FetchStates>? get listener {
    if (super.listener == null) return null;
    return (context, value) {
      if (loadingListener != null && value is FetchLoadingState) {
        return loadingListener!(context, value);
      } else if (successListener != null && value is FetchSuccessState) {
        return successListener!(context, value);
      } else if (errorListener != null && value is FetchErrorState) {
        return errorListener!(context, value);
      } else {
        return super.listener!(context, value);
      }
    };
  }
}
