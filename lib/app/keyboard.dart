import 'package:flutter/material.dart';
import 'package:geldwegwijzer/model/sizeconfig.dart';

class NumericKeyboard extends StatelessWidget {
  const NumericKeyboard(this._editorController);

  final TextEditingController _editorController;

  void _addChar(final Object value) {
    _editorController.text = _validateChar(_editorController.text, _editorController.text + value.toString());
  }

  void _removeChar() {
    if (_editorController.text.length > 1) {
      _editorController.text = _editorController.text.substring(0, _editorController.text.length - 1);
    } else {
      _editorController.clear();
    }
  }

  String _validateChar(final String oldText, final String newText) {
    const String num = "[0-9]{0,3}([.|,][0-9]{0,2}){0,1}";
    final RegExp _exp = RegExp("^($num){0,1}\$");
    if (_exp.hasMatch(newText)) {
      return newText;
    }
    return oldText;
  }

  bool _isHorizontal() {
    return SizeConfig.screenWidth > SizeConfig.screenHeight;
  }

  @override
  Widget build(final BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints.tightForFinite(width: _isHorizontal() ? SizeConfig.screenWidth * 0.55 : (SizeConfig.screenWidth <= 800 ? double.maxFinite : SizeConfig.blockSizeHorizontal * 80.0)),
        child: GridView.count(
          crossAxisCount: 3,
          physics: const ScrollPhysics(),
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
        ));
  }
}

class BackspaceButton extends StatelessWidget {
  const BackspaceButton(this.onPress);

  final onPress;

  bool isHorizontal() {
    return SizeConfig.screenWidth > SizeConfig.screenHeight;
  }

  @override
  Widget build(final BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical * 0.5, horizontal: SizeConfig.blockSizeHorizontal * 0.5),
        child: ElevatedButton(
          style: ButtonStyle(
            elevation: const MaterialStatePropertyAll(3),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(isHorizontal() ? SizeConfig.blockSizeHorizontal * 2.0 : SizeConfig.blockSizeHorizontal * 3.0),
            )),
          ),
          onPressed: () {
            onPress();
          },
          child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Padding(
                padding: EdgeInsets.all(isHorizontal() ? SizeConfig.blockSizeVertical * 15.0 : SizeConfig.blockSizeHorizontal * 10.0),
                child: Icon(Icons.backspace, size: SizeConfig.blockSizeHorizontal * 100),
              )),
        ));
  }
}

class KeyboardButton extends StatelessWidget {
  const KeyboardButton(this.value, this.onPress);

  final Object value;
  final onPress;

  bool isHorizontal() {
    return SizeConfig.screenWidth > SizeConfig.screenHeight;
  }

  @override
  Widget build(final BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical * 0.5, horizontal: SizeConfig.blockSizeHorizontal * 0.5),
        child: ElevatedButton(
          style: ButtonStyle(
            elevation: const WidgetStatePropertyAll(3),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(isHorizontal() ? SizeConfig.blockSizeHorizontal * 2.0 : SizeConfig.blockSizeHorizontal * 3.0),
            )),
            backgroundColor: const MaterialStatePropertyAll(Colors.green),
          ),
          onPressed: () {
            onPress(value);
          },
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value.toString(),
              style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 100, color: Colors.white),
            ),
          ),
        ));
  }
}
