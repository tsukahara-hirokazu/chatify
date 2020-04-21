import 'package:chatify/pages/login_page.dart';
import 'package:chatify/pages/registration_page.dart';
import 'package:chatify/services/navigation_service.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Chatify",
      navigatorKey: NavigationService.instance.navigatorKey,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color.fromRGBO(42, 117, 188, 1),
        accentColor: Color.fromRGBO(42, 117, 188, 1),
        backgroundColor: Color.fromRGBO(28, 27, 27, 1),
      ),
      initialRoute: "login",
      routes: {
        "login": (BuildContext context) => LoginPage(),
        "register": (BuildContext context) => RegistrationPage(),
      },
    );
  }
}
