import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import 'package:radarweather/provider/weather_provider.dart';
import 'package:radarweather/screen/forecast/forecast.dart';

import 'package:radarweather/screen/search/search.dart';

import '../mapscreen/TileProvider/radarv2.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedItems = 0;
  final PageController _pageController =
      PageController(); // Agregar PageController

  WeatherProvider? weatherProvider;

  @override
  void dispose() {
    _pageController.dispose(); // Dispose del PageController
    weatherProvider?.positionStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const Forecast(),
      const Radarv2(),
      const Search(),
    ];

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 1, 26, 64),
            Color.fromARGB(255, 24, 143, 248)
          ],
          begin: Alignment.topLeft,
          end: Alignment.topRight,
        ),
      ),
      child: Scaffold(
        body: PageView(
          controller: _pageController, // Asignar el PageController
          children: screens, // Lista de widgets de las diferentes pestañas
          onPageChanged: (index) {
            setState(() {
              _selectedItems =
                  index; // Actualizar el índice seleccionado al cambiar de página
            });
          },
        ),
        backgroundColor: Colors.transparent,
        bottomNavigationBar: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: GNav(
            selectedIndex: _selectedItems,
            rippleColor: Colors.black38,
            hoverColor: Colors.blue[700]!,
            haptic: true,
            tabBorderRadius: 15,
            tabActiveBorder: Border.all(color: Colors.blue[900]!, width: 1),
            tabBorder: Border.all(color: Colors.black38, width: 1),
            tabShadow: [
              BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)
            ],
            curve: Curves.easeOutExpo,
            duration: const Duration(milliseconds: 900),
            gap: 8,
            color: Colors.black,
            activeColor: Colors.black54,
            iconSize: 24,
            tabBackgroundColor: Colors.blue.withOpacity(0.1),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            onTabChange: (index) {
              setState(() {
                _selectedItems = index;
                _pageController.jumpToPage(
                    index); // Cambiar directamente a la página seleccionada
              });
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
            ],
          ),
        ),
      ),
    );
  }
}
