import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const CircleAvatar(
          radius: 55,
          backgroundImage: AssetImage("assets/images/profile.jpeg"),
        ),
        Positioned(
          bottom: 5,
          right: 10,
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 188, 183, 183),
            ),
            child: Icon(Icons.edit),
          ),
        ),
      ],
    );
  }
}
