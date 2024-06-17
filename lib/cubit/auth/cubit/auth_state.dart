part of 'auth_cubit.dart';

@immutable
class AuthState {
  final bool isLoggeIn;
  final String? accessToken;
  const AuthState({required this.isLoggeIn, this.accessToken});
}

final class AuthInitialState extends AuthState {
  const AuthInitialState() : super(isLoggeIn: true, accessToken: "");
}
