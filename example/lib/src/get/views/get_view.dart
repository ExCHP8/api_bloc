part of '../get.dart';

class GetUserView extends StatelessWidget {
  const GetUserView({super.key});

  @override
  Widget build(BuildContext context) {
    return ApiBloc(
      controller: GetUserController(),
      builder: (context, controller) => Scaffold(
        appBar: AppBar(title: const Text('GET Request')),
        body: RefreshIndicator(
          onRefresh: controller.run,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Container(
              alignment: Alignment.center,
              height: MediaQuery.sizeOf(context).height - kToolbarHeight,
              child: BlocBuilder<GetUserController, ReadStates>(
                builder: (context, state, child) {
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
                    case ReadErrorState<StackTrace> _:
                      return Text('Oops something is wrong\n${state.message}');
                    default:
                      return const CircularProgressIndicator();
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
