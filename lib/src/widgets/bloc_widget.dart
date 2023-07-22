part of 'package:api_bloc/api_bloc.dart';

typedef BlocBuilder<T extends BlocStates> = Widget Function(
    BuildContext context, T value, Widget child);
typedef BlocListener<T extends BlocStates> = void Function(
    BuildContext context, T value);

class BlocWidget<T extends BlocStates> extends StatelessWidget {
  const BlocWidget(
      {super.key,
      required this.controller,
      this.builder,
      this.listener,
      this.child = const Placeholder()});
  final BlocController<T> controller;
  final Widget child;
  final BlocBuilder<T>? builder;
  final BlocListener<T>? listener;

  const BlocWidget.builder(
      {super.key,
      required this.builder,
      required this.controller,
      this.child = const Placeholder()})
      : assert(builder != null, 'Builder is required'),
        listener = null;

  const BlocWidget.listener(
      {super.key,
      required this.listener,
      required this.controller,
      this.child = const Placeholder()})
      : assert(listener != null, 'Listener is required'),
        builder = null;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<T>(
        valueListenable: controller,
        child: child,
        builder: (context, value, child) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (listener != null) listener!(context, value);
          });
          return builder != null ? builder!(context, value, child!) : child!;
        });
  }
}
