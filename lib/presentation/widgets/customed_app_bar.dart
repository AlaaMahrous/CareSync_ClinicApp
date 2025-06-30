import 'package:clinic/presentation/widgets/app_bar_icons.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class CustomedAppBar extends StatelessWidget {
  const CustomedAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(
              'https://sesjzerlawpywdufplrw.supabase.co/storage/v1/object/public/images/profile/b5408107-0a2e-4634-a15f-76135cdb4487',
              height: 48,
            ),
          ),
          const SizedBox(width: 10),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Hi, Alaa Mahrous',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 15,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Wish you good today!',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 72, 71, 71),
                ),
              ),
            ],
          ),
          const Expanded(child: SizedBox()),
          const AppBarIcons(icon: HugeIcons.strokeRoundedSearch01),
          const SizedBox(width: 5),
          const AppBarIcons(icon: HugeIcons.strokeRoundedNotification03),
        ],
      ),
    );
  }
}
