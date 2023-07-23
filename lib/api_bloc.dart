/// A Flutter library for managing API calls using the BLoC pattern.
/// This library provides a set of classes and utilities to simplify API
/// calls and manage state changes.
library api_bloc;

import 'package:flutter/material.dart';
part 'package:api_bloc/src/controllers/bloc_controller.dart';
part 'package:api_bloc/src/controllers/fetch_bloc_controller.dart';
part 'package:api_bloc/src/controllers/submit_bloc_controller.dart';
part 'package:api_bloc/src/states/fetch_bloc_states.dart';
part 'package:api_bloc/src/states/submit_bloc_states.dart';
part 'package:api_bloc/src/states/bloc_states.dart';
part 'package:api_bloc/src/widgets/bloc_widget.dart';
