import 'package:flutter/material.dart';
import 'package:flutter_application_9/data/models/user_model.dart';
import 'package:flutter_application_9/data/network_caller/network_coller.dart';
import 'package:flutter_application_9/data/network_caller/network_response.dart';
import 'package:flutter_application_9/data/utility/urls.dart';
import 'package:flutter_application_9/ui/controllers/auth_controller.dart';
import 'package:flutter_application_9/ui/screens/forgot_password_screen.dart';
import 'package:flutter_application_9/ui/screens/main_bottom_nav_screen.dart';

import 'package:flutter_application_9/ui/screens/sign_up_screen.dart';
import 'package:flutter_application_9/ui/widgets/bodyBackground.dart';
import 'package:flutter_application_9/ui/widgets/snack_message.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  final GlobalKey<FormState> _globalkey = GlobalKey<FormState>();
  bool _loginInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Form(
                key: _globalkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    Text(
                      'Get Started with',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                      controller: _emailTEController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter Your valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _passwordTEController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter Your Password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Visibility(
                        visible: _loginInProgress == false,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white),
                          onPressed: _login,
                          child: const Text('Login'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ForgotPasswordScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                            fontSize: 16,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Color.fromARGB(255, 213, 102, 94),
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    _loginInProgress = true;
    if (_globalkey.currentState!.validate()) {
      if (mounted) {
        setState(() {});
      }
      NetworkResponse response = await NetworkCaller().postRequest(
        Urls.login,
        body: {
          'email': _emailTEController.text.trim(),
          'password': _passwordTEController.text,
        },
      );
      _loginInProgress = false;
      if (mounted) {
        setState(() {});
      }
      if (response.isSuccess) {
        _clearTextFields();
        await AuthControler.savedUserInformation(
            response.jsonResponse?['token'],
            UserModel.fromJson(response.jsonResponse?['data']));
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MainBottomNavScreen(),
            ),
          );
        }
      } else {
        if (response.statusCode == 401) {
          if (mounted) {
            showSnackMessage(context, 'Please Check email/password');
          }
        } else {
          if (mounted) {
            showSnackMessage(context, 'Login failed. Try again');
          }
        }
      }
    }
  }

  void _clearTextFields() {
    _emailTEController.clear();
    _passwordTEController.clear();
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
