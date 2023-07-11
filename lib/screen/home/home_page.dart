import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:radarweather/screen/forecast/forecast.dart';
import 'package:radarweather/screen/mapscreen/radar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedItems = 0;
  final screens = [
    const Forecast(),
    const Radar(),
    Center(
      child: Text('data'),
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedItems],
      backgroundColor: Colors.blue,
      bottomNavigationBar: Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: GNav(
              selectedIndex: _selectedItems,
              rippleColor:
                  Colors.grey[800]!, // tab button ripple color when pressed
              hoverColor: Colors.grey[700]!, // tab button hover color
              haptic: true, // haptic feedback
              tabBorderRadius: 15,
              tabActiveBorder: Border.all(
                  color: Colors.black, width: 1), // tab button border
              tabBorder:
                  Border.all(color: Colors.grey, width: 1), // tab button border
              tabShadow: [
                BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)
              ], // tab button shadow
              curve: Curves.easeOutExpo, // tab animation curves
              duration:
                  const Duration(milliseconds: 900), // tab animation duration
              gap: 8, // the tab button gap between icon and text
              color: Colors.grey[800], // unselected icon color
              activeColor: Colors.purple, // selected icon and text color
              iconSize: 24, // tab button icon size
              tabBackgroundColor: Colors.purple
                  .withOpacity(0.1), // selected tab background color
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              // navigation bar padding
              onTabChange: (index) => {
                    setState(() {
                      _selectedItems = index;
                    })
                  },
              tabs: const [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: LineIcons.broadcastTower,
                  text: 'Radar',
                ),
                GButton(
                  icon: LineIcons.search,
                  text: 'Search',
                )
              ])),
    );
  }
}
