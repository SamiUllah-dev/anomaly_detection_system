import 'package:anomaly_detection_system/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

typedef JsonData = String;

class UserProvider extends ChangeNotifier {
  User _user = User(id: '', name: '', email: '', password: '');

  User get user => _user;

  void setUser(JsonData user) {
    _user = User.fromJson(user);
    notifyListeners();
  }
}
