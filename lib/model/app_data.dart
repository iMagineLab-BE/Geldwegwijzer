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

int coinToValue(final Coin coin) {
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

Coin valueToCoin(final int value) {
  switch (value) {
    case 5:
      return Coin.n5Cent;
    case 10:
      return Coin.n10Cent;
    case 20:
      return Coin.n20Cent;
    case 50:
      return Coin.n50Cent;
    case 100:
      return Coin.n1Euro;
    case 200:
      return Coin.n2Euro;
    case 500:
      return Coin.n5Euro;
    case 1000:
      return Coin.n10Euro;
    case 2000:
      return Coin.n20Euro;
    case 5000:
      return Coin.n50Euro;
    case 10000:
      return Coin.n100Euro;
    default:
      throw Exception("Invalid value");
  }
}

void printMoney(final Map money) {
  print("MONEY OVERVIEW:");
  money.forEach((final key, final value) {
    print("$value x $key");
  });
}

int calculateIntegerCoinsValue(final Map<String, int> coinMap) {
  int totalValue = 0;

  for (final coin in Coin.values) {
    totalValue += (coinMap[coin.name]! * coinToValue(coin));
  }

  return totalValue;
}

var euroFormatter = NumberFormat.currency(symbol: "€", locale: "nl-BE");

Map<String, int> initMoneyMap() {
  final Map<String, int> moneyMap = <String, int>{};

  for (final coin in Coin.values) {
    moneyMap[coin.name] = 0;
  }

  return moneyMap;
}

class AppData {
  factory AppData() {
    init();

    return _appData;
  }

  AppData._internal();
  static final AppData _appData = AppData._internal();
  static final LocalStorage storage = LocalStorage('appdata.json');

  Map<String, int> currentMoney = <String, int>{};
  Map<String, int>? splitMoney = <String, int>{};
  Map<Coin, Image> images = <Coin, Image>{};
  double toPay = 0;
  double splitMoneyTotal = 0;

  static void init() {
    _loadLocalStorage();

    _appData.splitMoney = initMoneyMap();
  }

  static void _loadLocalStorage() async {
    await storage.ready; // Waiting for the local storage is be ready
    Map<String, dynamic>? moneyData = storage.getItem('money');

    if (moneyData == null || moneyData.isEmpty) {
      if (kDebugMode) {
        print('Initialising local storage...');
      }
      moneyData = initMoneyMap();

      storage.setItem('money', moneyData);
    }

    _appData.currentMoney = moneyData.cast<String, int>();
  }

  static void saveState() {
    storage.setItem('money', _appData.currentMoney);
  }

  void increaseCoin(final Coin coin) {
    currentMoney.update(coin.name, (final value) => value + 1);
    if (kDebugMode) {
      print("Coin type: ${coin.name}, "
        "increased to amount: ${currentMoney[coin.name]}");
    }

    saveState();
  }

  void decreaseCoin(final Coin coin) {
    if (currentMoney[coin.name] == 0) {
      if (kDebugMode) {
        print("Coin type: ${coin.name}, is already 0!");
      }
      return;
    }
    currentMoney.update(coin.name, (final value) => value - 1);
    if (kDebugMode) {
      print("Coin type: ${coin.name}, "
        "decreased to amount: ${currentMoney[coin.name]}");
    }

    saveState();
  }
}

final appData = AppData();
