part of 'package:api_bloc/api_bloc.dart';

/// Ancestor class of every state used in [ApiBloc].
class BlocStates<T extends Object?> {
  /// [BlocStates] consist of [message] as a status on what's going on
  /// in this state and [data] that will be frequently used inside any state.
  const BlocStates({this.message = '', this.data});

  /// Status message indicating what's going on in this state.
  final String message;

  /// An optional object in state.
  final T? data;

  /// Make class easier to read.
  Map<String, dynamic> get asMap => {
        if (message.isNotEmpty) 'message': message,
        if (data != null) 'data': data
      };

  @override
  String toString() =>
      '$runtimeType${asMap.entries.map((e) => '${e.key}: ${e.value}')}';
}
