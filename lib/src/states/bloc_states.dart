part of 'package:api_bloc/api_bloc.dart';

/// Ancestor class of every state used in [ApiBloc].
class BlocStates<T extends Object?> {
  /// By default has one value of status message.
  const BlocStates({this.message = '', this.data});

  /// Status message indicating what's going on in this state.
  final String message;
  final T? data;

  /// Make class easier to read.
  Map<String, dynamic> get asMap =>
      {if (message.isNotEmpty) 'message': message, 'data': data};

  @override
  String toString() =>
      '$runtimeType${asMap.entries.map((e) => '${e.key}: ${e.value}')}';
}
