import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:api_bloc/api_bloc.dart';

class MockResponse {
  final dynamic data;

  MockResponse(this.data);
}

class UserModel {
  final String userName;

  UserModel(this.userName);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(json['userName']);
  }
}

class MockGetController extends GetController {
  @override
  Future<void> onRequest(Map<String, dynamic> args) async {}

  @override
  bool get autoDispose => false;
}

class MockSendController extends SendController {
  @override
  Future<void> onRequest(Map<String, dynamic> args) async {}

  @override
  bool get autoDispose => false;
}

void main() {
  group('ApiBloc: Fetch Scenario', () {
    final controller = MockGetController();
    final widget = MaterialApp(
      home: ApiBloc(
        controller: controller,
        builder: (context, state, child) {
          if (state is GetSuccessState<UserModel>) {
            return Text(state.data!.userName);
          } else if (state is GetErrorState) {
            return Text(state.message);
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
    testWidgets('Validate Loading State', (WidgetTester tester) async {
      await tester.pumpWidget(widget);

      expect(controller.value, isA<GetLoadingState>());
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('John Doe'), findsNothing);
    });

    testWidgets('Validate Success State', (WidgetTester tester) async {
      controller.emit(
        GetSuccessState<UserModel>(
            data: UserModel.fromJson({'userName': 'John Doe'})),
      );
      await tester.pumpWidget(widget);
      expect(controller.value, isA<GetSuccessState<UserModel>>());
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.text('John Doe'), findsOneWidget);
    });

    testWidgets('Validate Error State', (WidgetTester tester) async {
      controller.emit(const GetErrorState(message: 'Mocked Error'));
      await tester.pumpWidget(widget);
      expect(controller.value, isA<GetErrorState>());
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.text('Mocked Error'), findsOneWidget);
      controller.dispose();
    });
  });

  group('ApiBloc: Submit Scenario', () {
    void alertFrom(BuildContext context, {required String say}) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(say),
        duration: const Duration(seconds: 1),
      ));
    }

    final controller = MockSendController();
    final widget = MaterialApp(
      home: Scaffold(
          body: ApiBloc(
        controller: controller,
        child: const Text('Submit'),
      ).onLoading(builder: (context, state, _) {
        return const CircularProgressIndicator();
      }).onSuccess<UserModel>(listener: (context, _) {
        alertFrom(context, say: 'Succesfully creating new user');
      }).onFailed(listener: (context, state) {
        alertFrom(context, say: 'Failed because ${state.data}');
      }).onError(listener: (context, state) {
        alertFrom(context, say: state.message);
      })),
    );

    testWidgets('Validate Idle State', (WidgetTester tester) async {
      await tester.pumpWidget(widget);
      expect(controller.value, isA<SendIdleState>());
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byType(SnackBar), findsNothing);
      expect(find.text('Submit'), findsOneWidget);
    });

    testWidgets('Validate Loading State', (WidgetTester tester) async {
      controller.emit(const SendLoadingState());
      await tester.pumpWidget(widget);
      expect(controller.value, isA<SendLoadingState>());
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(SnackBar), findsNothing);
      expect(find.text('Submit'), findsNothing);
    });

    testWidgets('Validate Success State', (WidgetTester tester) async {
      controller.emit(
        SendSuccessState<UserModel>(
            data: UserModel.fromJson({'userName': 'John Doe'})),
      );
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      expect(controller.value, isA<SendSuccessState<UserModel>>());
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byType(SnackBar), findsOne);
      expect(find.text('Succesfully creating new user'), findsOne);
      expect(find.text('Submit'), findsOneWidget);
    });

    testWidgets('Validate Failed State', (WidgetTester tester) async {
      controller.emit(const SendFailedState(data: 'Mocked Error'));
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      expect(controller.value, isA<SendFailedState>());
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byType(SnackBar), findsOne);
      expect(find.text('Failed because Mocked Error'), findsOne);
      expect(find.text('Submit'), findsOneWidget);
    });

    testWidgets('Validate Error State', (WidgetTester tester) async {
      controller.emit(const SendErrorState(message: 'Mocked Error'));
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      expect(controller.value, isA<SendErrorState>());
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byType(SnackBar), findsOne);
      expect(find.text('Mocked Error'), findsOne);
      expect(find.text('Submit'), findsOneWidget);
      controller.dispose();
    });
  });
}
