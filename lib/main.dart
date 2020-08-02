import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geldwegwijzer/app_data.dart';
import 'package:geldwegwijzer/money_grid.dart';
import 'package:geldwegwijzer/paying.dart';
import 'package:geldwegwijzer/sizeconfig.dart';
import 'package:geldwegwijzer/about_app.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Geldwegwijzer',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Geldwegwijzer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static TextStyle bottomStyle =
      TextStyle(fontSize: SizeConfig.blockSizeVertical * 2.0, fontWeight: FontWeight.normal);

  static const List<Widget> _widgetOptions = <Widget>[
    Paying(),
    MoneyGrid(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          child: Text(
            'Geldwegwijzer',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          fit: BoxFit.scaleDown
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.info),
            tooltip: 'Info',
            onPressed: () {
              openAboutApp(context);
            },
          )
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.payment, size: SizeConfig.blockSizeVertical * 4.0),
            title: Text('Betalen', style: bottomStyle),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.euro_symbol, size: SizeConfig.blockSizeVertical * 4.0),
            title: Text('Geld toevoegen', style: bottomStyle),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    for (Coin coin in Coin.values) {
      appData.images[coin] =
          Image.asset('assets/euros/${describeEnum(coin)}.png');
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    for (Image image in appData.images.values) {
      precacheImage(image.image, context);
    }
  }
}
