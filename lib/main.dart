import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geldwegwijzer/app/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Geldwegwijzer',
      theme: ThemeData(
        primarySwatch: Colors.green,
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
          ),
        ),
      ),
      home: MyHomePage(title: 'Geldwegwijzer'),
    );
  }
}
