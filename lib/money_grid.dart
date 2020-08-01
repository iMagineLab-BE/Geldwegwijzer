import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geldwegwijzer/app_data.dart';
import 'package:geldwegwijzer/sizeconfig.dart';

class MoneyGrid extends StatefulWidget {
  const MoneyGrid();

  @override
  State<StatefulWidget> createState() => MoneyGridState();
}

class MoneyGridState extends State {
  Function(String) onSelectParam;

  List<Widget> getCoinsMenu() {
    var widgets = new List<Widget>();
    Coin.values.forEach((coin) {
      widgets.addAll([
        IconButton(
          icon: Icon(Icons.remove_circle_outline),
          iconSize: SizeConfig.blockSizeVertical * 8.0,
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
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: SizeConfig.blockSizeVertical * 5.0),
            )),
        Image(
          image: appData.images[coin].image,
          fit: BoxFit.fitWidth,
          // todo 1: use coins of the same resolution, some are blurry
          // todo 2: instant image loading, tip: precacheImage function
          // todo 2 (plan B: https://flutter.dev/docs/cookbook/images/fading-in-images)
        ),
        IconButton(
          icon: Icon(Icons.add_circle_outline),
          iconSize: SizeConfig.blockSizeVertical * 8.0,
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
