abstract class LikeButtonState {}

class LikeButtonLoadingState extends LikeButtonState {}

class LikeButtonLoadedState extends LikeButtonState {
  final bool isLiked;

  LikeButtonLoadedState({required this.isLiked});
}

class LikeButtonErrorState extends LikeButtonState {
  final Object err;

  LikeButtonErrorState({required this.err});
}