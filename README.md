<p align="center">
  <img src='https://user-images.githubusercontent.com/45191605/271758692-6528e25f-c4d4-43b1-8f7c-cde583976248.png' width=200 height=200/>
</p>

# Api BLoC
<a href='https://pub.dev/packages/api_bloc'><img src='https://img.shields.io/pub/v/api_bloc.svg?logo=flutter&color=blue&style=flat-square'/></a>
<a href='https://raw.githack.com/Nialixus/api_bloc/main/coverage/html/index.html'><img src='https://img.shields.io/badge/coverage-62%25-blue.svg' /></a>

A Flutter library for managing API calls using the BLoC pattern. This library provides a set of classes and utilities to simplify API calls and manage state changes.

## Features
- Easily manage API calls and state changes using the BLoC pattern.
- Generic classes for handling various API states such as loading, success, and error.
- Customizable builder and listener functions to respond to state changes.
- Automatic disposal of the controller to prevent memory leaks.
- Generate api bloc pattern on command.

## Readting Started
To use this library, add `api_bloc` as a dependency in your `pubspec.yaml` file.

```yaml
dependencies:
  api_bloc: ^2.0.0
```

and to use `api_bloc_cli` run this command in terminal.
```bash
dart pub global activate api_bloc
```

## Generating Api Bloc Structure (Optional)
To make things faster on, let's say making `GET` detail and `GET` list also `PUT` update, `POST` create and `DELETE` using this library, we just need to run this command in terminal.
```bash
dart run api_bloc --output lib/src --create user --read detail,list --write update,create,delete
```

It will generating this structure in your project
```
lib/src/user/
   - user.dart
   - controllers/
     - read_user_detail_controller.dart
     - read_user_list_controller.dart
     - write_user_update_controller.dart
     - write_user_create_controller.dart
     - write_user_delete_controller.dart
   - models/
     - read_user_detail_model.dart
     - read_user_list_model.dart
     - write_user_update_model.dart
     - write_user_create_model.dart
     - write_user_delete_model.dart
   - views/
     - read_user_detail_widget.dart
     - read_user_list_widget.dart
     - write_user_update_widget.dart
     - write_user_create_widget.dart
     - write_user_delete_widget.dart
```
Now the things that left to do is writing the content of the controllers, widgets and models.

## Fetching Scenario

```dart
import 'package:api_bloc/api_bloc.dart';

class ReadUserController extends ReadController {
  @override
  Future<void> onRequest(Map<String, dynamic> args) async {
    await Future.delayed(const Duration(seconds: 1));
    final response = await Dio().get('https://reqres.in/api/users/2');

    final model = ReadUserModel.fromJson(response.data);
    emit(ReadSuccessState<ReadUserModel>(data: model));
  }
}
```

- Put the controller inside [ApiBloc] widget.

```dart
import 'package:api_bloc/api_bloc.dart';

final controller = ReadUserController();

ApiBloc.builder(
  controller: controller,
  builder: (context, state, child) {
    if (state is ReadSuccessState<UserModel>) {
      return Text('Username: ${state.data!.username}');
    } else if (state is ReadErrorState){
      return Text('Error occurred: ${state.message}');
    } else {
      return CircularProgressIndicator();
    }
  },
);
```
When the first time it initiate the controller, on ReadController it's auto running the request function. But if you want to re run it, you can do it by calling

```dart
controller.run();
```

## Submitting Scenario

```dart
import 'package:api_bloc/api_bloc.dart';

class CreateUserController extends WriteController {
  @override
  // We're going to dispose it manually if we set it as false.
  bool get autoDispose => false;

  @override
  Future<void> onRequest(Map<String, dynamic> args) async {
    await Future.delayed(const Duration(seconds: 1));
    final response = await Dio().post('https://reqres.in/api/users/2',
        data: FormData.fromMap(args));

    if (response.statusCode == 201) {
      final model = CreateUserModel.fromJson(response.data);
      emit(WriteSuccessState<CreateUserModel>(data: model));
    } else {
      emit(WriteFailedState<Map<String, dynamic>>(
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
    if (state is WriteSuccessState<CreateUserModel>) {
      snackbar(context, message: "Succesfully creating new user with id #${state.data!.id}");
    } else if (state is WriteFailedState) {
      snackbar(context, message: "Failed because ${state.message}", color: Colors.grey);
    } else if (state is WriteErrorState) {
      snackbar(context, message: state.message, color: Colors.red);
    }
  },
  builder: (context, state, child) {
    if (state is WriteLoadingState) {
      return TextButton(text: "Loading ...");
    }  else {
      return TextButton(text: "Create", onPressed: () => controller.run());
    }
  },
);
```
Unlike the ReadController, initial state of WriteController is `idle` state, so to run the request you need to trigger the `controller.run()` manually.

## Using Extension
Now you can easily customize how your `ApiBloc` handles different state scenarios using these new extensions:

- `onIdle`: Handle `WriteIdleState` and only work with `WriteController`.
- `onLoading`: Handle `ReadLoadingState` and only work with `ReadController` or `WriteLoadingState` that only work with `WriteController`.
- `onSuccess`: Handle `ReadSuccessState` and only work with `ReadController` or `WriteSuccessState` that only work with `WriteController`.
- `onFailed`: Handle `WriteFailedState` and only work with `WriteController`.
- `onError`: Handle `ReadErrorState` and only work with `ReadController` or `WriteErrorState` that only work with `WriteController`.

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

## Sentry Integration
You can integrate this library with sentry by making custom controller like this.

```dart
abstract class ReadSentryController extends BlocController<ReadStates> {
  ReadSentryController({
    this.autoRun = true,
    JSON args = const {},
  }) : super(value: const ReadLoadingState()) {
    if (autoRun) run(args);
  }

  @override
  Future<void> run([JSON args = const {}]) async {
    emit(const ReadLoadingState());
    final http = SentryHttpClient();
    try {
      await onRequest(http, args);
    } catch (e, s) {
      await onError(e, s);
    } finally {
      http.close();
    }
  }

  Future<void> onRequest(SentryHttpClient http, JSON args);

  Future<void> onError(dynamic e, StackTrace s) async {
    await Sentry.captureException(e, stackTrace: s);
    emit(ReadErrorState(message: e.toString(), data: s));
  }

  final bool autoRun;
}

abstract class WriteSentryController extends BlocController<WriteStates> {
  WriteSentryController() : super(value: const WriteIdleState());

  @override
  Future<void> run([JSON args = const {}]) async {
    emit(const WriteLoadingState());
    final http = SentryHttpClient();
    try {
      await onRequest(http, args);
    } catch (e, s) {
      await onError(e, s);
    } finally {
      http.close();
    }
  }

  Future<void> onRequest(SentryHttpClient http, JSON args);

  Future<void> onError(dynamic e, StrackTrace s) async {
    await Sentry.captureException(e, stackTrace: s);
    emit(WriteErrorState(message: e.toString(), data: s));
  }
}
```

and then whenever you want to interact with the api, you just need to make this controller:

```dart
class ReadUserRequest extends ReadSentryController {

  Future<void> onRequest(http, args) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final response = await http.get(Uri('http://baseUrl/api/user/123'));
    emit(ReadSuccessState<UserModel>(data: UserModel.fromJSON(jsonDecode(response.body))));
  }
}
```

## Example

- [https://github.com/Nialixus/api_bloc/tree/main/example/lib](https://github.com/Nialixus/api_bloc/tree/main/example/lib)
- [https://medium.com/@nialixus/flutter-simplifying-api-requests-with-api-bloc-library-17222128422e](https://medium.com/@nialixus/flutter-simplifying-api-requests-with-api-bloc-library-17222128422e)
