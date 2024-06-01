part of '../read.dart';

final class ReadView extends SharedRunner {
  const ReadView(
    super.data, {
    super.type = SharedType.view,
  });

  @override
  List<String> get submodules {
    return data['read'];
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
      child: BlocBuilder<$module${submodule}Controller, ReadStates>(
        builder: (context, state, child) {
          if (state is ReadSuccessState<$module${submodule}Model>) {
          } else if (state is ReadErrorState) {}
          return Text(state.message);
        },
      ),
    );
  }
}
''';
  }
}
