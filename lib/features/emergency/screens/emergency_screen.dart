import 'package:anomaly_detection_system/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyScreen extends StatelessWidget {
  static const routeName = '/emergencyScreen';
  const EmergencyScreen({super.key});

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Helpline Dialers'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                createEmergencyButton(
                  title: 'Rescue',
                  phoneNumberLabel: '1122',
                  icondata: FontAwesomeIcons.peopleGroup,
                  onMakeCall: (number) {
                    _makePhoneCall(number);
                  },
                ),
                const SizedBox(height: 16),
                createEmergencyButton(
                  title: 'Counter Terrorism Department (CTD)',
                  phoneNumberLabel: '0800-111-11',
                  icondata: Icons.local_police,
                  onMakeCall: (number) {
                    _makePhoneCall(number);
                  },
                ),
                const SizedBox(height: 16),
                createEmergencyButton(
                  title: 'Edhi Ambulance',
                  phoneNumberLabel: '115',
                  icondata: FontAwesomeIcons.truckMedical,
                  onMakeCall: (number) {
                    _makePhoneCall(number);
                  },
                ),
                SizedBox(height: 16),
                createEmergencyButton(
                  title: 'Ranger Helpline',
                  phoneNumberLabel: '1101',
                  icondata: Icons.local_police,
                  onMakeCall: (number) {
                    _makePhoneCall(number);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column createEmergencyButton(
      {required String title,
      required String phoneNumberLabel,
      required IconData icondata,
      required Function(String) onMakeCall}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black54),
          ),
        ),
        const SizedBox(
          height: 06,
        ),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              backgroundColor: Colors.grey,
              minimumSize: const Size(double.infinity, 50)),
          onPressed: () => onMakeCall(phoneNumberLabel),
          icon: FaIcon(icondata),
          label: Text(phoneNumberLabel),
        ),
      ],
    );
  }
}
