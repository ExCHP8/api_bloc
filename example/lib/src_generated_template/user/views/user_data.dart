part of '../user.dart';

class UserDataView extends StatelessWidget {
  const UserDataView({super.key});

  @override
  Widget build(BuildContext context) {
    return ApiBloc(
      controller: UserDataController(),
      child: BlocBuilder<UserDataController, ReadStates>(
        builder: (context, state, child) {
          if (state is ReadSuccessState<UserDataModel>) {
          } else if (state is ReadErrorState) {}
          return Text(state.message);
        },
      ),
    );
  }
}
