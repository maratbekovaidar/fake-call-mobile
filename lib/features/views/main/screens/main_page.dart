import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:fake_call_mobile/features/views/friends/screens/friends_page.dart';
import 'package:fake_call_mobile/features/views/home/screens/home_page.dart';
import 'package:fake_call_mobile/features/views/map/screens/map_page.dart';
import 'package:fake_call_mobile/features/views/profile/screens/profile_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  static const String route = "/";

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int _currentIndex = 0;

  late PageController _pageController;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              "assets/background/background_1.jpg"
            )
          )
        ),
        child: SizedBox.expand(
          child: PageView(
            physics: _currentIndex == 2 ? const NeverScrollableScrollPhysics() : null,
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            children: const <Widget>[
              HomePage(),
              FriendsPage(),
              MapPage(),
              ProfilePage()
            ],
          ),
        )
      ),

      /// Bottom Navigation Bar
      bottomNavigationBar: BottomNavyBar(
        animationDuration: const Duration(milliseconds: 300),
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.ease);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              title: const Text('Home'),
              icon: const Icon(Icons.home_rounded)
          ),
          BottomNavyBarItem(
              title: const Text('Friends'),
              icon: const Icon(Icons.person_add_alt_1_rounded)
          ),
          BottomNavyBarItem(
              title: const Text('Location'),
              icon: const Icon(Icons.location_on_rounded)
          ),
          BottomNavyBarItem(
              title: const Text('Profile'),
              icon: const Icon(Icons.person_rounded)
          ),
        ],
      )
    );
  }
}
