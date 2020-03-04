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

int coinToValue(Coin coin) {
  switch (coin) {
    case Coin.n5Cent:
      return 5;
    case Coin.n10Cent:
      return 10;
    case Coin.n20Cent:
      return 20;
    case Coin.n50Cent:
      return 50;
    case Coin.n1Euro:
      return 100;
    case Coin.n2Euro:
      return 200;
    case Coin.n5Euro:
      return 500;
    case Coin.n10Euro:
      return 1000;
    case Coin.n20Euro:
      return 2000;
    case Coin.n50Euro:
      return 50000;
    case Coin.n100Euro:
      return 100000;
    default:
      return 0;
  }
}

void printMoney(Map money) {
  print("MONEY OVERVIEW:");
  money.forEach((key, value) {
    print("$value x $key");
  });
}

class AppData {
  static final AppData _appData = new AppData._internal();

  Map<String, int> currentMoney = initMoney();
  Map<String, int> splitMoney = initMoney();

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

  factory AppData() {
    return _appData;
  }
  AppData._internal();
}

final appData = AppData();
