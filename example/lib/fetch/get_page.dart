import 'dart:async';
import 'dart:developer';

import 'package:api_bloc/api_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

part 'get_controller.dart';
part 'get_model.dart';

class GetPage extends StatelessWidget {
  GetPage({super.key});
  final controller = GetUserController();

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
                  builder: (context, state, child) {
                    if (state is FetchSuccessState<GetUserModel>) {
                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(state.data!.avatar),
                          Text(
                              '${state.data!.firstName} ${state.data!.lastName}'),
                        ],
                      );
                    } else if (state is FetchErrorState) {
                      return Text('Oops something is wrong\n${state.message}');
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
