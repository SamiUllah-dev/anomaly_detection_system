import 'package:anomaly_detection_system/constants/global_variables.dart';
import 'package:anomaly_detection_system/constants/utils.dart';
import 'package:anomaly_detection_system/features/auth/controller/auth_controller.dart';
import 'package:anomaly_detection_system/features/community/screens/community_screen.dart';
import 'package:anomaly_detection_system/features/emergency/screens/emergency_screen.dart';
import 'package:anomaly_detection_system/features/home/services/face_registration.dart';
import 'package:anomaly_detection_system/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const routeName = '/home-screen';
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  // for logout
  var _isLoading = false;
  var _faceIsProcessing = false;
  void logout() {
    setState(() => _isLoading = true);
    ref.read(authControllerProvider).logout(ref: ref);
    setState(() => _isLoading = false);
  }

  void unregisterFace(BuildContext context, ImageSource imageSource) async {
    XFile? pickedImage = await pickImage(context, imageSource);
    if (pickedImage != null) {
      setState(() {
        _faceIsProcessing = true;
      });
      await Future.delayed(const Duration(seconds: 3));
      await unregister(
          context: context,
          email: ref.read(userProvider).email,
          name: ref.read(userProvider).name);
      setState(() {
        _faceIsProcessing = false;
      });
    }
  }

  void registerFace(BuildContext context, ImageSource imageSource) async {
    XFile? pickedImage = await pickImage(context, imageSource);
    if (pickedImage != null) {
      setState(() {
        _faceIsProcessing = true;
      });
      await Future.delayed(const Duration(seconds: 3));
      await register(
          context: context,
          image: pickedImage,
          name: (ref.read(userProvider).email) + ref.read(userProvider).name);
      setState(() {
        _faceIsProcessing = false;
      });
    }
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
        child: _faceIsProcessing
            ? AlertDialog(
                title: const Text('Face Processing'),
                content: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Fetching Face Data'),
                    SizedBox(
                      width: 10,
                    ),
                    CircularProgressIndicator(),
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      onPressed: () async {
                        final source = await imageSource(context);
                        if (source != null) {
                          registerFace(context, source);
                        }
                      },
                      child: const Text('Register Your Face'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      onPressed: () async {
                        final source = await imageSource(context);
                        if (source != null) {
                          unregisterFace(context, source);
                        }
                      },
                      child: const Text('Remove Face Data'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      onPressed: () => Navigator.of(context)
                          .pushNamed(CommunityScreen.routeName),
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

Future<ImageSource?> imageSource(BuildContext context) async {
  return showDialog<ImageSource?>(
    context: context,
    builder: ((context) => SimpleDialog(
          title: Text('Choose Image'),
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(ImageSource.camera),
              child: const Text('Camera'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(ImageSource.gallery),
              child: const Text('Gallery'),
            ),
          ],
        )),
  );
}
