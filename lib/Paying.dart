import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Paying extends StatefulWidget {
  const Paying() : super();

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
              autofocus: true,
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
      return Scaffold(
          body: Center(
        child: Text('test'),
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
