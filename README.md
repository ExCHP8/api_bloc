<p align="center">
  <img src='https://user-images.githubusercontent.com/45191605/271758692-6528e25f-c4d4-43b1-8f7c-cde583976248.png' width=200 height=200/>
</p>

# Api BLoC
<a href='https://pub.dev/packages/api_bloc'><img src='https://img.shields.io/pub/v/api_bloc.svg?logo=flutter&color=blue&style=flat-square'/></a>

A Flutter library for managing API calls using the BLoC pattern. This library provides a set of classes and utilities to simplify API calls and manage state changes.

## Features
- Easily manage API calls and state changes using the BLoC pattern.
- Generic classes for handling various API states such as loading, success, and error.
- Customizable builder and listener functions to respond to state changes.
- Automatic disposal of the controller to prevent memory leaks.
- Generate api bloc pattern on command.

## Getting Started
To use this library, add `api_bloc` as a dependency in your `pubspec.yaml` file.

```yaml
dependencies:
  api_bloc: ^1.8.0
```

and to use `api_bloc_cli` run this command in terminal.
```bash
dart pub global activate api_bloc
```

## Generating Api Bloc Structure (Optional)
To make things faster on, let's say making `GET` detail and `GET` list also `PUT` update, `POST` create and `DELETE` using this library, we just need to run this command in terminal.
```bash
dart run api_bloc --output lib/src --create user --get detail,list --send update,create,delete
```

It will generating this structure in your project
```
lib/src/user/
   - user.dart
   - pages/
   - controllers/
     - get_user_detail_controller.dart
     - get_user_list_controller.dart
     - send_user_update_controller.dart
     - send_user_create_controller.dart
     - send_user_delete_controller.dart
   - models/
     - get_user_detail_model.dart
     - get_user_list_model.dart
     - send_user_update_model.dart
     - send_user_create_model.dart
     - send_user_delete_model.dart
   - widgets/
     - get_user_detail_widget.dart
     - get_user_list_widget.dart
     - send_user_update_widget.dart
     - send_user_create_widget.dart
     - send_user_delete_widget.dart
```
Now the things that left to do is writing the content of the controllers, widgets and models.

## Fetching Scenario

```dart
import 'package:api_bloc/api_bloc.dart';

class GetUserController extends GetController {
  @override
  Future<void> request({required Map<String, dynamic> args}) async {
    await Future.delayed(const Duration(seconds: 1));
    final response = await Dio().get('https://reqres.in/api/users/2');

    final model = GetUserModel.fromJson(response.data);
    emit(GetSuccessState<GetUserModel>(data: model));
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
    if (state is GetSuccessState<UserModel>) {
      return Text('Username: ${state.data!.username}');
    } else if (state is GetErrorState){
      return Text('Error occurred: ${state.message}');
    } else {
      return CircularProgressIndicator();
    }
  },
);
```
When the first time it initiate the controller, on GetController it's auto running the request function. But if you want to re run it, you can do it by calling

```dart
controller.run();
```

## Sending Scenario

```dart
import 'package:api_bloc/api_bloc.dart';

class CreateUserController extends SendController {
  @override
  // We're going to dispose it manually if we set it as false.
  bool get autoDispose => false;

  @override
  Future<void> request({required Map<String, dynamic> args}) async {
    await Future.delayed(const Duration(seconds: 1));
    final response = await Dio().post('https://reqres.in/api/users/2',
        data: FormData.fromMap({"name": args['name'], "job": args['job']}));

    if (response.statusCode == 201) {
      final model = CreateUserModel.fromJson(response.data);
      emit(SendSuccessState<CreateUserModel>(data: model));
    } else {
      emit(SendFailedState<Map<String, dynamic>>(
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
    if (state is SendSuccessState<CreateUserModel>) {
      snackbar(context, message: "Succesfully creating new user with id #${state.data!.id}");
    } else if (state is SendFailedState) {
      snackbar(context, message: "Failed because ${state.message}", color: Colors.grey);
    } else if (state is SendErrorState) {
      snackbar(context, message: state.message, color: Colors.red);
    }
  },
  builder: (context, state, child) {
    if (state is SendLoadingState) {
      return TextButton(text: "Loading ...");
    }  else {
      return TextButton(text: "Create", onPressed: () => controller.run());
    }
  },
);
```
Unlike the GetController, initial state of SendController is `idle` state, so to run the request you need to trigger the `controller.run()` manually.

## Using Extension
Now you can easily customize how your `ApiBloc` handles different state scenarios using these new extensions:

- `onIdle`: Handle `SendIdleState` and only work with `SendController`.
- `onLoading`: Handle `GetLoadingState` and only work with `GetController` or `SendLoadingState` that only work with `SendController`.
- `onSuccess`: Handle `GetSuccessState` and only work with `GetController` or `SendSuccessState` that only work with `SendController`.
- `onFailed`: Handle `SendFailedState` and only work with `SendController`.
- `onError`: Handle `GetErrorState` and only work with `GetController` or `SendErrorState` that only work with `SendController`.

```dart
import 'package:api_bloc/api_bloc.dart';

final controller = CreateUserController();

ApiBloc(
  controller: controller,
  child: TextButton(text: "Create", onPressed: () => controller.run()))
.onLoading(
  builder: (context, state, child) {
    return TextButton(text: "Loading ...");
  })
.onFailed(
  listener: (context, state, child) {
    snackbar(context, message: "Failed because ${state.message}", color: Colors.grey);
  })
.onSuccess<CreateUserModel>(
  listener: (context, state, child) {
    snackbar(context, message: "Succesfully creating new user with id #${state.data!.id}");
  })
.onError(
  listener: (context, state, child) {
    snackbar(context, message: state.message, color: Colors.red);
  })
.onState<BlocStates<Object>>(
  listener; (context, state) {
    snackbar(context, message: "You're in this custom state of ${state.runtimeType}");
  },
  builder: (context, state, child) {
    return Text("You're in this custom state of ${state.runtimeType}");
  }
);
```

## Example

- [https://github.com/Nialixus/api_bloc/tree/main/example/lib](https://github.com/Nialixus/api_bloc/tree/main/example/lib)
- [https://medium.com/@nialixus/flutter-simplifying-api-requests-with-api-bloc-library-17222128422e](https://medium.com/@nialixus/flutter-simplifying-api-requests-with-api-bloc-library-17222128422e)
