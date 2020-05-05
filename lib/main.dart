import 'package:flutter/material.dart';
import 'package:untitled1/Constant/Constant.dart';
import 'package:untitled1/Screens/AuthPage.dart';
import 'package:untitled1/Screens/HomePage.dart';
import 'package:untitled1/Screens/RegisterPage.dart';
import 'package:untitled1/Screens/SearchPage.dart';
import 'package:untitled1/Screens/SplashScreen.dart';
import 'package:untitled1/Screens/ProfilePage.dart';

main() => runApp(DocsApp());


class DocsApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Docs society',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.white,
          primaryColorDark: Colors.black38,
          backgroundColor: Colors.white,
      ),
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        //SPLASH_SCREEN: (BuildContext context) => new MapScreen(),
        PROFILE_PAGE: (BuildContext context) => ProfilePage(),
        SEARCH_PAGE: (BuildContext context) => SearchPage(),
        AUTH_PAGE: (BuildContext context) => AuthPage(),
        REG_PAGE: (BuildContext context) => RegisterPage(),
        HomePage.routeName: (BuildContext context) => HomePage()
      } ,
    );
  }
}