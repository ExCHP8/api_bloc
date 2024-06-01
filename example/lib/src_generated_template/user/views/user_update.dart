part of '../user.dart';

class UserUpdateView extends StatelessWidget {
  const UserUpdateView({super.key});

  @override
  Widget build(BuildContext context) {
    return ApiBloc(
      controller: UserUpdateController(),
      child: BlocConsumer<UserUpdateController, WriteStates>(
        listener: (context, state) {
          if (state is WriteSuccessState<UserUpdateSuccessModel>) {
          } else if (state is WriteFailedState<UserUpdateFailedModel>) {
          } else if (state is WriteErrorState) {}
        },
        builder: (context, state, child) {
          if (state is WriteLoadingState) {}
          return Text(state.message);
        },
      ),
    );
  }
}
