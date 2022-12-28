import 'package:anomaly_detection_system/features/auth/screens/auth_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: ((context) => const AuthScreen()),
      );

    default:
      return MaterialPageRoute(
        builder: ((context) => const Scaffold(
              body: Center(
                child: Text(
                  'Page does not exist',
                ),
              ),
            )),
      );
  }
}
