import 'package:clinic/core/utils/colors_manager.dart';
import 'package:clinic/presentation/screens/doctor/doctor_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:hugeicons/hugeicons.dart';

class PatientApp extends StatefulWidget {
  const PatientApp({super.key});
  static final String path = '/PatientApp';

  @override
  State<PatientApp> createState() => _PatientAppState();
}

class _PatientAppState extends State<PatientApp> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    HomePage(),
    SearchPage(),
    SearchPage(),
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
        margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 15),
        itemPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
        items: <SalomonBottomBarItem>[
          SalomonBottomBarItem(
            icon: const Icon(HugeIcons.strokeRoundedHome03),
            title: const Text('Home'),
          ),
          SalomonBottomBarItem(
            icon: const Icon(CupertinoIcons.chart_bar),
            title: const Text('Chat'),
          ),
          SalomonBottomBarItem(
            icon: const Icon(CupertinoIcons.captions_bubble),
            title: const Text('Chat'),
          ),
          SalomonBottomBarItem(
            icon: const Icon(HugeIcons.strokeRoundedClock01),
            title: const Text('Schedule'),
          ),
          SalomonBottomBarItem(
            icon: const Icon(HugeIcons.strokeRoundedNotification03),
            title: const Text('Schedule'),
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

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'مرحباً بك في الصفحة الرئيسية',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('صفحة البحث', style: TextStyle(fontSize: 24)),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('الملف الشخصي', style: TextStyle(fontSize: 24)),
    );
  }
}
