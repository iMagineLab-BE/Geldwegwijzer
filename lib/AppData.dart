import 'package:flutter/material.dart';

class AppData {
  static final AppData _appData = new AppData._internal();

  Map currentMoney;

  factory AppData() {
    return _appData;
  }
  AppData._internal();
}
final appData = AppData();