part of '../auth.dart';

class AuthDataViews extends StatelessWidget {
  const AuthDataViews({super.key});

  @override
  Widget build(BuildContext context) {
    return ApiBloc(
      controller: AuthDataController(),
      child: BlocBuilder<AuthDataController, ReadStates>(
        builder: (context, state, child) {
          if (state is ReadSuccessState<AuthDataModel>) {
          } else if (state is ReadErrorState) {}
          return Text(state.message);
        },
      ),
    );
  }
}
