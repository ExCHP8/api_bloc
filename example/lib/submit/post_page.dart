import 'dart:developer';

import 'package:api_bloc/api_bloc.dart';
import 'package:dio/dio.dart';
import 'package:example/main.dart';
import 'package:flutter/material.dart';

part 'post_model.dart';
part 'post_controller.dart';

// class PostPage extends StatefulWidget {
//   const PostPage({super.key});

//   @override
//   State<PostPage> createState() => _PostPageState();
// }

// class _PostPageState extends State<PostPage> {
//   final controller = CreateUserController();
//   final name = TextEditingController();
//   final job = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return ApiBloc.listener(
//         controller: controller,
//         listener: (context, WriteStates state) {
//           log(state.toString());
//           if (state is WriteSuccessState<CreateUserModel>) {
//             snackbar(context,
//                 message:
//                     "Succesfully creating new user with id #${state.data!.id}");
//           } else if (state is WriteFailedState) {
//             snackbar(context,
//                 message: "Failed because ${state.message}", color: Colors.grey);
//           } else if (state is WriteErrorState) {
//             snackbar(context, message: state.message, color: Colors.red);
//           }
//         },
//         child: Scaffold(
//             appBar: AppBar(title: const Text("Post Test")),
//             body: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Column(
//                     mainAxisSize: MainAxisSize.max,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       for (int x = 0; x < 2; x++)
//                         Padding(
//                             padding: const EdgeInsets.only(bottom: 10.0),
//                             child: TextField(
//                                 controller: [name, job][x],
//                                 decoration: InputDecoration(
//                                     labelText: ["Name", "Job"][x],
//                                     border: const OutlineInputBorder()))),
//                       ApiBloc(
//                           controller: controller,
//                           child: InkWell(
//                               onTap: () => controller.run({
//                                     'name': name.text,
//                                     'job': job.text,
//                                   }),
//                               child: Container(
//                                   color: Colors.blue,
//                                   padding: const EdgeInsets.all(10.0),
//                                   child: const Text(
//                                     "SUBMIT",
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(color: Colors.white),
//                                   ))),
//                           builder: (context, state, child) {
//                             if (state is WriteLoadingState) {
//                               return TextButton(
//                                   onPressed: () {},
//                                   child: Container(
//                                       padding: const EdgeInsets.all(10.0),
//                                       color: Colors.blue,
//                                       child: const Text(
//                                         "Loading ...",
//                                         textAlign: TextAlign.center,
//                                         style: TextStyle(color: Colors.white),
//                                       )));
//                             }
//                             return child;
//                           })
//                     ]))));
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     name.dispose();
//     job.dispose();
//     super.dispose();
//   }
// }
