import 'package:flutter/foundation.dart';

enum Coin {
  n5Cent,
  n10Cent,
  n20Cent,
  n50Cent,
  n1Euro,
  n2Euro,
  n5Euro,
  n10Euro,
  n20Euro,
  n50Euro,
  n100Euro,
}

class AppData {
  static final AppData _appData = new AppData._internal();

  Map currentMoney = initMoney();

  static Map<String, int> initMoney() {
    var money = new Map<String, int>();
    Coin.values.forEach((coin) {
      money[describeEnum(coin)] = 0;
    });
    return money;
  }

  void increaseCoin(Coin coin) {
    currentMoney[describeEnum(coin)]++;
    print("Coin type: ${describeEnum(coin)}, "
        "increased to amount: ${currentMoney[describeEnum(coin)]}");
  }

  void decreaseCoin(Coin coin) {
    if (currentMoney[describeEnum(coin)] == 0) {
      print("Coin type: ${describeEnum(coin)}, is already 0!");
      return;
    }
    currentMoney[describeEnum(coin)]--;
    print("Coin type: ${describeEnum(coin)}, "
        "decreased to amount: ${currentMoney[describeEnum(coin)]}");
  }

  void printCurrentMoney() {
    print("CURRENT MONEY:");
    currentMoney.forEach((key, value) {
      print("$value x $key");
    });
  }

  factory AppData() {
    return _appData;
  }
  AppData._internal();
}

final appData = AppData();
