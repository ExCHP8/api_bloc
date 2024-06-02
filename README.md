<p align="center">
  <img src='https://user-images.githubusercontent.com/45191605/271758692-6528e25f-c4d4-43b1-8f7c-cde583976248.png' width=200 height=200/>
</p>

# Api BLoC
[![Pub Version](https://img.shields.io/pub/v/api_bloc.svg?logo=flutter&color=blue&style=flat-square)](https://pub.dev/packages/api_bloc)
[![codecov](https://codecov.io/gh/Nialixus/api_bloc/graph/badge.svg?token=FTA3TAWK7G)](https://codecov.io/gh/Nialixus/api_bloc)

Flutter widgets designed to simplify the implementation of the BLoC pattern for REST APIs within an MVC architecture. Significantly reduces boilerplate code by automating BLoC pattern and test generation for handling REST API interactions.

## Features
- Significantly reducing boilerplate code of bloc pattern to interact with REST API.
- Generic classes for handling various API states such as `loading`, `success,` & `error` for **READ** states and `idle`, `loading`, `success`, `failed` & `error` for **WRITE** states.
- Customizable builder and listener functions to respond to state changes.
- Generate api bloc pattern & bloc test on command.

## Getting Started
To use this library, add `api_bloc` as a dependency in your `pubspec.yaml` file.

```yaml
dependencies:
  api_bloc: ^3.0.1
```

and to use `api_bloc_cli` run this command in terminal.
```bash
dart pub global activate api_bloc
```

## Fetching Scenario

```dart
import 'package:api_bloc/api_bloc.dart';

class GetUserController extends ReadController {
  @override
  Future<void> onRequest(Map<String, dynamic> args) async {
    // Mock Delay
    await Future.delayed(const Duration(seconds: 1));

    Response response = await Dio().get(
      'https://reqres.in/api/users/2',
      onReceiveProgress: (received, total) {
        emit(ReadLoadingState<double>(data: received / total));
      },
    );

    emit(ReadSuccessState<GetUserModel>(
        data: GetUserModel.fromJSON(response.data)));
  }
}

```

Put the controller inside the [ApiBloc] widget.

```dart
import 'package:api_bloc/api_bloc.dart';

ApiBloc(
  controller: UserDetailController(),
  child: BlocBuilder<UserDetailController, ReadStates>(
    builder: (context, state, child) {
      if (state is ReadSuccessState<UserDetailModel>) {
      } else if (state is ReadErrorState) {}
      return Text(state.message);
    },
  ),
);
```
When the controller is first initiated, on ReadController it automatically runs the request function. If you want to rerun it, you can do it by calling:

```dart
controller.run();
```

## Submitting Scenario

```dart
import 'package:api_bloc/api_bloc.dart';

class UserUpdateController extends WriteController {
  @override
  Future<void> onRequest(Map<String, dynamic> args) async {
    // Delay to make the loading state more noticable.
    await Future.delayed(const Duration(milliseconds: 300));

    // Emit your success and failed state here ↓↓
    if (isSuccess) {
    emit(const WriteSuccessState<UserUpdateSuccessModel>(
        data: UserUpdateSuccessModel.test()));
    } else {
    emit(const WriteFailedState<UserUpdateFailedModel>(
        data: UserUpdateFailedModel.test()));
    }
  }
}
```

Put the controller inside the [ApiBloc] widget.

```dart
import 'package:api_bloc/api_bloc.dart';

ApiBloc(
  controller: UserUpdateController(),
  child: BlocConsumer<UserUpdateController, WriteStates>(
    listener: (context, state) {
      if (state is WriteSuccessState<UserUpdateSuccessModel>) {
      } else if (state is WriteFailedState<UserUpdateFailedModel>) {
      } else if (state is WriteErrorState) {}
    },
    builder: (context, state, child) {
      if (state is WriteLoadingState) {}
      return Text(state.message);
    },
  ),
);
```
Unlike the ReadController, the initial state of WriteControllerRequest is `idle` state, so to run the request you need to trigger the `controller.run()` manually.


## Generating Api Bloc Structure (Optional)
To quickly create a module, for example `GET` detail and `GET` list, also `PUT` update, `POST` create, and `DELETE` for a module called `USER` using this library, run this command in terminal:

```bash
dart run api_bloc --output lib/src --create user --read detail,list --write update,create,delete
```

It will generate this structure in your project:

```
📂 lib/src/user/
   📄 lib/src/user/user.dart 
   📄 lib/src/user/controllers/user_detail.dart 
   📄 lib/src/user/controllers/user_list.dart 
   📄 lib/src/user/controllers/user_update.dart 
   📄 lib/src/user/controllers/user_create.dart 
   📄 lib/src/user/controllers/user_delete.dart 
   📄 lib/src/user/models/user_detail.dart 
   📄 lib/src/user/models/user_list.dart 
   📄 lib/src/user/models/user_update.dart 
   📄 lib/src/user/models/user_create.dart 
   📄 lib/src/user/models/user_delete.dart 
   📄 lib/src/user/views/user_detail.dart 
   📄 lib/src/user/views/user_list.dart 
   📄 lib/src/user/views/user_update.dart 
   📄 lib/src/user/views/user_create.dart 
   📄 lib/src/user/views/user_delete.dart 
📂 test/src/user/
   📄 test/src/user/controllers/user_detail.dart 
   📄 test/src/user/controllers/user_list.dart 
   📄 test/src/user/controllers/user_update.dart 
   📄 test/src/user/controllers/user_create.dart 
   📄 test/src/user/controllers/user_delete.dart 
   📄 test/src/user/models/user_detail.dart 
   📄 test/src/user/models/user_list.dart 
   📄 test/src/user/models/user_update.dart 
   📄 test/src/user/models/user_create.dart 
   📄 test/src/user/models/user_delete.dart 
   📄 test/src/user/views/user_detail.dart 
   📄 test/src/user/views/user_list.dart 
   📄 test/src/user/views/user_update.dart 
   📄 test/src/user/views/user_create.dart 
   📄 test/src/user/views/user_delete.dart 
```

## Sentry Integration
You also can integrate this library with Sentry by creating custom controllers like this:

```dart
abstract class ReadSentryController extends BlocRequest<ReadStates> {
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

abstract class WriteSentryController extends BlocRequest<WriteStates> {
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

Whenever you want to interact with the API, create a controller like this:

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
