import 'package:anomaly_detection_system/models/user.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

typedef JsonData = String;

class UserProvider extends StateNotifier<User> {
  UserProvider()
      : super(
          User(id: '', name: '', email: '', password: '', token: ''),
        );

  void setUser(JsonData user) {
    state = User.fromJson(user);
  }
}

final userProvider = StateNotifierProvider<UserProvider, User>((ref) {
  return UserProvider();
});
