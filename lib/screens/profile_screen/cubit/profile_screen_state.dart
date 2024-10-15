import 'package:flutter_yt_v2/data/models/user.dart';

abstract class ProfileScreenState {}

class ProfileLoadingState extends ProfileScreenState{}

class ProfileFullFieldedState extends ProfileScreenState{
  final User profile;

  ProfileFullFieldedState({required this.profile});
}

class ProfileErrorState extends ProfileScreenState{
  final Object err;

  ProfileErrorState({required this.err});
}