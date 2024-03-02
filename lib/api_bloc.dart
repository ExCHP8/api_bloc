/// A Flutter library for managing API calls using the BLoC pattern.
/// This library provides a set of classes and utilities to simplify API
/// calls and manage state changes.
library api_bloc;

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
part 'package:api_bloc/src/controllers/bloc_controller.dart';
part 'package:api_bloc/src/controllers/get_controller.dart';
part 'package:api_bloc/src/controllers/send_controller.dart';
part 'package:api_bloc/src/states/get_states.dart';
part 'package:api_bloc/src/states/send_states.dart';
part 'package:api_bloc/src/states/bloc_states.dart';
part 'package:api_bloc/src/views/bloc_widget.dart';
