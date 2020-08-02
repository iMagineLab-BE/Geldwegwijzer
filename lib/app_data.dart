import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';

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
      return 5000;
    case Coin.n100Euro:
      return 10000;
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

int calculateIntegerCoinsValue(Map<String, int> coinMap) {
  int totalValue = 0;

  Coin.values.forEach((coin) {
    totalValue +=
        coinMap[describeEnum(coin)] * coinToValue(coin);
  });

  return totalValue;
}

var euroFormatter = NumberFormat.currency(symbol: "€", locale: "nl-BE");

Map<String, int> initMoneyMap() {
  Map<String, int> moneyMap = Map<String, int>();

  Coin.values.forEach((coin) {
    moneyMap[describeEnum(coin)] = 0;
  });

  return moneyMap;
}

class AppData {
  static final AppData _appData = new AppData._internal();
  static final LocalStorage storage = LocalStorage('appdata.json');

  Map<String, int> currentMoney = Map<String, int>();
  Map<String, int> splitMoney = Map<String, int>();
  Map<Coin, Image> images = Map<Coin, Image>();
  double toPay = 0;
  double splitMoneyTotal = 0;

  static void init() {
    _loadLocalStorage();

    _appData.splitMoney = initMoneyMap();
  }

  static void _loadLocalStorage() async {
    await storage.ready; // Waiting for the local storage is be ready
    Map<String, dynamic> moneyData = storage.getItem('money');

    if(moneyData == null) {
      print('Initialising local storage...');
      moneyData = initMoneyMap();

      storage.setItem('money', moneyData);
    }

    _appData.currentMoney = moneyData.cast<String, int>();
  }

  static void saveState() {
    storage.setItem('money', _appData.currentMoney);
  }

  void increaseCoin(Coin coin) {
    currentMoney[describeEnum(coin)]++;
    print("Coin type: ${describeEnum(coin)}, "
        "increased to amount: ${currentMoney[describeEnum(coin)]}");

    saveState();
  }

  void decreaseCoin(Coin coin) {
    if (currentMoney[describeEnum(coin)] == 0) {
      print("Coin type: ${describeEnum(coin)}, is already 0!");
      return;
    }
    currentMoney[describeEnum(coin)]--;
    print("Coin type: ${describeEnum(coin)}, "
        "decreased to amount: ${currentMoney[describeEnum(coin)]}");

    saveState();
  }

  factory AppData() {
    init();

    return _appData;
  }

  AppData._internal();
}

final appData = AppData();
