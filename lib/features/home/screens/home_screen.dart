import 'package:anomaly_detection_system/constants/global_variables.dart';
import 'package:anomaly_detection_system/features/auth/controller/auth_controller.dart';
import 'package:anomaly_detection_system/features/emergency/screens/emergency_screen.dart';
import 'package:anomaly_detection_system/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      appBar: AppBar(title: Text('Hey ${user.name}!'), actions: [
        TextButton.icon(
          onPressed: logout,
          icon: const Icon(
            Icons.logout,
            color: Colors.black,
          ),
          label: Text(
            _isLoading ? 'Signing you out' : 'Logout',
          ),
        )
      ]),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {},
                child: const Text('Register Your Face'),
              ),
              const SizedBox(
                height: 10,
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {},
                child: const Text('Compare Faces'),
              ),
              const SizedBox(
                height: 10,
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {},
                child: const Text('Remove Face Data'),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {},
                icon: const Icon(FontAwesomeIcons.peopleGroup),
                label: const Text('Community People'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pushNamed(EmergencyScreen.routeName);
        },
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.local_police),
        label: const Text('Emergency'),
      ),
    );
  }
}
