import 'package:anomaly_detection_system/constants/global_variables.dart';
import 'package:anomaly_detection_system/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthScreen extends ConsumerStatefulWidget {
  static const routeName = '/auth-screen';
  const AuthScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthScreenState();
}

enum Auth {
  signin,
  signup,
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  var _auth = Auth.signup;
  var _isLoading = false;
  final _signupFormKey = GlobalKey<FormState>();
  final _signinFormKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void signUp() async {
    if (!_signupFormKey.currentState!.validate()) {
      return;
    }
    setState(() => _isLoading = true);

    await ref.read(authControllerProvider).signUpUser(
          name: _nameController.text,
          email: _emailController.text,
          password: _passwordController.text,
          context: context,
        );
    setState(() => _isLoading = false);
  }

  void signIn() async {
    if (!_signinFormKey.currentState!.validate()) {
      return;
    }
    setState(() => _isLoading = true);

    await ref.read(authControllerProvider).signInUser(
          email: _emailController.text,
          password: _passwordController.text,
          context: context,
          ref: ref,
        );
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
                ListTile(
                  tileColor: _auth == Auth.signup
                      ? Colors.white
                      : GlobalVariables.greyBackgroundCOlor,
                  leading: Radio(
                    value: Auth.signup,
                    activeColor: GlobalVariables.secondaryColor,
                    groupValue: _auth,
                    onChanged: (value) {
                      setState(() {
                        _emailController.clear();
                        _passwordController.clear();
                        _nameController.clear();
                        _auth = value!;
                      });
                    },
                  ),
                  title: const Text(
                    'Create Account.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (_auth == Auth.signup)
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: _signupFormKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CreateFormField(
                            hintText: 'Name',
                            controller: _nameController,
                          ),
                          const SizedBox(height: 10),
                          CreateFormField(
                            hintText: 'Email',
                            controller: _emailController,
                          ),
                          const SizedBox(height: 10),
                          CreateFormField(
                            hintText: 'Password',
                            controller: _passwordController,
                            obscureText: true,
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: signUp,
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 50)),
                            child: _isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text('Sign Up'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ListTile(
                  tileColor: _auth == Auth.signin
                      ? Colors.white
                      : GlobalVariables.greyBackgroundCOlor,
                  leading: Radio(
                    value: Auth.signin,
                    activeColor: GlobalVariables.secondaryColor,
                    groupValue: _auth,
                    onChanged: (value) {
                      setState(() {
                        _emailController.clear();
                        _passwordController.clear();
                        _nameController.clear();
                        _auth = value!;
                      });
                    },
                  ),
                  title: const Text(
                    'Sign-In.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (_auth == Auth.signin)
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: _signinFormKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 10),
                          CreateFormField(
                            hintText: 'Email',
                            controller: _emailController,
                          ),
                          const SizedBox(height: 10),
                          CreateFormField(
                            hintText: 'Password',
                            controller: _passwordController,
                            obscureText: true,
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: signIn,
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 50)),
                            child: _isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text('Sign In'),
                          )
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CreateFormField extends StatelessWidget {
  final hintText;
  final obscureText;
  final controller;
  const CreateFormField({
    required this.hintText,
    this.obscureText = false,
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          border: const OutlineInputBorder(), hintText: hintText),
      obscureText: obscureText,
      controller: controller,
      validator: ((value) {
        if (value!.isEmpty) {
          return 'Field is required';
        }
        return null;
      }),
    );
  }
}
