import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geldwegwijzer/app_data.dart';

class MoneyGrid extends StatefulWidget {
  const MoneyGrid();

  @override
  State<StatefulWidget> createState() => MoneyGridState();
}

coinToValue(Coin coin) {
  switch (coin) {
    case Coin.n5Cent:
      return "5";
    case Coin.n10Cent:
      return "10";
    case Coin.n20Cent:
      return "20";
    case Coin.n50Cent:
      return "50";
    case Coin.n1Euro:
      return "100";
    case Coin.n2Euro:
      return "200";
    case Coin.n10Euro:
      return "1000";
    case Coin.n20Euro:
      return "2000";
    case Coin.n50Euro:
      return "50000";
    case Coin.n100Euro:
      return "100000";
    default:
      return "0";
  }
}

class MoneyGridState extends State {

  Function(String) onSelectParam;

  List<Widget> getCoinsMenu() {
    var widgets = new List<Widget>();
    Coin.values.forEach((coin) {
      widgets.addAll([
        IconButton(
          icon: Icon(Icons.remove_circle_outline),
          iconSize: 50,
          tooltip: 'Verwijder 1',
          onPressed: () {
            setState(() {
              appData.decreaseCoin(coin);
            });
          },
        ),
        Align(
            alignment: Alignment.center,
            child: Text(
              '${appData.currentMoney[describeEnum(coin)]} x ',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
            )),
        Image(
          image: AssetImage('assets/euros/${describeEnum(coin)}.png'),
          fit: BoxFit.fitWidth,
          // todo 1: use coins of the same resolution, some are blurry
          // todo 2: instant image loading, tip: precacheImage function
        ),
        IconButton(
          icon: Icon(Icons.add_circle_outline),
          iconSize: 50,
          tooltip: 'Voeg 1 toe',
          onPressed: () {
            setState(() {
              appData.increaseCoin(coin);
            });
          },
        )
      ]);
    });
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 4,
      children: getCoinsMenu(),
    ));
  }
}
