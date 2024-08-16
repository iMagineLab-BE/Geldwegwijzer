import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geldwegwijzer/app/about_app.dart';
import 'package:geldwegwijzer/app/keyboard.dart';
import 'package:geldwegwijzer/model/app_data.dart';
import 'package:geldwegwijzer/model/sizeconfig.dart';

class Paying extends StatefulWidget {
  const Paying();

  @override
  State<StatefulWidget> createState() => PayingState();
}

class PayingState extends State {
  TextEditingController moneyController = TextEditingController();

  List<Widget> getCoinsMenu() {
    final List<Widget> widgets = [];
    for (final coin in Coin.values) {
      widgets.addAll([
        for (var i = 0; i < appData.splitMoney![coin.name]!; i++)
          Image(
            image: appData.images[coin]!.image,
            fit: BoxFit.fitWidth,
          ),
      ]);
    }
    if (widgets.isEmpty) {
      widgets.add(
        const Align(
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
        const Spacer(),
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
                  keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: false),
                  decoration: InputDecoration(prefixIcon: Icon(Icons.euro_symbol, size: SizeConfig.blockSizeVertical * 4)),
                )),
            SizedBox(height: SizeConfig.blockSizeVertical * 2.0),
            ElevatedButton(
              style: ButtonStyle(
                elevation: const WidgetStatePropertyAll(3),
                foregroundColor: const WidgetStatePropertyAll(Colors.white),
                backgroundColor: const WidgetStatePropertyAll(Colors.green),
                padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical * 2.0, horizontal: SizeConfig.blockSizeHorizontal * 4.0)),
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(SizeConfig.blockSizeVertical * 3),
                )),
              ),
              onPressed: () {
                pay();
              },
              child: Text('Betalen', style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 7)),
            ),
          ],
        ),
        const Spacer()
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
                  keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: false),
                  decoration: InputDecoration(prefixIcon: Icon(Icons.euro_symbol, size: SizeConfig.blockSizeVertical * 4)),
                )),
            SizedBox(width: SizeConfig.blockSizeHorizontal * 2.0),
            ElevatedButton(
              style: ButtonStyle(
                elevation: const WidgetStatePropertyAll(3),
                foregroundColor: const WidgetStatePropertyAll(Colors.white),
                backgroundColor: const WidgetStatePropertyAll(Colors.green),
                padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical * 2.0, horizontal: SizeConfig.blockSizeHorizontal * 4.0)),
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(SizeConfig.blockSizeVertical * 3),
                )),
              ),
              onPressed: () {
                pay();
              },
              child: Text('Betalen', style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 4)),
            ),
          ],
        ),
      ]);
    }
  }

  bool isLandscape() {
    return SizeConfig.screenWidth > SizeConfig.screenHeight;
  }

  @override
  Widget build(final BuildContext context) {
    if (isLandscape()) {
      return Scaffold(
          body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(),
            _amountFieldWidget(),
            const Spacer(),
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
            const Spacer(),
            _amountFieldWidget(),
            const Spacer(),
            NumericKeyboard(moneyController),
          ],
        ),
      ));
    }
  }

  void closeToPayScreen(final BuildContext context) {
    if (appData.toPay != appData.splitMoneyTotal) {
      final double changeMoney = appData.splitMoneyTotal - appData.toPay;
      showDialog(
          context: context,
          builder: (final _) => AlertDialog(
                title: Text("Wisselgeld", style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 5.0)),
                content: Text("Je moet ${euroFormatter.format(changeMoney)} terugkrijgen. Voeg de gekregen munten en biljetten in onder de tab 'Geld toevoegen'.", style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 3.0)),
                actions: <Widget>[
                  TextButton(
                    child: Text('Wisselgeld toevoegen', style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 3.0)),
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

    Navigator.push(context, MaterialPageRoute(builder: (final BuildContext context) {
      return Scaffold(
          appBar: AppBar(
            title: const FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'Geldwegwijzer',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                )),
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
              Text("Te betalen: ${euroFormatter.format(appData.toPay)}", style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 6.0)),
              const Divider(thickness: 2.0),
              Flexible(
                  child: Scrollbar(
                      child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: isLandscape() ? 5 : 3,
                childAspectRatio: 1,
                children: getCoinsMenu(),
              ))),
              const Divider(thickness: 2.0),
              ElevatedButton(
                style: ButtonStyle(
                  elevation: const MaterialStatePropertyAll(3),
                  foregroundColor: const MaterialStatePropertyAll(Colors.white),
                  backgroundColor: const MaterialStatePropertyAll(Colors.green),
                  padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical * 2.0, horizontal: SizeConfig.blockSizeHorizontal * 4.0)),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(SizeConfig.blockSizeVertical * 3),
                  )),
                ),
                onPressed: () {
                  closeToPayScreen(context);
                },
                child: Text('Betaling voltooid', style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 4)),
              ),
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
          builder: (final _) => AlertDialog(
                title: Text("Veld is leeg", style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 5.0)),
                content: Text("Toets het te betalen bedrag in het veld.", style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 3.0)),
                actions: <Widget>[
                  TextButton(
                    child: Text('Sluiten', style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 3.0)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ));
    } else {
      // Start the paying algorithm
      final moneyInPocket = Map<String, int>.from(appData.currentMoney);

      try {
        final moneyToPay = double.parse(moneyController.text.replaceAll(',', '.'));
        if (kDebugMode) {
          print('Money to pay: ${euroFormatter.format(moneyToPay)}');
        }
        appData.splitMoney = calculate2(moneyInPocket, moneyToPay);

        // todo sdc issue here, splitmoney opt
        if (appData.splitMoney != null || appData.splitMoney!.isNotEmpty) {
          appData.toPay = moneyToPay;
          appData.splitMoneyTotal = calculateIntegerCoinsValue(appData.splitMoney!) / 100;
          if (kDebugMode) {
            print("-------------------");
            printMoney(appData.splitMoney!);
          }

          openToPayScreen();
        }
      } on FormatException catch (e) {
        showDialog(
            context: context,
            builder: (final _) => AlertDialog(
                  title: Text("Ongeldige waarde", style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 5.0)),
                  content: Text("Het bedrag in het veld is niet geldig!\nControleer dat er geen meerdere komma's in het bedrag voorkomen en probeer opnieuw.", style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 3.0)),
                  actions: <Widget>[
                    TextButton(
                      child: Text('Sluiten', style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 3.0)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ));
      }
    }
  }

  Map<String, int>? calculate(final Map<String, int> moneyInPocket, final double moneyToPay) {
    final int moneyToPayInCents = (moneyToPay * 100).truncate();
    final int moneyInPocketInCents = calculateIntegerCoinsValue(moneyInPocket);

    if (moneyInPocketInCents < moneyToPayInCents) {
      if (kDebugMode) {
        print("Not enough money!");
      }
      showNotEnoughMoney(moneyInPocketInCents);
      return null;
    }

    final bills = <int>[];
    // add largest bills first
    for (final coin in Coin.values.reversed) {
      final amountPerCoin = moneyInPocket[coin.name];
      if (amountPerCoin != 0) {
        for (int i = 0; i < amountPerCoin!; i++) {
          bills.add(coinToValue(coin));
        }
      }
    }
    final bestSub = coverAmount(moneyToPayInCents, bills, null);
    final moneySplit = initMoneyMap();
    for (final bill in bestSub) {
      final coin = valueToCoin(bill);
      moneySplit.update(coin.name, (final value) => value + 1);
      moneyInPocket.update(coin.name, (final value) => value - 1);
        }
    appData.currentMoney = moneyInPocket;
    AppData.saveState();
    return moneySplit;
  }

  // Source algo: https://stackoverflow.com/questions/37326105/find-the-optimal-bills-combination-to-pay-for-a-specific-value
  List<int> coverAmount(final int amount, final List<int> bills, Set<int>? used) {
    if (used == null || used.isEmpty) {
      used = <int>{};
    }
    if (amount <= 0) {
      return <int>[];
    }

    final List<MapEntry<List<int>, int>> overages = [];
    for (int i = 0; i < bills.length; i++) {
      final bill = bills[i];
      if (used.contains(i)) {
        continue;
      }

      if (bill > amount) {
        overages.add(MapEntry([bill], bill - amount));
      } else if (bill == amount) {
        return [bill];
      } else {
        used.add(i);
        final bestSub = coverAmount(amount - bill, bills, used);
        used.remove(i);
        bestSub.add(bill);
        final sum = bestSub.reduce((final a, final b) => a + b); // sum of
        if (sum == amount) {
          return bestSub;
        }
        if (sum > amount) {
          overages.add(MapEntry(bestSub, sum - amount));
        }
      }
    }

    if (overages.isEmpty) {
      return <int>[];
    }

    // sort on least amount of bills
    overages.sort((a, b) => customCompareTo(a, b));
    // if overage is less than half of the amount, take that one
    for (final MapEntry<List<int>, int> element in overages) {
      if (element.value <= amount / 2) {
        return element.key;
      }
    }
    return overages.first.key; // take the one with least amount of bills
    //
  }

  // Least amount of bills put first. If equal, least overage.
  int customCompareTo(final MapEntry<List, int> a, final MapEntry<List, int> b) {
    var compareTo = a.key.length.compareTo(b.key.length);
    if (compareTo == 0) {
      compareTo = a.value.compareTo(b.value);
    }
    return compareTo;
  }

  // Old / Original algo
  Map<String, int>? calculate2(Map<String, int> moneyInPocket, final double moneyToPay) {
    Map<String, int>? moneySplit = initMoneyMap();
    int moneyToPayInCents = (moneyToPay * 100).truncate();
    final int initialMoneyToPayInCents = moneyToPayInCents;
    final int moneyInPocketInCents = calculateIntegerCoinsValue(moneyInPocket);

    if (moneyInPocketInCents < moneyToPayInCents) {
      if (kDebugMode) {
        print("Not enough money!");
      }
      showNotEnoughMoney(moneyInPocketInCents);
      moneySplit = null;
    } else {
      while (moneyToPayInCents > 0) {
        bool stuck = true;
        for (final Coin coin in Coin.values.reversed) {
          if (moneyInPocket[coin.name]! > 0 && coinToValue(coin) <= moneyToPayInCents) {
            //print(describeEnum(coin));
            //print(moneySplit[describeEnum(coin)]);
            moneySplit?.update(coin.name, (final value) => value + 1);
            moneyInPocket.update(coin.name, (final value) => value - 1);
            moneyToPayInCents -= coinToValue(coin);
            stuck = false;
            break;
          }
        }
        if (stuck) {
          moneyToPayInCents = (moneyToPay * 100).truncate();
          for (final Coin coin in Coin.values) {
            if (moneyInPocket[coin.name]! > 0) {
              if (coinToValue(coin) > initialMoneyToPayInCents) {
                moneyInPocket = Map.from(appData.currentMoney);
                moneySplit = initMoneyMap();
                //print(describeEnum(coin));
                moneySplit.update(coin.name, (final value) => value + 1);
                moneyInPocket.update(coin.name, (final value) => value - 1);
                moneyToPayInCents = initialMoneyToPayInCents - coinToValue(coin);
              } else {
                //print(describeEnum(coin));
                moneySplit?.update(coin.name, (final value) => value + 1);
                moneyInPocket.update(coin.name, (final value) => value - 1);
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

  showNotEnoughMoney(final moneyInPocketInCents) {
    showDialog(
        context: context,
        builder: (final _) => AlertDialog(
              title: Text("Niet genoeg geld!", style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 5.0)),
              content: Text("Je hebt momenteel: ${euroFormatter.format(moneyInPocketInCents / 100)}\nVoeg geld toe in de tab: 'Geld toevoegen'.", style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 3.0)),
              actions: <Widget>[
                TextButton(
                  child: Text('Sluiten', style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 3.0)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }
}
