import 'dart:convert';

import 'package:anomaly_detection_system/constants/global_variables.dart';
import 'package:anomaly_detection_system/constants/utils.dart';
import 'package:anomaly_detection_system/features/community/models/face.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

Future<void> unregister(
    {required BuildContext context,
    required String email,
    required String name}) async {
  final unregistrationDetails = await http.post(
    Uri.parse(
      '$uri/api/delete-face',
    ),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: Face(id: '', name: '$email$name', secureUrl: '').toJson(),
  );
  final result = jsonDecode(unregistrationDetails.body)['msg'];
  print("RESULT " + result.toString());
  if (result == 'deleted') {
    showSnackBar(context, "Face Successfully unregistered");
  } else {
    showSnackBar(context, "This face is not registered");
  }
}

Future<void> register(
    {required BuildContext context,
    required XFile image,
    required String name}) async {
  final registrationDetails = await http.post(
    Uri.parse(
      '$uri/api/faceIsRegistred',
    ),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: Face(id: '', name: name, secureUrl: '').toJson(),
  );
  final String result = jsonDecode(registrationDetails.body)['msg'];
  if (result == 'already-registered') {
    showSnackBar(context, 'Face Already Registered');
    return;
  }
  final cloudinary = CloudinaryPublic(
    'dkktq9syf',
    'qqtfkrf4',
  );

  final response = await cloudinary.uploadFile(
    CloudinaryFile.fromFile(
      image.path,
      folder: name,
    ),
  );
  final secureUrl = response.secureUrl;
  print('BEFORE');
  await http.post(
    Uri.parse('$uri/api/register-face'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: Face(id: '', name: name, secureUrl: secureUrl).toJson(),
  );
  print('AFTER');
  showSnackBar(context, 'Your Face is successfully registered');
  return;
}
