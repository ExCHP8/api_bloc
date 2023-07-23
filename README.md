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
  api_bloc: ^1.1.0
```

## Usage
- Create a subclass of [BlocController] with [BlocStates].
  This library already provide you with FetchStates and SubmitStates,
  But you can create custom state by extending [BlocStates].

```dart
import 'package:api_bloc/api_bloc.dart';

class GetUserController extends BlocController<FetchStates> {
  
  @override
  Future<void> request() async {
    Response response = await http.get(Uri.parse('https://base.url/api/user'),
      onProgress: (double progress) {
         emit(FetchLoadingState<double>(data: progress));
         }
      );
  
     UserModel model = UserModel.fromJson(response.data);
     emit(FetchSuccessState<UserModel>(data: model));
  }
}
```

- Put the controller inside [ApiBloc] widget.

```dart
import 'package:api_bloc/api_bloc.dart';

ApiBloc(
  controller: GetUserController(),
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
## Example

- [api_bloc/example/lib](https://github.com/Nialixus/api_bloc/tree/main/example/lib)
