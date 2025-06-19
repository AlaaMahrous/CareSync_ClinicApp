import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key, required this.image, this.onTap});
  final Image image;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(borderRadius: BorderRadius.circular(100), child: image),
        Positioned(
          bottom: 5,
          right: 5,
          child: InkWell(
            onTap: onTap,
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
