import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key, required this.backgroundImage, this.onTap});
  final ImageProvider<Object>? backgroundImage;
  final void Function()? onTap;

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
          right: 5,
          child: InkWell(
            onTap: () {},
            child: Container(
              height: 25,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.asset("assets/images/edit.png"),
            ),
          ),
        ),
      ],
    );
  }
}
