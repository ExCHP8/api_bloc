import 'dart:async';

import 'package:api_bloc/api_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

part 'request.dart';
part 'model.dart';

class ExamplePage extends StatelessWidget {
  const ExamplePage({super.key});
  FetchController get controller => ExampleRequest();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('API BLOC')),
      body: Center(
        child: FetchBloc(
          controller: controller,
          builder: (context, value, child) {
            if (value is FetchLoadingState) {
              return const CircularProgressIndicator();
            } else if (value is FetchSuccessState) {
              return Text(value.toString());
            }
            return child;
          },
          // loadingBuilder: (context, value, child) =>
          //     const CircularProgressIndicator(),
          // successBuilder: (context, value, child) => Text(value.data.toString()),
          // errorBuilder: (context, value, child) =>
          //     const Icon(Icons.error, color: Colors.red),
        ),
      ),
    );
  }
}
