import 'package:api_bloc/api_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'controllers/bloc_controller_test.dart';

typedef JSON = Map<String, dynamic>;

class TestModel {
  const TestModel({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  JSON get toJSON {
    return {
      'id': id,
      'name': name,
    };
  }

  factory TestModel.fromJSON(JSON value) {
    return TestModel(
      id: value['id'] ?? 0,
      name: value['name'] ?? 'No Name',
    );
  }

  factory TestModel.test() {
    return const TestModel(
      id: 6,
      name: 'Bob the Builder',
    );
  }
}

extension SnackbarExtension on BuildContext {
  void alert(
    String message, {
    Color color = Colors.green,
  }) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: color,
        ),
      );
  }
}

void main() {
  group('BlocController', () {
    late BlocControllerTest controller;
    late BlocControllerTest controller2;

    setUp(() {
      controller = BlocControllerTest();
      controller2 = BlocControllerTest();
    });

    tearDown(() {
      controller.dispose();
      controller2.dispose();
    });

    testWidgets('Validate Notifier', (WidgetTester tester) async {
      ApiBloc child(BlocControllerTest controller) => ApiBloc(
            controller: controller,
            dispose: false,
            builder: (context, _) {
              return BlocBuilder<BlocControllerTest, ReadStates>(
                builder: (_, state, child) {
                  if (state is ReadSuccessState) return Text(state.message);
                  return child;
                },
              );
            },
          );

      ApiBloc child1 = child(controller);
      ApiBloc child2 = child(controller2);
      expect(child1.updateShouldNotify(child2), true);
      expect(child1.updateShouldNotify(child1), false);
    });
  });
}
