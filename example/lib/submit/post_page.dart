import 'dart:developer';

import 'package:api_bloc/api_bloc.dart';
import 'package:dio/dio.dart';
import 'package:example/main.dart';
import 'package:flutter/material.dart';

part 'post_model.dart';
part 'post_controller.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});
  SubmitController get controller => CreateUserController();
  TextEditingController get name => TextEditingController();
  TextEditingController get job => TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ApiBloc.listener(
        controller: controller,
        listener: (context, state) {
          log(state.toString());
          if (state is SubmitSuccessState<CreateUserModel>) {
            snackbar(context,
                message: "Succesfully creating ${state.data!.name}");
          } else if (state is SubmitFailedState) {
            snackbar(context,
                message: "Failed because ${state.message}", color: Colors.grey);
          } else if (state is SubmitErrorState) {
            snackbar(context, message: state.message, color: Colors.red);
          }
        },
        child: Scaffold(
            appBar: AppBar(title: const Text("Submit Test")),
            body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int x = 0; x < 2; x++)
                        Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: TextField(
                                controller: [name, job][x],
                                decoration: InputDecoration(
                                    labelText: ["Name", "Job"][x],
                                    border: const OutlineInputBorder()))),
                      ApiBloc.builder(
                          controller: controller,
                          child: InkWell(
                              onTap: () async => await controller
                                  .run(args: [name.text, job.text]),
                              child: Container(
                                  color: Colors.blue,
                                  padding: const EdgeInsets.all(10.0),
                                  child: const Text(
                                    "SUBMIT",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white),
                                  ))),
                          builder: (context, state, child) {
                            if (state is SubmitLoadingState) {
                              return TextButton(
                                  onPressed: () {},
                                  child: Container(
                                      padding: const EdgeInsets.all(10.0),
                                      color: Colors.blue,
                                      child: const Text(
                                        "Loading ...",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.white),
                                      )));
                            } else {
                              return child;
                            }
                          })
                    ]))));
  }
}
