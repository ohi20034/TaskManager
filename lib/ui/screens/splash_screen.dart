import 'package:flutter/material.dart';
import 'package:flutter_application_9/ui/screens/login_screen.dart';
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

  void gotToLogin() {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
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
