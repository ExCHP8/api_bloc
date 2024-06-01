part of '../write.dart';

final class WriteView extends SharedRunner {
  const WriteView(
    super.data, {
    super.type = SharedType.view,
  });

  @override
  List<String> get submodules {
    return data['write'];
  }

  @override
  String template({
    required String module,
    required String submodule,
  }) {
    return '''
part of '../$module.dart';

class $module$submodule${type.name.toCamelCase()} extends StatelessWidget {
  const $module$submodule${type.name.toCamelCase()}({super.key});

  @override
  Widget build(BuildContext context) {
    return ApiBloc(
      controller: $module${submodule}Controller(),
      child: BlocConsumer<$module${submodule}Controller, WriteStates>(
        listener: (context, state) {
          if (state is WriteSuccessState<$module${submodule}SuccessModel>) {
          } else if (state is WriteFailedState<$module${submodule}FailedModel>) {
          } else if (state is WriteErrorState) {}
        },
        builder: (context, state, child) {
          if (state is WriteLoadingState) {}
          return Text(state.message);
        },
      ),
    );
  }
}
''';
  }
}
