part of '../example.dart';

class GetExampleDetailWidget extends StatelessWidget {
  const GetExampleDetailWidget({super.key, required this.controller});
  final GetExampleDetailController controller;

  @override
  Widget build(BuildContext context) {
    return ApiBloc(
      controller: controller,
      listener: (context, state) {
        if (state is GetSuccessState<GetExampleDetailModel>) {
        } else if (state is GetErrorState) {
        } else if (state is GetLoadingState) {}
      },
      builder: (context, state, child) {
        if (state is GetSuccessState<GetExampleDetailModel>) {
        } else if (state is GetErrorState) {
        } else if (state is GetLoadingState) {}
        return child;
      },
    );
  }
}

