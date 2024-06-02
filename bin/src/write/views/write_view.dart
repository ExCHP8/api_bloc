part of '../write.dart';

final class WriteView extends SharedRunner {
  const WriteView(
    super.data, {
    super.type = SharedType.views,
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

class ${module.toCamelCase()}${submodule.toCamelCase()}${type.toString().toCamelCase()} extends StatelessWidget {
  const ${module.toCamelCase()}${submodule.toCamelCase()}${type.toString().toCamelCase()}({super.key});

  @override
  Widget build(BuildContext context) {
    return ApiBloc(
      controller: ${module.toCamelCase()}${submodule.toCamelCase()}Controller(),
      child: BlocConsumer<${module.toCamelCase()}${submodule.toCamelCase()}Controller, WriteStates>(
        listener: (context, state) {
          if (state is WriteSuccessState<${module.toCamelCase()}${submodule.toCamelCase()}SuccessModel>) {
          } else if (state is WriteFailedState<${module.toCamelCase()}${submodule.toCamelCase()}FailedModel>) {
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
