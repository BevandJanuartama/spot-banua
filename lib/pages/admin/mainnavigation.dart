import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'index.dart';
import 'favorite.dart';
import 'profile.dart';
import 'discover.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;
  late PageController _pageController;

  // Dynamic icons with color change on selection
  List<Widget> get navigationItems {
    return [
      Icon(
        Icons.home,
        size: 35,
        color: _selectedIndex == 0 ? Colors.white : const Color(0xFF320766),
      ),
      Icon(
        FontAwesomeIcons.compass,
        size: 35,
        color: _selectedIndex == 1 ? Colors.white : const Color(0xFF320766),
      ),
      Icon(
        Icons.favorite,
        size: 35,
        color: _selectedIndex == 2 ? Colors.white : const Color(0xFF320766),
      ),
      Icon(
        Icons.person,
        size: 35,
        color: _selectedIndex == 3 ? Colors.white : const Color(0xFF320766),
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: const [
          HomePage(),
          DiscoverPage(),
          FavoritePage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        items: navigationItems,
        height: 60,
        backgroundColor: Colors.transparent,
        color: const Color(0xFFFFFFFF),
        buttonBackgroundColor: const Color(0xFF320766),
        animationDuration: const Duration(milliseconds: 300),
        animationCurve: Curves.easeInOut,
        onTap: _onItemTapped,
      ),
    );
  }
}
