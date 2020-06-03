import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:specta_mobile/manager/UserAuthRepository/UserAuthRepository.dart';
import 'package:specta_mobile/service_locator.dart';
import './bloc.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {

  final UserAuthManager userAuthManager;
  AuthenticationBloc({@required this.userAuthManager}) : assert(userAuthManager != null);
  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if(event is AppStarted) {
      final bool hasToken = await userAuthManager.hasToken();

      if(hasToken) {
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
      await userAuthManager.persistToken(event.token);
      yield AuthenticationAuthenticated();
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await userAuthManager.deleteToken();
      yield AuthenticationUnauthenticated();
    }
  }
}
