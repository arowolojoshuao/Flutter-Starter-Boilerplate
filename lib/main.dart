import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:specta_mobile/blocs/bloc/authentication_bloc.dart';
import 'package:specta_mobile/blocs/bloc/bloc.dart';
import 'package:specta_mobile/blocs/simple_bloc_delegate.dart';
import 'package:specta_mobile/manager/UserAuthRepository/UserAuthRepository.dart';
import 'package:specta_mobile/service_locator.dart';
import 'package:specta_mobile/ui/components/loading_indicator.dart';
import 'package:specta_mobile/ui/screens/homepage/homepage.dart';
import 'package:specta_mobile/ui/screens/login/login_page.dart';
import 'package:specta_mobile/ui/screens/splash/splash_page.dart';

void main() {
  // SystemChrome.setSystemUIOverlayStyle(
  //   SystemUiOverlayStyle(
  //     statusBarColor: Colors.transparent,
  //   ),
  // );

  // //* Forcing only portrait orientation
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  setupLocator();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final userAuthManager = UserAuthManager();
  runApp(
    BlocProvider<AuthenticationBloc>(
      builder: (context) {
        return AuthenticationBloc(userAuthManager: userAuthManager)
        ..dispatch(AppStarted());
      },
      child: SpectaApp(userAuthManager: userAuthManager,),
    )
  );
}

class SpectaApp extends StatelessWidget {
  final UserAuthManager userAuthManager;
  SpectaApp({Key key, @required this.userAuthManager}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        bloc: BlocProvider.of<AuthenticationBloc>(context),
        builder: (context, state) {
          if (state is AuthenticationAuthenticated) {
            return HomePage();
          }
          if (state is AuthenticationUnauthenticated) {
            return LoginPage(userAuthManager: userAuthManager,);
          }
          if (state is AuthenticationLoading) {
            return LoadingIndicator();
          }
          return SplashPage();
        },
      ),
    );
  }
}

