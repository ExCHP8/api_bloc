import 'dart:async';

import 'package:api_bloc/api_bloc.dart';
import 'package:dio/dio.dart';
import 'package:example/submit/post_page.dart';
import 'package:flutter/material.dart';

part 'get_controller.dart';
part 'get_model.dart';

class GetPage extends StatelessWidget {
  const GetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ApiBloc(
      controller: CreateUserController(),
      child: ApiBloc(
        controller: GetUserController(),
        child: Scaffold(
          appBar: AppBar(title: const Text('Fetch Test')),
          body: Builder(
            builder: (context) => RefreshIndicator(
              onRefresh:
                  () async {}, // context.read<CreateUserController>().run,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  // [1]. Sample with builder

                  Container(
                    alignment: Alignment.center,
                    height: MediaQuery.sizeOf(context).height,
                    child: BlocConsumer<GetUserController, ReadStates>(
                      builder: (context, state, child) {
                        print(state);
                        switch (state) {
                          case ReadSuccessState<GetUserModel> _:
                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(state.data.avatar),
                                Text(state.data.fullName)
                              ],
                            );
                          case ReadErrorState _:
                            return Text(
                                'Oops something is wrong\n${state.message}');
                          default:
                            return const CircularProgressIndicator();
                        }
                      },
                    ),
                  ),

                  //
                  // [2]. Sample with extension
                  //
                  // Container(
                  //   alignment: Alignment.center,
                  //   height: MediaQuery.sizeOf(context).height,
                  //   child: BlocConsumer<GetUserController>(
                  //     child: const CircularProgressIndicator(),
                  //   ).onSuccess<GetUserModel>(builder: (context, state, child) {
                  //     return Column(
                  //         mainAxisSize: MainAxisSize.max,
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           Image.network(state.data!.avatar),
                  //           Text('${state.data!.firstName} '
                  //               '${state.data!.lastName}')
                  //         ]);
                  //   }).onError(builder: (context, state, child) {
                  //     return Text(
                  //       'Oops something is '
                  //       'wrong\n${state.message}',
                  //     );
                  //   }),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
