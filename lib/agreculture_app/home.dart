import 'package:agre_aproject/agreculture_app/login_screens/homepagecontent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:agre_aproject/agreculture_app/homepagetab.dart';
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
                    child: SvgPicture.network(
                      'https://firebasestorage.googleapis.com/v0/b/final-sem-project-93001.appspot.com/o/icons%2Fhome_filled.svg?alt=media&token=2e0bac97-f0b1-42ea-b3c7-c25fb6420c7e',
                      width: 24,
                      height: 24,
                    ),
                  )
                : SvgPicture.network(
                    'https://firebasestorage.googleapis.com/v0/b/final-sem-project-93001.appspot.com/o/icons%2Fhome.svg?alt=media&token=4278e354-e40d-4130-a218-74201d9379a8',
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
                    child: SvgPicture.network(
                      'https://firebasestorage.googleapis.com/v0/b/final-sem-project-93001.appspot.com/o/icons%2Fsoil_filled.svg?alt=media&token=559bc644-881b-4123-8557-460aa9796a6e',
                      width: 24,
                      height: 24,
                    ),
                  )
                : SvgPicture.network(
                    'https://firebasestorage.googleapis.com/v0/b/final-sem-project-93001.appspot.com/o/icons%2Fsoil.svg?alt=media&token=99570662-47b5-4711-83d0-3cb2a02c5b8c',
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
                    child: SvgPicture.network(
                      'https://firebasestorage.googleapis.com/v0/b/final-sem-project-93001.appspot.com/o/icons%2Fcrop_filled.svg?alt=media&token=2c31d6b4-00e7-4056-8add-3840fda05b04',
                      width: 24,
                      height: 24,
                    ),
                  )
                : SvgPicture.network(
                    'https://firebasestorage.googleapis.com/v0/b/final-sem-project-93001.appspot.com/o/icons%2Fcrop.svg?alt=media&token=c4c46bcc-a196-4177-9b8c-65b1bde97cc7',
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
                    child: SvgPicture.network(
                      'https://firebasestorage.googleapis.com/v0/b/final-sem-project-93001.appspot.com/o/icons%2Fnewspaper-icon.svg?alt=media&token=8cd171fc-b441-405d-8cc3-05460a2916c4',
                      width: 24,
                      height: 24,
                    ),
                  )
                : SvgPicture.network(
                    'https://firebasestorage.googleapis.com/v0/b/final-sem-project-93001.appspot.com/o/icons%2Fnewspaper-icon.svg?alt=media&token=8cd171fc-b441-405d-8cc3-05460a2916c4',
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
                    child: SvgPicture.network(
                      'https://firebasestorage.googleapis.com/v0/b/final-sem-project-93001.appspot.com/o/icons%2Ftool_filled.svg?alt=media&token=1a50d557-7f04-4e1f-a3a6-0259a3139033',
                      width: 24,
                      height: 24,
                    ),
                  )
                : SvgPicture.network(
                    'https://firebasestorage.googleapis.com/v0/b/final-sem-project-93001.appspot.com/o/icons%2Ftool.svg?alt=media&token=bce3faf8-bc5a-4f23-a555-2d6f69441f80',
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
