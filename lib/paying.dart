import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geldwegwijzer/about_app.dart';
import 'package:geldwegwijzer/app_data.dart';
import 'package:geldwegwijzer/keyboard.dart';
import 'package:geldwegwijzer/sizeconfig.dart';

class Paying extends StatefulWidget {
  const Paying();

  @override
  State<StatefulWidget> createState() => PayingState();
}

class PayingState extends State {
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

  Widget _amountFieldWidget() {
    if (isLandscape()) {
      return Column(children: <Widget>[
        Spacer(),
        Text(
          "Hoeveel moet je betalen?",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 4),
        ),
        SizedBox(height: SizeConfig.blockSizeVertical * 2.0),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                width: SizeConfig.blockSizeHorizontal * 40,
                child: TextField(
                  readOnly: true,
                  controller: moneyController,
                  textAlignVertical: TextAlignVertical.center,
                  style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 4),
                  keyboardType: TextInputType.numberWithOptions(
                      decimal: true, signed: false),
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.euro_symbol,
                          size: SizeConfig.blockSizeVertical * 4)),
                )),
            SizedBox(height: SizeConfig.blockSizeVertical * 2.0),
            RaisedButton(
                onPressed: () {
                  pay();
                },
                textColor: Colors.white,
                color: Colors.green,
                padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.blockSizeVertical * 2.0,
                    horizontal: SizeConfig.blockSizeHorizontal * 4.0),
                child: Text('Betalen',
                    style:
                        TextStyle(fontSize: SizeConfig.blockSizeVertical * 7)),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(SizeConfig.blockSizeVertical * 3),
                )),
          ],
        ),
        Spacer()
      ]);
    } else {
      return Column(children: <Widget>[
        Text(
          "Hoeveel moet je betalen?",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 4),
        ),
        SizedBox(height: SizeConfig.blockSizeVertical * 2.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                width: SizeConfig.blockSizeHorizontal * 50,
                child: TextField(
                  readOnly: true,
                  controller: moneyController,
                  textAlignVertical: TextAlignVertical.center,
                  style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 4),
                  keyboardType: TextInputType.numberWithOptions(
                      decimal: true, signed: false),
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.euro_symbol,
                          size: SizeConfig.blockSizeVertical * 4)),
                )),
            SizedBox(width: SizeConfig.blockSizeHorizontal * 2.0),
            RaisedButton(
                onPressed: () {
                  pay();
                },
                textColor: Colors.white,
                color: Colors.green,
                padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.blockSizeVertical * 2.0,
                    horizontal: SizeConfig.blockSizeHorizontal * 4.0),
                child: Text('Betalen',
                    style:
                        TextStyle(fontSize: SizeConfig.blockSizeVertical * 4)),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(SizeConfig.blockSizeVertical * 3),
                )),
          ],
        ),
      ]);
    }
  }

  bool isLandscape() {
    return SizeConfig.screenWidth > SizeConfig.screenHeight;
  }

  @override
  Widget build(BuildContext context) {
    if (isLandscape()) {
      return Scaffold(
          body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            _amountFieldWidget(),
            Spacer(),
            NumericKeyboard(moneyController),
          ],
        ),
      ));
    } else {
      return Scaffold(
          body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Spacer(),
            _amountFieldWidget(),
            Spacer(),
            NumericKeyboard(moneyController),
          ],
        ),
      ));
    }
  }

  void closeToPayScreen(BuildContext context) {
    if (appData.toPay != appData.splitMoneyTotal) {
      double changeMoney = appData.splitMoneyTotal - appData.toPay;
      showDialog(
          context: context,
          builder: (_) => new AlertDialog(
                title: Text("Wisselgeld",
                    style: TextStyle(
                        fontSize: SizeConfig.blockSizeVertical * 5.0)),
                content: Text(
                    "Je moet " +
                        euroFormatter.format(changeMoney) +
                        " terugkrijgen. Voeg de gekregen munten en biljetten in onder de tab 'Geld toevoegen'.",
                    style: TextStyle(
                        fontSize: SizeConfig.blockSizeVertical * 3.0)),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Wisselgeld toevoegen',
                        style: TextStyle(
                            fontSize: SizeConfig.blockSizeVertical * 3.0)),
                    onPressed: () {
                      Navigator.of(context).pop(); //Close popup
                      Navigator.pop(context); //Close to pay screen
                    },
                  )
                ],
              ));
    } else {
      Navigator.pop(context);
    }
  }

  void openToPayScreen() {
    moneyController.clear();

    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return Scaffold(
          appBar: AppBar(
            title: FittedBox(
                child: Text(
                  'Geldwegwijzer',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                fit: BoxFit.scaleDown),
            automaticallyImplyLeading: false,
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
          body: Column(
            children: <Widget>[
              SizedBox(height: SizeConfig.blockSizeVertical * 0.3),
              Text("Te betalen: " + euroFormatter.format(appData.toPay),
                  style:
                      TextStyle(fontSize: SizeConfig.blockSizeVertical * 6.0)),
              Divider(thickness: 2.0),
              Flexible(
                  child: Scrollbar(
                      child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: isLandscape() ? 5 : 3,
                children: getCoinsMenu(),
                childAspectRatio: 1,
              ))),
              Divider(thickness: 2.0),
              RaisedButton(
                  onPressed: () {
                    closeToPayScreen(context);
                  },
                  textColor: Colors.white,
                  color: Colors.green,
                  padding: EdgeInsets.symmetric(
                      vertical: SizeConfig.blockSizeVertical * 2.0,
                      horizontal: SizeConfig.blockSizeHorizontal * 4.0),
                  child: Text('Betaling voltooid',
                      style: TextStyle(
                          fontSize: SizeConfig.blockSizeVertical * 4)),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(SizeConfig.blockSizeVertical * 3),
                  )),
              SizedBox(height: SizeConfig.blockSizeVertical * 1),
            ],
          ));
    }));
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
                title: Text("Veld is leeg",
                    style: TextStyle(
                        fontSize: SizeConfig.blockSizeVertical * 5.0)),
                content: Text("Toets het te betalen bedrag in het veld.",
                    style: TextStyle(
                        fontSize: SizeConfig.blockSizeVertical * 3.0)),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Sluiten',
                        style: TextStyle(
                            fontSize: SizeConfig.blockSizeVertical * 3.0)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ));
    } else {
      // Start the paying algorithm
      var moneyInPocket = new Map<String, int>.from(appData.currentMoney);

      try {
        var moneyToPay =
            double.parse(moneyController.text.replaceAll(',', '.'));
        print('Money to pay: ' + euroFormatter.format(moneyToPay));
        appData.splitMoney = calculate(moneyInPocket, moneyToPay);

        if (appData.splitMoney != null) {
          appData.toPay = moneyToPay;
          appData.splitMoneyTotal =
              calculateIntegerCoinsValue(appData.splitMoney) / 100;
          print("-------------------");
          printMoney(appData.splitMoney);
          openToPayScreen();
        }
      } on FormatException catch (e) {
        showDialog(
            context: context,
            builder: (_) => new AlertDialog(
                  title: Text("Ongeldige waarde",
                      style: TextStyle(
                          fontSize: SizeConfig.blockSizeVertical * 5.0)),
                  content: Text(
                      "Het bedrag in het veld is niet geldig!\nControleer dat er geen meerdere komma's in het bedrag voorkomen en probeer opnieuw.",
                      style: TextStyle(
                          fontSize: SizeConfig.blockSizeVertical * 3.0)),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Sluiten',
                          style: TextStyle(
                              fontSize: SizeConfig.blockSizeVertical * 3.0)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ));
      }
    }
  }

  Map<String, int> calculate(
      Map<String, int> moneyInPocket, double moneyToPay) {
    var moneySplit = initMoneyMap();
    int moneyToPayInCents = (moneyToPay * 100).truncate();
    int initialMoneyToPayInCents = moneyToPayInCents;
    int moneyInPocketInCents = calculateIntegerCoinsValue(moneyInPocket);

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
            //print(describeEnum(coin));
            //print(moneySplit[describeEnum(coin)]);
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
                moneySplit = initMoneyMap();
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
              AppData.saveState();
              return moneySplit;
            }
          }
        }
      }
      appData.currentMoney = moneyInPocket;
      AppData.saveState();
    }
    return moneySplit;
  }

  showNotEnoughMoney(moneyInPocketInCents) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("Niet genoeg geld!",
                  style:
                      TextStyle(fontSize: SizeConfig.blockSizeVertical * 5.0)),
              content: new Text(
                  "Je hebt momenteel: " +
                      euroFormatter.format(moneyInPocketInCents / 100) +
                      "\nVoeg geld toe in de tab: 'Geld toevoegen'.",
                  style:
                      TextStyle(fontSize: SizeConfig.blockSizeVertical * 3.0)),
              actions: <Widget>[
                FlatButton(
                  child: Text('Sluiten',
                      style: TextStyle(
                          fontSize: SizeConfig.blockSizeVertical * 3.0)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }
}
