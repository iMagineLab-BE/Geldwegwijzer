import 'package:flutter/material.dart';
import 'package:geldwegwijzer/sizeconfig.dart';

class NumericKeyboard extends StatelessWidget {
  NumericKeyboard(this._editorController);

  final TextEditingController _editorController;

  void _addChar(Object value) {
    _editorController.text = _editorController.text + value.toString();
  }

  void _removeChar() {
    if(_editorController.text.length > 1) {
      _editorController.text = _editorController.text.substring(0, _editorController.text.length - 1);
    }
    else {
      _editorController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ConstrainedBox(
        constraints: BoxConstraints.tightForFinite(width: (SizeConfig.screenWidth <= 800 ? double.maxFinite : SizeConfig.blockSizeHorizontal * 80.0)),
        child: GridView.count(
          crossAxisCount: 3,
          physics: ScrollPhysics(),
          shrinkWrap: true,
          crossAxisSpacing: SizeConfig.blockSizeHorizontal * 0.5,
          mainAxisSpacing: SizeConfig.blockSizeVertical * 0.5,
          childAspectRatio: 2,
          children: <Widget>[
            KeyboardButton(1, _addChar),
            KeyboardButton(2, _addChar),
            KeyboardButton(3, _addChar),
            KeyboardButton(4, _addChar),
            KeyboardButton(5, _addChar),
            KeyboardButton(6, _addChar),
            KeyboardButton(7, _addChar),
            KeyboardButton(8, _addChar),
            KeyboardButton(9, _addChar),
            KeyboardButton(',', _addChar),
            KeyboardButton(0, _addChar),
            BackspaceButton(_removeChar),
          ],
        )
      ),
    );
  }
}

class BackspaceButton extends StatelessWidget {
  BackspaceButton(this.onPress);

  final onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(8.0),
        child: RaisedButton(
            onPressed: () {
              onPress();
            },
            child: Container(
                child: Icon(Icons.backspace, size: SizeConfig.blockSizeHorizontal * 8.0)
            ),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(SizeConfig.blockSizeHorizontal * 3.0),
            )
        )
    );
  }
}

class KeyboardButton extends StatelessWidget {
  KeyboardButton(this.value, this.onPress);

  final Object value;
  final onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical * 0.5, horizontal: SizeConfig.blockSizeHorizontal * 0.5),
      child: RaisedButton(
          onPressed: () {
            onPress(value);
          },
          color: Colors.green,
          child: Text(
            value.toString(),
            style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 10.0, color: Colors.white),
          ),
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SizeConfig.blockSizeHorizontal * 3.0),
          )
      )
    );
  }
}