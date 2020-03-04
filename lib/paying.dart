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
  var mode = true;
  TextEditingController moneyController = new TextEditingController();

  List<Widget> getCoinsMenu() {
    var widgets = new List<Widget>();
    Coin.values.forEach((coin) {
      widgets.addAll([
        for (var i = 0; i < appData.currentMoney[describeEnum(coin)]; i++)
          Image(
            image: AssetImage('assets/euros/${describeEnum(coin)}.png'),
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
    if (mode) {
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
                switchScreen();
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
    } else {
      return Scaffold(
          body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 3,
        children: getCoinsMenu(),
      ));
    }
  }

  void switchScreen() {
    setState(() {
      mode = !mode;
    });
  }

  void pay() {
    var moneyInPocket = appData.currentMoney;
    var moneyToPay = moneyController.text;
    print('Money to pay: € $moneyToPay');
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
