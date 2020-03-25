import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geldwegwijzer/app_data.dart';

class Paying extends StatefulWidget {
  const Paying();

  @override
  State<StatefulWidget> createState() => PayingState();
}

class PayingState extends State {
  // The mode parameter switches the screen to the next screen: input > pay > return
  var mode = 'input';
  TextEditingController moneyController = new TextEditingController();

  List<Widget> getCoinsMenu() {
    var widgets = new List<Widget>();
    Coin.values.forEach((coin) {
      widgets.addAll([
        for (var i = 0; i < appData.splitMoney[describeEnum(coin)]; i++)
          Image(
            image: appData.images[coin].image,
            fit: BoxFit.fitWidth,
          ),
      ]);
    });
    if (widgets.isEmpty) {
      widgets.add(
        Align(
            alignment: Alignment.center,
            child: Text(
              "Je moet niet betalen!",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            )),
      );
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    if (mode == 'input') {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Hoeveel moet je betalen?",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Center(
                child: Container(
                    width: 225,
                    child: TextField(
                      controller: moneyController,
                      textAlignVertical: TextAlignVertical.center,
                      style: TextStyle(fontSize: 20),
                      keyboardType: TextInputType.numberWithOptions(
                          decimal: true, signed: false),
//              autofocus: true, // currently throws assertion, see https://github.com/flutter/flutter/pull/48922
                      decoration:
                          InputDecoration(prefixIcon: Icon(Icons.euro_symbol)),
                      inputFormatters: <TextInputFormatter>[
                        DecimalTextInputFormatter(decimalRange: 2)
                      ],
                    ))),
            SizedBox(height: 20),
            MaterialButton(
              onPressed: () {
                pay();
              },
              textColor: Colors.white,
              color: Colors.green,
              padding: const EdgeInsets.all(0.0),
              child: const Text('Betalen', style: TextStyle(fontSize: 20)),
              minWidth: 225,
              height: 50,
            ),
          ],
        ),
      );
    } else if (mode == 'pay') {
      return Scaffold(
          body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Expanded(
          child: GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 3,
            children: getCoinsMenu(),
          ),
        ),
        MaterialButton(
          onPressed: () {
            switchScreen('return');
          },
          textColor: Colors.white,
          color: Colors.green,
          padding: const EdgeInsets.all(0.0),
          child: const Text('KLAAR', style: TextStyle(fontSize: 20)),
          minWidth: 225,
          height: 50,
        ),
      ]));
    } else if (mode == 'return') {
      return Scaffold(
          body: Column(children: <Widget>[
        Text('returning screen'),
      ]));
    }
  }

  void switchScreen(new_mode) {
    setState(() {
      mode = new_mode;
    });
  }

  void pay() {
    /*
    Paying algorithm
    ---------------------------------------
    Input:
      - int moneyToPay: amount in cents (e.g. €1.34 => 134)
      - Map currentMoney:  Map holding the amount of available coins
    Output:
      - Map coinsToPay: Map holding the amount of coins to pay

    Example in ideal case:
    Imagine you want to pay €46.99. You have: 5x2, 1x5, 2x10, 1x20, 2x50 euros.
    - First, convert to cents: 4699
    - Round to 5 cents: centsToPay = 4700
    - Find the highest coin you have that is smaller than centsToPay: 20€
    - Remove coin and update amount to pay: centsToPay -= 2000 --> 2700
    - Find the highest coin you have that is smaller than centsToPay: 10€
    - Remove coin and update amount to pay: centsToPay -= 1000 --> 1700
    - Find the highest coin you have that is smaller than centsToPay: 10€
    - Remove coin and update amount to pay: centsToPay -= 1000 --> 700
    - Find the highest coin you have that is smaller than centsToPay: 5€
    - Remove coin and update amount to pay: centsToPay -= 500 --> 200
    - Find the highest coin you have that is smaller than centsToPay: 2€
    - Remove coin and update amount to pay: centsToPay -= 200 --> 0
    - Display coins that were removed from the purse.

    Example in non-ideal case:
    Imagine you want to pay €46.99. You have: 1x5, 1x10, 1x20, 2x50 euros.
      - Convert to cents and round: 4700
      - Use 500 + 1000 + 2000 cents = 3500
      - There are 1200 cents left to pay, but there are no smaller coins left
      - Use the first higher coin: 50€
      - If the value of the higher coin exceeds the amount to pay (5000 > 4700),
        only use this coin.
    */

    // Check if the user entered a valid amount of money to pay
    if (moneyController.text == '') {
      showDialog(
          context: context,
          builder: (_) => new AlertDialog(
                title: new Text("Leeg veld"),
                content: new Text("Geef in hoeveel je moet betalen a.u.b."),
                actions: <Widget>[
                  FlatButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ));
    } else {
      // Start the paying algorithm
      var moneyInPocket = new Map<String, int>.from(appData.currentMoney);
      var moneyToPay = double.parse(moneyController.text.replaceAll(',', '.'));
      print('Money to pay: € $moneyToPay');
      appData.splitMoney = calculate(moneyInPocket, moneyToPay);
      if (appData.splitMoney != null) {
        print("-------------------");
        printMoney(appData.splitMoney);
        switchScreen('pay');
      }
    }
  }

  Map<String, int> calculate(
      Map<String, int> moneyInPocket, double moneyToPay) {
    var moneySplit = AppData.initMoney();
    int moneyToPayInCents = (moneyToPay * 100).truncate();
    int initialMoneyToPayInCents = moneyToPayInCents;
    int moneyInPocketInCents = 0;
    Coin.values.forEach((coin) {
      moneyInPocketInCents +=
          moneyInPocket[describeEnum(coin)] * coinToValue(coin);
    });

    if (moneyInPocketInCents < moneyToPayInCents) {
      print("Not enough money!");
      showNotEnoughMoney(moneyInPocketInCents);
      moneySplit = null;
    } else {
      while (moneyToPayInCents > 0) {
        bool stuck = true;
        for (Coin coin in Coin.values.reversed) {
          if (moneyInPocket[describeEnum(coin)] > 0 &&
              coinToValue(coin) <= moneyToPayInCents) {
            print(describeEnum(coin));
            print(moneySplit[describeEnum(coin)]);
            moneySplit[describeEnum(coin)]++;
            moneyInPocket[describeEnum(coin)]--;
            moneyToPayInCents -= coinToValue(coin);
            stuck = false;
            break;
          }
        }
        if (stuck) {
          moneyToPayInCents = (moneyToPay * 100).truncate();
          for (Coin coin in Coin.values) {
            if (moneyInPocket[describeEnum(coin)] > 0) {
              if (coinToValue(coin) > initialMoneyToPayInCents) {
                moneyInPocket = new Map.from(appData.currentMoney);
                moneySplit = AppData.initMoney();
                //print(describeEnum(coin));
                moneySplit[describeEnum(coin)]++;
                moneyInPocket[describeEnum(coin)]--;
                moneyToPayInCents =
                    initialMoneyToPayInCents - coinToValue(coin);
              } else {
                //print(describeEnum(coin));
                moneySplit[describeEnum(coin)]++;
                moneyInPocket[describeEnum(coin)]--;
                moneyToPayInCents -= coinToValue(coin);
              }
              appData.currentMoney = moneyInPocket;
              return moneySplit;
            }
          }
        }
      }
      appData.currentMoney = moneyInPocket;
    }
    return moneySplit;
  }

  showNotEnoughMoney(moneyInPocketInCents) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("Niet genoeg geld!"),
              content: new Text(
                  "Je hebt momenteel maar € ${moneyInPocketInCents / 100}.\nVoeg geld toe in de rechtse tab."),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }
}

class DecimalTextInputFormatter extends TextInputFormatter {
  DecimalTextInputFormatter({int decimalRange})
      : assert(decimalRange == null || decimalRange >= 0,
            'DecimalTextInputFormatter declaration error') {
    String dp = (decimalRange != null && decimalRange > 0)
        ? "([.|,][0-9]{0,$decimalRange}){0,1}"
        : "";
    String num = "[0-9]*$dp";
    _exp = new RegExp("^($num){0,1}\$");
  }

  RegExp _exp;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (_exp.hasMatch(newValue.text)) {
      return newValue;
    }
    return oldValue;
  }
}
