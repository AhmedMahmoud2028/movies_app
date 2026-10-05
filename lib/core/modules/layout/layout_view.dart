import 'package:flutter/material.dart';
import 'package:movies_app/core/modules/layout/explore/explore_view.dart';
import 'package:movies_app/core/modules/layout/home/home_view.dart';
import 'package:movies_app/core/modules/layout/profile/profile_view.dart';
import 'package:movies_app/core/modules/layout/search/search_view.dart';

import '../../configuration/gen/assets.gen.dart';


class LayoutView extends StatefulWidget {
  const LayoutView ({super.key});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    HomeView(),
    SearchView(),
    ExploreView(),
    ProfileView()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(

        currentIndex: _selectedIndex,
        onTap: (index) {
        _selectedIndex = index;
        setState(() { });
        },
          items: [
            BottomNavigationBarItem(
                label: "",
                icon: Assets.icons.homeIcon.svg(),
                activeIcon: Assets.icons.homeActiveIcon.svg()
            ),

            BottomNavigationBarItem(
                label: "",
                icon: Assets.icons.searchIcon.svg(),
                activeIcon: Assets.icons.searchActiveIcon.svg()
            ),

            BottomNavigationBarItem(
                label: "",
                icon: Assets.icons.exploreIcon.svg(),
                activeIcon: Assets.icons.exploreActiveIcon.svg()
            ),

            BottomNavigationBarItem(
                label: "",
                icon: Assets.icons.profileIcon.svg(),
                activeIcon: Assets.icons.profileActiveIcon.svg()
            )
          ]),

    );
  }
}
