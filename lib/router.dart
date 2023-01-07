import 'package:anomaly_detection_system/features/auth/screens/auth_screen.dart';
import 'package:anomaly_detection_system/features/community/screens/community_screen.dart';
import 'package:anomaly_detection_system/features/emergency/screens/emergency_screen.dart';
import 'package:anomaly_detection_system/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute<AuthScreen>(
        settings: settings,
        builder: ((context) => const AuthScreen()),
      );

    case HomeScreen.routeName:
      return MaterialPageRoute<HomeScreen>(
        settings: settings,
        builder: ((context) => const HomeScreen()),
      );

    case EmergencyScreen.routeName:
      return MaterialPageRoute<EmergencyScreen>(
        settings: settings,
        builder: ((context) => const EmergencyScreen()),
      );

    case CommunityScreen.routeName:
      return MaterialPageRoute<CommunityScreen>(
        settings: settings,
        builder: ((context) => const CommunityScreen()),
      );

    default:
      return MaterialPageRoute<Scaffold>(
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
