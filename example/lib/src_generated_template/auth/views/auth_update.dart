part of '../auth.dart';

class AuthUpdateViews extends StatelessWidget {
  const AuthUpdateViews({super.key});

  @override
  Widget build(BuildContext context) {
    return ApiBloc(
      controller: AuthUpdateController(),
      child: BlocConsumer<AuthUpdateController, WriteStates>(
        listener: (context, state) {
          if (state is WriteSuccessState<AuthUpdateSuccessModel>) {
          } else if (state is WriteFailedState<AuthUpdateFailedModel>) {
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
