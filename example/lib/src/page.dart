import 'dart:async';
import 'dart:developer';

import 'package:api_bloc/api_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

part 'controller.dart';
part 'model.dart';

class ExamplePage extends StatelessWidget {
  const ExamplePage({super.key});

  FetchController get controller => ExampleController();

  @override
  Widget build(BuildContext context) {
    return ApiBloc.listener(
      controller: controller,
      listener: (context, value) => log(value.toString()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Api Bloc')),
        body: Center(
          child: ApiBloc.builder(
            controller: controller,
            builder: (context, value, child) {
              if (value is FetchSuccessState<ExampleModel>) {
                return Text('${value.data!.firstName} ${value.data!.lastName}');
              } else if (value is FetchErrorState) {
                return Text('Oops something is wrong\n${value.message}');
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}
