import 'package:flutter_yt_v2/data/models/user.dart';

abstract class ChannelScreenState {}

class ChannelLoadingState extends ChannelScreenState {}

class ChannelLoadedState extends ChannelScreenState {
  final User user;

  ChannelLoadedState({required this.user});
}

class ChannelErrorState extends ChannelScreenState {
  final Object err;

  ChannelErrorState({required this.err});
}