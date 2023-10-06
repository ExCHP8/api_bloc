part of '../example.dart';

class SendExampleUpdateWidget extends StatelessWidget {
  const SendExampleUpdateWidget({super.key, required this.controller});
  final SendExampleUpdateController controller;

  @override
  Widget build(BuildContext context) {
    return ApiBloc(
      controller: controller,
      listener: (context, state) {
        if (state is SendIdleState) {
        } else if (state is SendLoadingState) {
        } else if (state is SendSuccessState<SendExampleUpdateSuccessModel>) {
        } else if (state is SendFailedState<SendExampleUpdateFailedModel>) {
        } else if (state is SendErrorState) {}
      },
      builder: (context, state, child) {
        if (state is SendIdleState) {
        } else if (state is SendLoadingState) {
        } else if (state is SendSuccessState<SendExampleUpdateSuccessModel>) {
        } else if (state is SendFailedState<SendExampleUpdateFailedModel>) {
        } else if (state is SendErrorState) {}
        return child;
      },
    );
  }
}
