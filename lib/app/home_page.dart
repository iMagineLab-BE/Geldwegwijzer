import 'package:flutter/material.dart';
import 'package:geldwegwijzer/app/about_app.dart';
import 'package:geldwegwijzer/model/app_data.dart';
import 'package:geldwegwijzer/app/money_grid.dart';
import 'package:geldwegwijzer/app/paying.dart';
import 'package:geldwegwijzer/model/sizeconfig.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({required this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Paying(),
    MoneyGrid(),
  ];

  void _onItemTapped(final int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Geldwegwijzer',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            )),
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
            label: 'Betalen',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.euro_symbol, size: SizeConfig.blockSizeVertical * 4.0),
            label: 'Geld toevoegen',
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

    for (final Coin coin in Coin.values) {
      appData.images[coin] = Image.asset('assets/euros/${coin.name}.png');
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    for (final Image image in appData.images.values) {
      precacheImage(image.image, context);
    }
  }
}
