import 'package:cropidentification/students.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash/animated_splash.dart';
import 'package:shifting_tabbar/shifting_tabbar.dart';
import 'home_page.dart';
import 'about_page.dart';
import 'my_map.dart';
import 'Desktop.dart';
import 'mobile.dart';
import 'tablet.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimatedSplash(
          imagePath: 'assets/splash1.png',
          home: HomePage(),
          duration: 2500,
          type: AnimatedSplashType.StaticDuration),
      debugShowCheckedModeBanner: false,
    );
  }
}

double deviceSize(BuildContext context) => MediaQuery.of(context).size.width;

class HomePage extends StatelessWidget {

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 800;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 800 &&
          MediaQuery.of(context).size.width < 1200;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1200;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: ShiftingTabBar(
            color: Colors.white,
            tabs: [
              ShiftingTab(icon: Icon(Icons.home), text: "Home"),
              ShiftingTab(icon: Icon(Icons.agriculture), text: "All Crops"),
              ShiftingTab(icon: Icon(Icons.account_circle_outlined), text: "About"),
            ],
          ),
          body: TabBarView(
            children: <Widget>[
              MyHomePage(),
              AboutPage(),
              ProfileApp(),
              Expanded(
                flex: 1,
                child: isDesktop(context)
                    ? Desktop()
                    : isTablet(context)
                    ? Tablet()
                    : Mobile(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
