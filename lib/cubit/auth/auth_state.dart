import 'package:flutter_yt_v2/data/models/user_data.dart';

/*abstract class AuthState {
  UserData? userData;
  AuthState(this.userData);
}

class AuthLoadingState extends AuthState {
  AuthLoadingState() : super(null);
}

class AuthorizedState extends AuthState {
  UserData data;

  AuthorizedState(this.data) : super(data);
}

class NoAuthState extends AuthState {
  NoAuthState() : super(null);
}

class AuthErrorState extends AuthState {
   Object err;

  AuthErrorState(this.err) : super(null);
}*/

abstract class AuthState {}

class AuthLoadingState extends AuthState {}

class AuthorizedState extends AuthState {
  final UserData userData;

  AuthorizedState({required this.userData});
}

class AuthErrorState extends AuthState {
  final Object e;

  AuthErrorState({required this.e});
}

class NoAuthState extends AuthState {}