import 'package:flutter/material.dart';

class AppBarIcons extends StatelessWidget {
  const AppBarIcons({super.key, required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 35,
        width: 35,
        decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(255, 209, 205, 205)),
          shape: BoxShape.circle,
          color: const Color.fromARGB(255, 248, 248, 248),
        ),
        child: Center(
          child: Icon(icon, color: const Color.fromARGB(255, 157, 156, 156)),
        ),
      ),
    );
  }
}
