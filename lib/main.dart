import 'package:anomaly_detection_system/constants/global_variables.dart';
import 'package:anomaly_detection_system/features/auth/controller/auth_controller.dart';
import 'package:anomaly_detection_system/features/auth/repository/auth_repository.dart';
import 'package:anomaly_detection_system/features/auth/screens/auth_screen.dart';
import 'package:anomaly_detection_system/features/home/screens/home_screen.dart';
import 'package:anomaly_detection_system/providers/user_provider.dart';
import 'package:anomaly_detection_system/router.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    ref.read(authControllerProvider).getUserData(context: context, ref: ref);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(foregroundColor: Colors.black54)),
        appBarTheme: const AppBarTheme(
          elevation: 8,
          foregroundColor: Colors.black54,
          actionsIconTheme: IconThemeData(
            color: Colors.black54,
          ),
          toolbarTextStyle: TextStyle(color: Colors.black54),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
      ),
      onGenerateRoute: ((settings) => onGenerateRoute(settings)),
      home: ref.watch(userProvider).token.isNotEmpty
          ? const HomeScreen()
          : const AuthScreen(),
    );
  }
}
