abstract class SubscribeButtonState {}

class SubscribeButtonLoadingState extends SubscribeButtonState {}

class SubscribeButtonLoadedState extends SubscribeButtonState {
  final bool isSubscribed;

  SubscribeButtonLoadedState({required this.isSubscribed});
}

class SubscribeButtonErrorState extends SubscribeButtonState {
  final Object err;

  SubscribeButtonErrorState({required this.err});
}