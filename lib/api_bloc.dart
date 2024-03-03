/// A Flutter library for managing API calls using the BLoC pattern.
/// This library provides a set of classes and utilities to simplify API
/// calls and manage state changes.
library api_bloc;

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
part 'package:api_bloc/src/controllers/bloc_controller.dart';
part 'package:api_bloc/src/controllers/read_controller.dart';
part 'package:api_bloc/src/controllers/write_controller.dart';
part 'package:api_bloc/src/states/read_states.dart';
part 'package:api_bloc/src/states/write_states.dart';
part 'package:api_bloc/src/states/bloc_states.dart';
part 'package:api_bloc/src/views/bloc_widget.dart';
