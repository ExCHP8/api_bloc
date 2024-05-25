part of 'package:api_bloc/api_bloc.dart';

/// The base state class used in [ReadController].
///
/// The [ReadStates] class extends [BlocStates] to provide a generic state that includes [message], and a dynamic [data] object.
/// This limited to three states in total. These states are [ReadLoadingState], [ReadSuccessState], and [ReadErrorState].
sealed class ReadStates<T extends dynamic> extends BlocStates<T> {
  /// Create a [ReadStates] with the specified [message], and [data].
  ///
  /// The [message] parameter represents an optional error message associated with the state.
  /// The [data] parameter represents an optional data object associated with the state.
  const ReadStates({super.message, T? data}) : super(data: data as T);

  /// Creates a [ReadLoadingState] with the specified [message] and [data].
  ///
  /// The [message] parameter represents an optional message associated with the state.
  /// The [data] parameter represents an optional data object associated with the state.
  /// This method is used to create a [ReadLoadingState] during the loading state
  /// of a [ReadController].
  ///
  /// ```dart
  /// emit(ReadStates.loading<double>(
  ///   message: 'loading',
  ///   data: 0.5,
  /// ));
  ///
  /// // equals to this one
  ///
  /// emit(ReadLoadingState<double>(
  ///   message: 'loading',
  ///   data: 0.5,
  /// ));
  /// ```
  static ReadLoadingState<T> loading<T extends dynamic>({
    String message = '',
    T? data,
  }) {
    return ReadLoadingState<T>(
      message: message,
      data: data,
    );
  }

  /// Creates a [ReadSuccessState] with the specified [message] and [data].
  ///
  /// The [message] parameter represents an optional message associated with the state.
  /// The [data] parameter represents the data object associated with the state.
  /// This method is used to create a [ReadSuccessState] during the success state
  /// of a [ReadController].
  ///
  /// ```dart
  /// emit(ReadStates.success<DataModel>(
  ///   message: 'success',
  ///   data: DataModel(...),
  /// ));
  ///
  /// // equals to this one
  ///
  /// emit(ReadSuccessState<DataModel>(
  ///   message: 'success',
  ///   data: DataModel(...),
  /// ));
  /// ```
  static ReadSuccessState<T> success<T extends Object>({
    String message = '',
    required T data,
  }) {
    return ReadSuccessState<T>(
      message: message,
      data: data,
    );
  }

  /// Creates a [ReadErrorState] with the specified [message] and [data].
  ///
  /// The [message] parameter represents an optional error message associated with the state.
  /// The [data] parameter represents an optional data object associated with the state.
  /// This method is used to create a [ReadErrorState] during the error state
  /// of a [ReadController].
  ///
  /// ```dart
  /// emit(ReadStates.error<Exception>(
  ///   message: 'error',
  ///   data: Exception(...),
  /// ));
  ///
  /// // equals to this one
  ///
  /// emit(ReadErrorState<Exception>(
  ///   message: 'error',
  ///   data: Exception(...),
  /// ));
  /// ```
  static ReadErrorState<T> error<T extends Object>({
    String message = '',
    T? data,
  }) {
    return ReadErrorState<T>(
      message: message,
      data: data,
    );
  }
}

/// Represents the loading state when data is being fetched in [ReadController].
final class ReadLoadingState<T extends dynamic> extends ReadStates<T> {
  /// Create a [ReadLoadingState] with an optional [message] and [data].
  /// Don't forget to define the object type to emphasize the data that we're
  /// going to use in [ApiBloc].
  ///
  /// ```dart
  /// ReadLoadingState<double>(data: 0.0));
  /// ```
  const ReadLoadingState({super.message, super.data});
}

/// Represents the success state when data fetching is successful in
/// [ReadController].
final class ReadSuccessState<T extends Object> extends ReadStates<T> {
  /// Create a [ReadSuccessState] with an optional [message] and [data].
  /// Don't forget to define the object type to emphasize the data that we're
  /// going to use in [ApiBloc].
  ///
  /// ```dart
  /// ReadSuccessState<Model>(data: Model()));
  /// ```
  const ReadSuccessState({super.message, required super.data});
}

/// Represents the error state when an error occurs during data fetching in
/// [ReadController].
final class ReadErrorState<T extends dynamic> extends ReadStates<T> {
  /// Create a [ReadErrorState] with an optional [message] and [data].
  const ReadErrorState({super.message, super.data});
}
