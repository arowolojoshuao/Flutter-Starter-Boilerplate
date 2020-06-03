import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:specta_mobile/blocs/bloc/bloc.dart';
import 'package:specta_mobile/manager/UserAuthRepository/UserAuthRepository.dart';
import 'package:specta_mobile/service_locator.dart';
import './bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserAuthManager userAuthManager;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({@required this.authenticationBloc, @required this.userAuthManager}):  assert(userAuthManager != null), assert(authenticationBloc != null);
  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final token = await userAuthManager.login(
          username: event.username,
          password: event.password,
        );

        authenticationBloc.dispatch(LoggedIn(token: token));
        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
  }
