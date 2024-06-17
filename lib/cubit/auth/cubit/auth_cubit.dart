import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  void login(String accessToken) {
    emit(AuthState(isLoggeIn: true, accessToken: accessToken));
  }

  void logout() {
    emit(const AuthState(isLoggeIn: false, accessToken: ""));
  }
}
