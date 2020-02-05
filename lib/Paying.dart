import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geldwegwijzer/AppData.dart';

class Paying extends StatefulWidget {
  const Paying();

  @override
  State<StatefulWidget> createState() => PayingState();
}

class PayingState extends State {
  var mode = true;

  @override
  Widget build(BuildContext context) {
    if (mode) {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              textAlign: TextAlign.center,
              keyboardType:
                  TextInputType.numberWithOptions(decimal: true, signed: false),
//              autofocus: true, // currently throws assertion, see https://github.com/flutter/flutter/pull/48922
              decoration: InputDecoration(hintText: "Vul hier de prijs in."),
              inputFormatters: <TextInputFormatter>[
                DecimalTextInputFormatter(decimalRange: 2)
              ],
            ),
            RaisedButton(
              onPressed: () {
                switchScreen();
              },
              textColor: Colors.white,
              color: Colors.blueAccent,
              padding: const EdgeInsets.all(0.0),
              child: const Text('Betalen', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      );
    } else {
      Map coins = appData.currentMoney;
      return Scaffold(
          body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 3,
        children: <Widget>[
          for (var i = 0; i < coins["5_cent"]; i++)
            Image(image: AssetImage('assets/euros/fivecents.png')),
          for (var i = 0; i < coins["10_cent"]; i++)
            Image(image: AssetImage('assets/euros/tencents.png')),
          for (var i = 0; i < coins["20_cent"]; i++)
            Image(image: AssetImage('assets/euros/twentycents.png')),
          for (var i = 0; i < coins["50_cent"]; i++)
            Image(image: AssetImage('assets/euros/fiftycents.png')),
          for (var i = 0; i < coins["1_euro"]; i++)
            Image(image: AssetImage('assets/euros/oneeuro.png')),
          for (var i = 0; i < coins["2_euro"]; i++)
            Image(image: AssetImage('assets/euros/twoeuros.png')),
          for (var i = 0; i < coins["5_euro"]; i++)
            Image(image: AssetImage('assets/euros/fiveeuros.png')),
          for (var i = 0; i < coins["10_euro"]; i++)
            Image(image: AssetImage('assets/euros/teneuros.png')),
          for (var i = 0; i < coins["20_euro"]; i++)
            Image(image: AssetImage('assets/euros/twentyeuros.png')),
          for (var i = 0; i < coins["50_euro"]; i++)
            Image(image: AssetImage('assets/euros/fiftyeuros.png')),
          for (var i = 0; i < coins["100_euro"]; i++)
            Image(image: AssetImage('assets/euros/hundredeuros.png')),
        ],
      ));
    }
  }

  void switchScreen() {
    setState(() {
      mode = !mode;
    });
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
