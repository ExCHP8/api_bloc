part of 'package:api_bloc/api_bloc.dart';

class SendController extends BlocController<SendStates> {
  SendController({required this.request, bool autorun = false})
      : super(const SendIdleState()) {
    if (autorun) run();
  }
  final Stream<SendStates> request;

  Future<void> run() async {
    try {
      value = const SendLoadingState();
      request.listen((state) => value = state);
    } catch (e) {
      value = SendErrorState(message: '$e');
    }
  }
}
