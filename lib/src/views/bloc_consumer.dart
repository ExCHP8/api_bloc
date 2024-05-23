part of '../../api_bloc.dart';

class BlocConsumer<Request extends BlocRequest<State>, State extends BlocStates>
    extends StatelessWidget {
  const BlocConsumer({
    super.key,
    this.listener,
    this.builder,
    this.child = const Placeholder(),
  });
  final OnBlocListener<State>? listener;
  final OnBlocBuilder<State>? builder;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: context.read<Request>(),
      builder: (context, value, child) {
        if (listener != null) {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) => listener!(context, value),
          );
        }

        if (builder == null) return child!;
        return builder!(context, value, child!);
      },
      child: child,
    );
  }
}
