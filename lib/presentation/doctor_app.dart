import 'package:clinic/core/utils/colors_manager.dart';
import 'package:clinic/presentation/screens/doctor/doctor_dashboard_screen.dart';
import 'package:clinic/presentation/screens/doctor/doctor_feeds_screen.dart';
import 'package:clinic/presentation/screens/doctor/doctor_profile_screen.dart';
import 'package:clinic/presentation/screens/doctor/doctor_schedule_screen.dart';
import 'package:clinic/presentation/screens/doctor/doctor_sessions_screen.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:hugeicons/hugeicons.dart';

class DoctorApp extends StatefulWidget {
  const DoctorApp({super.key});
  static final String path = '/DoctorApp';

  @override
  State<DoctorApp> createState() => _DoctorAppState();
}

class _DoctorAppState extends State<DoctorApp> {
  int _selectedIndex = 0;

  static List<Widget> _pages = <Widget>[
    DoctorDashboardScreen(),
    DoctorSessionsScreen(),
    DoctorScheduleScreen(),
    DoctorFeedsScreen(),
    DoctorProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: SalomonBottomBar(
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        selectedItemColor: ColorsManager.sAppColor,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        margin: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 15),
        itemPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
        items: <SalomonBottomBarItem>[
          SalomonBottomBarItem(
            icon: const Icon(CupertinoIcons.chart_bar),
            title: const Text('Dashboard'),
          ),
          SalomonBottomBarItem(
            icon: const Icon(CupertinoIcons.collections),
            title: const Text('Sessions'),
          ),
          SalomonBottomBarItem(
            icon: const Icon(HugeIcons.strokeRoundedClock01),
            title: const Text('Schedule'),
          ),
          SalomonBottomBarItem(
            icon: const Icon(HugeIcons.strokeRoundedNotification03),
            title: const Text('Feeds'),
          ),
          SalomonBottomBarItem(
            icon: const Icon(CupertinoIcons.person),
            title: const Text('Profile'),
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
