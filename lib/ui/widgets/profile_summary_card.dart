import 'package:flutter/material.dart';

class ProfileSummaryCard extends StatelessWidget {
  const ProfileSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      leading: CircleAvatar(
        child: Icon(Icons.person),
      ),
      title: Text(
        'Imdadul Haque Ohi',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: Text(
        'imdadul1@gmail.com',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
      trailing: Icon(Icons.arrow_forward),
      tileColor: Colors.red,
    );
  }
}
