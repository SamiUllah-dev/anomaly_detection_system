import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

Future<void> makePhoneCall(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  await launchUrl(launchUri);
}

Future<XFile?> pickImage(BuildContext context, ImageSource imageSource) async {
  try {
    final picker = ImagePicker();
    XFile? imageFile = await picker.pickImage(source: imageSource);
    if (imageFile != null) {
      return imageFile;
    }
    return null;
  } catch (e) {
    showSnackBar(context, e.toString());
  }
}
