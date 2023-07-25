import 'dart:async';
import 'dart:developer';

import 'package:api_bloc/api_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

part 'get_controller.dart';
part 'get_model.dart';

class GetPage extends StatelessWidget {
  const GetPage({super.key});
  FetchController get controller => GetUserController();

  @override
  Widget build(BuildContext context) {
    return ApiBloc.listener(
      controller: controller,
      listener: (context, value) => log(value.toString()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Fetch Test')),
        body: RefreshIndicator(
          onRefresh: () async => await controller.run(),
          child: ListView(
            children: [
              Container(
                alignment: Alignment.center,
                height: MediaQuery.sizeOf(context).height,
                child: ApiBloc.builder(
                  controller: controller,
                  builder: (context, value, child) {
                    if (value is FetchSuccessState<GetUserModel>) {
                      return Text(
                          '${value.data!.firstName} ${value.data!.lastName}');
                    } else if (value is FetchErrorState) {
                      return Text('Oops something is wrong\n${value.message}');
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
