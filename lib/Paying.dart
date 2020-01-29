import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PayingInput extends StatelessWidget {
  const PayingInput() : super();

  @override
  Widget build(BuildContext context) {
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
              _goToPayingOutput(context);
            },
            textColor: Colors.white,
            color: Colors.blueAccent,
            padding: const EdgeInsets.all(0.0),
            child: const Text('Betalen', style: TextStyle(fontSize: 20)),
          ),
        ],
      ),
    );
  }

  Future _goToPayingOutput(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => PayingOutput()));
  }
}

class PayingOutput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Geldwegwijzer'),
        ),
        body: Center(
          child: Text('test'),
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
