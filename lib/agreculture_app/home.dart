import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:agre_aproject/agreculture_app/homepagetab.dart';
import 'package:agre_aproject/agreculture_app/soiltab.dart';
import 'package:agre_aproject/agreculture_app/cropstab.dart';
import 'package:agre_aproject/agreculture_app/toolstab.dart';
import 'package:agre_aproject/agreculture_app/newstab.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF779D07),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    Container(
      child: Center(
        child: HomePageTab(),
      ),
    ),
    Container(
      child: Center(
        child: HomesoilTab(),
      ),
    ),
    Container(
      child: Center(
        child: HomecropsTab(),
      ),
    ),
    Container(
      child: Center(
        child: MyNewsApp(),
      ),
    ),
    Container(
      child: Center(
        child: HometoolTab(),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor:
            Color(0xFF779D07), // Set the active tab color to green
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: _currentIndex == 0
                ? ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Color(0xFF779D07),
                      BlendMode.srcIn,
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/home_filled.svg',
                      width: 24,
                      height: 24,
                    ),
                  )
                : SvgPicture.asset(
                    'assets/icons/home.svg',
                    width: 24,
                    height: 24,
                  ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 1
                ? ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Color(0xFF779D07),
                      BlendMode.srcIn,
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/soil_filled.svg',
                      width: 24,
                      height: 24,
                    ),
                  )
                : SvgPicture.asset(
                    'assets/icons/soil.svg',
                    width: 24,
                    height: 24,
                  ),
            label: 'Soil Pedia',
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 2
                ? ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Color(0xFF779D07),
                      BlendMode.srcIn,
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/crop_filled.svg',
                      width: 24,
                      height: 24,
                    ),
                  )
                : SvgPicture.asset(
                    'assets/icons/crop.svg',
                    width: 24,
                    height: 24,
                  ),
            label: 'Crops',
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 3
                ? ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Color(0xFF779D07),
                      BlendMode.srcIn,
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/newspaper-icon.svg',
                      width: 24,
                      height: 24,
                    ),
                  )
                : SvgPicture.asset(
                    'assets/icons/newspaper-icon.svg',
                    width: 24,
                    height: 24,
                  ),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 4
                ? ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Color(0xFF779D07),
                      BlendMode.srcIn,
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/tool_filled.svg',
                      width: 24,
                      height: 24,
                    ),
                  )
                : SvgPicture.asset(
                    'assets/icons/tool.svg',
                    width: 24,
                    height: 24,
                  ),
            label: 'Tools',
          ),
        ],
      ),
    );
  }
}
