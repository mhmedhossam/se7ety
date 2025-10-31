class AuthStates {}

class AuthLoadingState extends AuthStates {}

class AuthInitialState extends AuthStates {}

class AuthFailureState extends AuthStates {
  String? message;
  AuthFailureState({this.message});
}

class AuthSucceedState extends AuthStates {}
