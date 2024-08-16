import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geldwegwijzer/app/home_page.dart';

Future<void> ensureScreenSize() async {
  return MediaQueryData.fromView(WidgetsBinding.instance.platformDispatcher.views.first).size.width == 0
          ? Future.delayed(const Duration(milliseconds: 10), () => ensureScreenSize())
          : Future.value();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ensureScreenSize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    return MaterialApp(
      title: 'Geldwegwijzer',
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.green,
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
          ),
        ),
      ),
      home: const MyHomePage(title: 'Geldwegwijzer'),
    );
  }
}
