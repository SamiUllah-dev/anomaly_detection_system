import 'package:anomaly_detection_system/features/auth/repository/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authControllerProvider = Provider((ref) {
  return ref.read(authRepositoryProvider);
});

class AuthController {
  final AuthRepository _authRepository;

  AuthController({required AuthRepository authRepository})
      : _authRepository = authRepository;

  Future<void> signUp(
      String name, String email, String password, BuildContext context) async {
    await _authRepository.signUpUser(
      name: name,
      email: email,
      password: password,
      context: context,
    );
  }

  Future<void> signIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    await _authRepository.signInUser(
      email: email,
      password: password,
      context: context,
    );
  }
}
