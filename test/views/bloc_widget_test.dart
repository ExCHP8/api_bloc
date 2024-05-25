

// class MockResponse {
//   final dynamic data;

//   MockResponse(this.data);
// }

// class UserModel {
//   final String userName;
//   UserModel(this.userName);

//   factory UserModel.fromJSON(Map<String, dynamic> json) {
//     return UserModel(json['userName']);
//   }
// }

// class MockReadController extends ReadController {
//   @override
//   Future<void> onRequest(Map<String, dynamic> args) async {}
// }

// class MockWriteControllerRequest extends WriteControllerRequest {
//   @override
//   Future<void> onRequest(Map<String, dynamic> args) async {}
// }

// void main() {
//   group('ApiBloc: Fetch Scenario', () {
//     final controller = MockReadController();
//     final widget = MaterialApp(
//       home: ApiBloc(
//         controller: controller,
//         builder: (context, state, child) {
//           if (state is ReadSuccessState<UserModel>) {
//             return Text(state.data!.userName);
//           } else if (state is ReadErrorState) {
//             return Text(state.message);
//           } else {
//             return const CircularProgressIndicator();
//           }
//         },
//       ),
//     );
//     testWidgets('Validate Loading State', (WidgetTester tester) async {
//       await tester.pumpWidget(widget);
//       expect(controller.value, isA<ReadLoadingState>());
//       expect(find.byType(CircularProgressIndicator), findsOneWidget);
//       expect(find.text('John Doe'), findsNothing);
//     });

//     testWidgets('Validate Success State', (WidgetTester tester) async {
//       controller.emit(
//         ReadSuccessState<UserModel>(
//             data: UserModel.fromJSON({'userName': 'John Doe'})),
//       );
//       await tester.pumpWidget(widget);
//       expect(controller.value, isA<ReadSuccessState<UserModel>>());
//       expect(find.byType(CircularProgressIndicator), findsNothing);
//       expect(find.text('John Doe'), findsOneWidget);
//     });

//     testWidgets('Validate Error State', (WidgetTester tester) async {
//       controller.emit(const ReadErrorState(message: 'Mocked Error'));
//       await tester.pumpWidget(widget);
//       expect(controller.value, isA<ReadErrorState>());
//       expect(find.byType(CircularProgressIndicator), findsNothing);
//       expect(find.text('Mocked Error'), findsOneWidget);
//       controller.dispose();
//     });
//   });

//   group('ApiBloc: Submit Scenario', () {
//     void alertFrom(BuildContext context, {required String say}) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text(say),
//         duration: const Duration(seconds: 1),
//       ));
//     }

//     final controller = MockWriteControllerRequest();
//     final widget = MaterialApp(
//       home: Scaffold(
//           body: ApiBloc(
//         controller: controller,
//         child: const Text('Submit'),
//       ).onLoading(builder: (context, state, _) {
//         return const CircularProgressIndicator();
//       }).onSuccess<UserModel>(listener: (context, _) {
//         alertFrom(context, say: 'Succesfully creating new user');
//       }).onFailed(listener: (context, state) {
//         alertFrom(context, say: 'Failed because ${state.data}');
//       }).onError(listener: (context, state) {
//         alertFrom(context, say: state.message);
//       })),
//     );

//     testWidgets('Validate Idle State', (WidgetTester tester) async {
//       await tester.pumpWidget(widget);
//       expect(controller.value, isA<WriteControllerIdleState>());
//       expect(find.byType(CircularProgressIndicator), findsNothing);
//       expect(find.byType(SnackBar), findsNothing);
//       expect(find.text('Submit'), findsOneWidget);
//     });

//     testWidgets('Validate Loading State', (WidgetTester tester) async {
//       controller.emit(const WriteControllerLoadingState());
//       await tester.pumpWidget(widget);
//       expect(controller.value, isA<WriteControllerLoadingState>());
//       expect(find.byType(CircularProgressIndicator), findsOneWidget);
//       expect(find.byType(SnackBar), findsNothing);
//       expect(find.text('Submit'), findsNothing);
//     });

//     testWidgets('Validate Success State', (WidgetTester tester) async {
//       controller.emit(
//         WriteControllerSuccessState<UserModel>(
//             data: UserModel.fromJSON({'userName': 'John Doe'})),
//       );
//       await tester.pumpWidget(widget);
//       await tester.pumpAndSettle();
//       expect(controller.value, isA<WriteControllerSuccessState<UserModel>>());
//       expect(find.byType(CircularProgressIndicator), findsNothing);
//       expect(find.byType(SnackBar), findsOne);
//       expect(find.text('Succesfully creating new user'), findsOne);
//       expect(find.text('Submit'), findsOneWidget);
//     });

//     testWidgets('Validate Failed State', (WidgetTester tester) async {
//       controller.emit(const WriteControllerFailedState(data: 'Mocked Error'));
//       await tester.pumpWidget(widget);
//       await tester.pumpAndSettle();
//       expect(controller.value, isA<WriteControllerFailedState>());
//       expect(find.byType(CircularProgressIndicator), findsNothing);
//       expect(find.byType(SnackBar), findsOne);
//       expect(find.text('Failed because Mocked Error'), findsOne);
//       expect(find.text('Submit'), findsOneWidget);
//     });

//     testWidgets('Validate Error State', (WidgetTester tester) async {
//       controller.emit(const WriteControllerErrorState(message: 'Mocked Error'));
//       await tester.pumpWidget(widget);
//       await tester.pumpAndSettle();
//       expect(controller.value, isA<WriteControllerErrorState>());
//       expect(find.byType(CircularProgressIndicator), findsNothing);
//       expect(find.byType(SnackBar), findsOne);
//       expect(find.text('Mocked Error'), findsOne);
//       expect(find.text('Submit'), findsOneWidget);
//       controller.dispose();
//     });
//   });
// }
