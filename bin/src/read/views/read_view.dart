part of '../read.dart';

final class ReadView extends SharedRunner {
  const ReadView(
    super.data, {
    super.type = SharedType.views,
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

class ${module.toCamelCase()}${submodule.toCamelCase()}${type.name.toCamelCase()} extends StatelessWidget {
  const ${module.toCamelCase()}${submodule.toCamelCase()}${type.name.toCamelCase()}({super.key});

  @override
  Widget build(BuildContext context) {
    return ApiBloc(
      controller: ${module.toCamelCase()}${submodule.toCamelCase()}Controller(),
      child: BlocBuilder<${module.toCamelCase()}${submodule.toCamelCase()}Controller, ReadStates>(
        builder: (context, state, child) {
          if (state is ReadSuccessState<${module.toCamelCase()}${submodule.toCamelCase()}Model>) {
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
