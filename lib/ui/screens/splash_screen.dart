import 'package:flutter/material.dart';
import 'package:flutter_application_9/ui/controllers/auth_controller.dart';
import 'package:flutter_application_9/ui/screens/login_screen.dart';
import 'package:flutter_application_9/ui/screens/main_bottom_nav_screen.dart';
import 'package:flutter_application_9/ui/widgets/bodyBackground.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    gotToLogin();
  }

  Future<void> gotToLogin() async {
    final bool isLoggedIn = await AuthControler.checkAuthState();
    Future.delayed(const Duration(seconds: 2)).then((value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) =>
                isLoggedIn ? const MainBottomNavScreen() : const LoginScreen(),
          ),
          (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BodyBackground(
      child: Center(
        child: SvgPicture.asset(
          'assets/images/logo.svg',
          width: 250,
        ),
      ),
    ));
  }
}
