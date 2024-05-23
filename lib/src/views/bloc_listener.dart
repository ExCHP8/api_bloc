part of '../../api_bloc.dart';

typedef OnBlocListener<State extends BlocStates> = void Function(
  BuildContext context,
  State state,
);

class BlocListener<Request extends BlocRequest<State>, State extends BlocStates>
    extends BlocConsumer<Request, State> {
  BlocListener({
    super.key,
    required super.listener,
    super.child,
  }) : super(builder: (context, state, child) => child);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: context.read<Request>(),
      builder: (context, state, child) {
        if (listener != null) {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) => listener!(context, state),
          );
        }

        return child!;
      },
      child: child,
    );
  }
}
