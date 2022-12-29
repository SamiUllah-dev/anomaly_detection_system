import 'dart:convert';

import 'package:anomaly_detection_system/constants/error_handling.dart';
import 'package:anomaly_detection_system/constants/global_variables.dart';
import 'package:anomaly_detection_system/constants/utils.dart';
import 'package:anomaly_detection_system/features/auth/screens/auth_screen.dart';
import 'package:anomaly_detection_system/features/home/screens/home_screen.dart';
import 'package:anomaly_detection_system/models/user.dart';
import 'package:anomaly_detection_system/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository());

class AuthRepository {
  Future<void> signUpUser({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final user =
          User(id: '', name: name, email: email, password: password, token: '');
      final url = Uri.parse('$uri/api/signup');
      final response =
          await http.post(url, body: user.toJson(), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });
      httpErrorHandler(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Account created!');
          });
    } catch (e) {
      print('Error');
    }
  }

  Future<void> signInUser({
    required String email,
    required String password,
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    try {
      final user =
          User(id: '', name: '', email: email, password: password, token: '');
      final url = Uri.parse('$uri/api/signin');
      final response =
          await http.post(url, body: user.toJson(), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });
      httpErrorHandler(
          response: response,
          context: context,
          onSuccess: () async {
            SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            ref.read(userProvider.notifier).setUser(response.body);
            await sharedPreferences.setString(
                'x-auth-token', jsonDecode(response.body)['token']);
            Navigator.of(context).pushNamedAndRemoveUntil(
                HomeScreen.routeName, (route) => false);
          });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout({required WidgetRef ref}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('x-auth-token', '');
    ref.read(userProvider.notifier).setToken('');
  }

  void getUserData(
      {required BuildContext context, required WidgetRef ref}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
        return;
      }
      final url = Uri.parse('$uri/api/tokenIsValid');
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
      );

      final tokenisValid = jsonDecode(response.body) as bool;

      if (tokenisValid) {
        final response = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token,
          },
        );

        ref.read(userProvider.notifier).setUser(response.body);
      }
    } catch (e) {
      rethrow;
    }
  }
}
