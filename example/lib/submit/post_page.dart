import 'package:api_bloc/api_bloc.dart';
import 'package:dio/dio.dart';
import 'package:example/main.dart';
import 'package:flutter/material.dart';

part 'post_model.dart';
part 'post_controller.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ApiBloc(
      controller: CreateUserController(),
      builder: (context, controller) => Scaffold(
        appBar: AppBar(title: const Text("POST Request")),
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
                    controller: [controller.name, controller.job][x],
                    decoration: InputDecoration(
                      labelText: ["Name", "Job"][x],
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
              BlocConsumer(
                controller: controller,
                listener: (context, state) {
                  switch (state) {
                    case WriteSuccessState<CreateUserModel> _:
                      return context.alert(
                        "Succesfully creating new user with id #${state.data.id}",
                      );
                    case WriteFailedState _:
                      return context.alert(
                        "Failed because ${state.message}",
                        color: Colors.orange,
                      );
                    case WriteErrorState _:
                      return context.alert(
                        state.message,
                        color: Colors.red,
                      );
                    default:
                      return;
                  }
                },
                builder: (context, state, child) {
                  switch (state) {
                    case WriteLoadingState _:
                      return TextButton(
                        onPressed: () {},
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          color: Colors.blue,
                          child: const Text(
                            "Loading ...",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    default:
                      return InkWell(
                        onTap: controller.run,
                        child: Container(
                          color: Colors.blue,
                          padding: const EdgeInsets.all(10.0),
                          child: const Text(
                            "SUBMIT",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
