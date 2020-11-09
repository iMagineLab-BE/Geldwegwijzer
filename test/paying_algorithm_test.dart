import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geldwegwijzer/app_data.dart';
import 'package:geldwegwijzer/paying.dart';

void main() {
  group('Paying Algorithm', () {
    var payingState = PayingState();

    test('Test 1 - exact amount', () {
      var moneyInPocket =
          appData.currentMoney = initMoneyMap(); // cleanup method
      moneyInPocket[describeEnum(Coin.n1Euro)] = 3;
      moneyInPocket[describeEnum(Coin.n2Euro)] = 3;
      double moneyToPay = 5.00;
      print('Money to pay: ' + euroFormatter.format(moneyToPay));

      var splitMoney = payingState.calculate(moneyInPocket, moneyToPay);

      print('Total split money to pay: ' +
          euroFormatter.format(calculateIntegerCoinsValue(splitMoney) / 100));
      print('Total money in pocket left: ' +
          euroFormatter
              .format(calculateIntegerCoinsValue(moneyInPocket) / 100));

      expect(splitMoney[describeEnum(Coin.n1Euro)], 1); // ideal: 1
      expect(splitMoney[describeEnum(Coin.n2Euro)], 2); // ideal: 2

      expect(moneyInPocket[describeEnum(Coin.n1Euro)], 2); // ideal: 2
      expect(moneyInPocket[describeEnum(Coin.n2Euro)], 1); // ideal: 1
    });

    test('Test 2 - not exact amount', () {
      var moneyInPocket =
          appData.currentMoney = initMoneyMap(); // cleanup method
      moneyInPocket[describeEnum(Coin.n1Euro)] = 3;
      moneyInPocket[describeEnum(Coin.n2Euro)] = 3;
      double moneyToPay = 5.55;
      print('Money to pay: ' + euroFormatter.format(moneyToPay));

      var splitMoney = payingState.calculate(moneyInPocket, moneyToPay);

      print('Total split money to pay: ' +
          euroFormatter.format(calculateIntegerCoinsValue(splitMoney) / 100));
      print('Total money in pocket left: ' +
          euroFormatter
              .format(calculateIntegerCoinsValue(moneyInPocket) / 100));

      expect(splitMoney[describeEnum(Coin.n1Euro)], 0); // ideal: 0
      expect(splitMoney[describeEnum(Coin.n2Euro)], 3); // ideal: 3

      expect(moneyInPocket[describeEnum(Coin.n1Euro)], 3); // ideal: 3
      expect(moneyInPocket[describeEnum(Coin.n2Euro)], 0); // ideal: 0
    });

    test('Test 3 - not exact amount', () {
      var moneyInPocket =
          appData.currentMoney = initMoneyMap(); // cleanup method
      moneyInPocket[describeEnum(Coin.n2Euro)] = 1;
      moneyInPocket[describeEnum(Coin.n5Euro)] = 1;
      moneyInPocket[describeEnum(Coin.n100Euro)] = 1;
      double moneyToPay = 101.00;
      print('Money to pay: ' + euroFormatter.format(moneyToPay));

      var splitMoney = payingState.calculate(moneyInPocket, moneyToPay);

      print('Total split money to pay: ' +
          euroFormatter.format(calculateIntegerCoinsValue(splitMoney) / 100));
      print('Total money in pocket left: ' +
          euroFormatter
              .format(calculateIntegerCoinsValue(moneyInPocket) / 100));

      expect(splitMoney[describeEnum(Coin.n2Euro)], 1); // ideal: 1
      expect(splitMoney[describeEnum(Coin.n5Euro)], 0); // ideal: 0
      expect(splitMoney[describeEnum(Coin.n100Euro)], 1); // ideal: 1

      expect(moneyInPocket[describeEnum(Coin.n2Euro)], 0); // ideal: 0
      expect(moneyInPocket[describeEnum(Coin.n5Euro)], 1); // ideal: 1
      expect(moneyInPocket[describeEnum(Coin.n100Euro)], 0); // ideal: 0
    });

    test('Test 4 - not exact amount', () {
      var moneyInPocket =
          appData.currentMoney = initMoneyMap(); // cleanup method
      moneyInPocket[describeEnum(Coin.n2Euro)] = 1;
      moneyInPocket[describeEnum(Coin.n5Euro)] = 1;
      moneyInPocket[describeEnum(Coin.n100Euro)] = 2;
      double moneyToPay = 108.00;
      print('Money to pay: ' + euroFormatter.format(moneyToPay));

      var splitMoney = payingState.calculate(moneyInPocket, moneyToPay);

      print('Total split money to pay: ' +
          euroFormatter.format(calculateIntegerCoinsValue(splitMoney) / 100));
      print('Total money in pocket left: ' +
          euroFormatter
              .format(calculateIntegerCoinsValue(moneyInPocket) / 100));

      expect(splitMoney[describeEnum(Coin.n2Euro)], 0); // ideal: 0
      expect(splitMoney[describeEnum(Coin.n5Euro)], 0); // ideal: 0
      expect(splitMoney[describeEnum(Coin.n100Euro)], 2); // ideal: 2

      expect(moneyInPocket[describeEnum(Coin.n2Euro)], 1); // ideal: 1
      expect(moneyInPocket[describeEnum(Coin.n5Euro)], 1); // ideal: 1
      expect(moneyInPocket[describeEnum(Coin.n100Euro)], 0); // ideal: 0
    });
  });
}
