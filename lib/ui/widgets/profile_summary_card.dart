import 'package:flutter/material.dart';
import 'package:flutter_application_9/ui/controllers/auth_controller.dart';
import 'package:flutter_application_9/ui/screens/edit_profile_screen.dart';
import 'package:flutter_application_9/ui/screens/login_screen.dart';

class ProfileSummaryCard extends StatefulWidget {
  const ProfileSummaryCard({
    super.key,
    this.enableOnTap = true,
  });

  final bool enableOnTap;

  @override
  State<ProfileSummaryCard> createState() => _ProfileSummaryCardState();
}

class _ProfileSummaryCardState extends State<ProfileSummaryCard> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (widget.enableOnTap) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EditProfileScreen(),
            ),
          );
        }
      },
      leading: const CircleAvatar(
        child: Icon(Icons.person),
      ),
      title: Text(
        fullName,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: Text(
        AuthControler.user?.email ?? '',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
      trailing: IconButton(
        onPressed: () async {
          await AuthControler.clearAuthData();
          if (context.mounted) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false);
          }
        },
        icon: const Icon(Icons.logout),
      ),
      tileColor: Colors.red,
    );
  }

  String get fullName {
    return '${AuthControler.user?.firstName ?? ''} ${AuthControler.user?.lastName ?? ''}';
  }
}
