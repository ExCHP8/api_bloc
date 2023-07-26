# Api BLoC
<a href='https://pub.dev/packages/api_bloc'><img src='https://img.shields.io/pub/v/api_bloc.svg?logo=flutter&color=blue&style=flat-square'/></a>

A Flutter library for managing API calls using the BLoC pattern. This library provides a set of classes and utilities to simplify API calls and manage state changes.

## Features
- Easily manage API calls and state changes using the BLoC pattern.
- Generic classes for handling various API states such as loading, success, and error.
- Customizable builder and listener functions to respond to state changes.
- Automatic disposal of the controller to prevent memory leaks.

## Getting Started
To use this library, add `api_bloc` as a dependency in your `pubspec.yaml` file.

```yaml
dependencies:
  api_bloc: ^1.3.0
```

## Usage
- Create a subclass of [BlocController] with [BlocStates].
  This library already provide you with FetchStates [`loading`, `success`, `error`] and SubmitStates [`idle`, `loading`, `success`, `failed`, `error`],
  But you can create custom state by extending [BlocStates].

### Fetching Scenario

```dart
import 'package:api_bloc/api_bloc.dart';

class GetUserController extends FetchController {
  @override
  Future<void> request({List<Object> args = const []}) async {
    await Future.delayed(const Duration(seconds: 1));
    final response = await Dio().get('https://reqres.in/api/users/2');

    final model = GetUserModel.fromJson(response.data);
    emit(FetchSuccessState<GetUserModel>(data: model));
  }
}
```

- Put the controller inside [ApiBloc] widget.

```dart
import 'package:api_bloc/api_bloc.dart';

final controller = GetUserController();

ApiBloc.builder(
  controller: controller,
  builder: (context, state, child) {
    if (state is FetchSuccessState<UserModel>) {
      return Text('Username: ${state.data!.username}');
    } else if (state is FetchErrorState){
      return Text('Error occurred: ${state.message}');
    } else {
      return CircularProgressIndicator();
    }
  },
);
```
When the first time it initiate the controller, on fetching controller it's auto running the request function. But if you want to re run it, you can do it by calling

```dart
controller.run();
```

### Submitting Scenario

```dart
import 'package:api_bloc/api_bloc.dart';

class CreateUserController extends SubmitController {
  @override
  // We're going to dispose it manually if we set it as false.
  bool get autoDispose => false;

  @override
  Future<void> request({List<Object> args = const []}) async {
    await Future.delayed(const Duration(seconds: 1));
    final response = await Dio().post('https://reqres.in/api/users/2',
        data: FormData.fromMap({"name": args[0], "job": args[1]}));

    if (response.statusCode == 201) {
      final model = CreateUserModel.fromJson(response.data);
      emit(SubmitSuccessState<CreateUserModel>(data: model));
    } else {
      emit(SubmitFailedState<Map<String, dynamic>>(
          data: response.data,
          message: "Expected response code output is 201"));
    }
  }
}
```

- Put the controller inside [ApiBloc] widget.

```dart
import 'package:api_bloc/api_bloc.dart';

final controller = CreateUserController();

ApiBloc(
  controller: controller,
  listener: (context, state) {
    if (state is SubmitSuccessState<CreateUserModel>) {
      snackbar(context, message: "Succesfully creating new user with id #${state.data!.id}");
    } else if (state is SubmitFailedState) {
      snackbar(context, message: "Failed because ${state.message}", color: Colors.grey);
    } else if (state is SubmitErrorState) {
      snackbar(context, message: state.message, color: Colors.red);
    }
  },
  builder: (context, state, child) {
    if (state is SubmitLoadingState) {
      return TextButton(text: "Loading ...");
    }  else {
      return TextButton(text: "Create", onPressed: () => controller.run());
    }
  },
);
```
Unlike the fetch controller, initial state of submit controller is `idle` state, so to run the request you need to trigger the `controller.run()` manually.

## Example

- [https://github.com/Nialixus/api_bloc/tree/main/example/lib](https://github.com/Nialixus/api_bloc/tree/main/example/lib)
- [https://medium.com/@nialixus/flutter-simplifying-api-requests-with-api-bloc-library-17222128422e](https://medium.com/@nialixus/flutter-simplifying-api-requests-with-api-bloc-library-17222128422e)
