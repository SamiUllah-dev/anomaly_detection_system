import 'package:anomaly_detection_system/features/auth/controller/auth_controller.dart';
import 'package:anomaly_detection_system/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const routeName = '/home-screen';
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  // for logout
  var _isLoading = false;
  void logout() {
    setState(() => _isLoading = true);
    ref.read(authControllerProvider).logout(ref: ref);
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    return Scaffold(
      appBar: AppBar(actions: [
        TextButton(
            onPressed: logout,
            child: Text(
              _isLoading ? 'Signing you out' : 'Logout',
              style: TextStyle(color: Colors.white),
            ))
      ]),
      body: Center(child: Text(user.toString())),
    );
  }
}
