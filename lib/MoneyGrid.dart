import 'package:flutter/material.dart';

int n_1_cent = 0;
int n_2_cent = 0;
int n_5_cent = 0;
int n_10_cent = 0;
int n_20_cent = 0;
int n_50_cent = 0;
int n_1_euro = 0;
int n_2_euro = 0;
int n_5_euro = 0;
int n_10_euro = 0;
int n_20_euro = 0;
int n_50_euro = 0;
int n_100_euro = 0;


class MoneyGrid extends StatelessWidget {

  const MoneyGrid() :
        super();

  void printCurrentMoney(){
    print("CURRENT MONEY:");
    print("${n_1_cent} x 1 cent");
    print("${n_2_cent} x 2 cent");
    print("${n_5_cent} x 5 cent");
    print("${n_10_cent} x 10 cent");
    print("${n_20_cent} x 20 cent");
    print("${n_50_cent} x 20 cent");
    print("${n_1_euro} x 10 euro");
    print("${n_2_euro} x 2 euro");
    print("${n_5_euro} x 5 euro");
    print("${n_10_euro} x 10 euro");
    print("${n_20_euro} x 20 euro");
    print("${n_50_euro} x 50 euro");
    print("${n_100_euro} x 100 euro");
    print("");
  }

  Map getCurrentMoney() {
    var money = new Map<String, int>();
    money["1_cent"] = n_1_cent;
    money["2_cent"] = n_2_cent;
    money["5_cent"] = n_5_cent;
    money["10_cent"] = n_10_cent;
    money["20_cent"] = n_20_cent;
    money["50_cent"] = n_50_cent;
    money["1_euro"] = n_1_euro;
    money["2_euro"] = n_2_euro;
    money["5_euro"] = n_5_euro;
    money["10_euro"] = n_10_euro;
    money["20_euro"] = n_20_euro;
    money["50_euro"] = n_50_euro;
    money["100_euro"] = n_100_euro;

    return money;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 3,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.remove_circle_outline),
              tooltip: 'Verwijder 1',
              onPressed: () {
                  n_1_cent--;
                  printCurrentMoney();
              },
            ),
            Image(image: AssetImage('assets/euros/onecent.png')),
            IconButton(
              icon: Icon(Icons.add_circle_outline),
              tooltip: 'Voeg 1 toe',
              onPressed: () {
                n_1_cent++;
                printCurrentMoney();
              },
            ),
            IconButton(
              icon: Icon(Icons.remove_circle_outline),
              tooltip: 'Verwijder 1',
              onPressed: () {
                n_2_cent--;
                printCurrentMoney();
              },
            ),
            Image(image: AssetImage('assets/euros/twocents.png')),
            IconButton(
              icon: Icon(Icons.add_circle_outline),
              tooltip: 'Voeg 1 toe',
              onPressed: () {
                n_2_cent++;
                printCurrentMoney();
              },
            ),
            IconButton(
              icon: Icon(Icons.remove_circle_outline),
              tooltip: 'Verwijder 1',
              onPressed: () {
                n_5_cent--;
                printCurrentMoney();
              },
            ),
            Image(image: AssetImage('assets/euros/fivecents.png')),
            IconButton(
              icon: Icon(Icons.add_circle_outline),
              tooltip: 'Voeg 1 toe',
              onPressed: () {
                n_5_cent++;
                printCurrentMoney();
              },
            ),
            IconButton(
              icon: Icon(Icons.remove_circle_outline),
              tooltip: 'Verwijder 1',
              onPressed: () {
                n_10_cent--;
                printCurrentMoney();
              },
            ),
            Image(image: AssetImage('assets/euros/tencents.png')),
            IconButton(
              icon: Icon(Icons.add_circle_outline),
              tooltip: 'Voeg 1 toe',
              onPressed: () {
                n_10_cent++;
                printCurrentMoney();
              },
            ),
            IconButton(
              icon: Icon(Icons.remove_circle_outline),
              tooltip: 'Verwijder 1',
              onPressed: () {
                n_20_cent--;
                printCurrentMoney();
              },
            ),
            Image(image: AssetImage('assets/euros/twentycents.png')),
            IconButton(
              icon: Icon(Icons.add_circle_outline),
              tooltip: 'Voeg 1 toe',
              onPressed: () {
                n_20_cent++;
                printCurrentMoney();
              },
            ),
            IconButton(
              icon: Icon(Icons.remove_circle_outline),
              tooltip: 'Verwijder 1',
              onPressed: () {
                n_50_cent--;
                printCurrentMoney();
              },
            ),
            Image(image: AssetImage('assets/euros/fiftycents.png')),
            IconButton(
              icon: Icon(Icons.add_circle_outline),
              tooltip: 'Voeg 1 toe',
              onPressed: () {
                n_50_cent++;
                printCurrentMoney();
              },
            ),
            IconButton(
              icon: Icon(Icons.remove_circle_outline),
              tooltip: 'Verwijder 1',
              onPressed: () {
                n_1_euro--;
                printCurrentMoney();
              },
            ),
            Image(image: AssetImage('assets/euros/oneeuro.png')),
            IconButton(
              icon: Icon(Icons.add_circle_outline),
              tooltip: 'Voeg 1 toe',
              onPressed: () {
                n_1_euro++;
                printCurrentMoney();
              },
            ),
            IconButton(
              icon: Icon(Icons.remove_circle_outline),
              tooltip: 'Verwijder 1',
              onPressed: () {
                n_2_euro--;
                printCurrentMoney();
              },
            ),
            Image(image: AssetImage('assets/euros/twoeuros.png')),
            IconButton(
              icon: Icon(Icons.add_circle_outline),
              tooltip: 'Voeg 1 toe',
              onPressed: () {
                n_2_euro++;
                printCurrentMoney();
              },
            ),
            IconButton(
              icon: Icon(Icons.remove_circle_outline),
              tooltip: 'Verwijder 1',
              onPressed: () {
                n_5_euro--;
                printCurrentMoney();
              },
            ),
            Image(image: AssetImage('assets/euros/fiveeuros.png')),
            IconButton(
              icon: Icon(Icons.add_circle_outline),
              tooltip: 'Voeg 1 toe',
              onPressed: () {
                n_5_euro++;
                printCurrentMoney();
              },
            ),
            IconButton(
              icon: Icon(Icons.remove_circle_outline),
              tooltip: 'Verwijder 1',
              onPressed: () {
                n_10_euro--;
                printCurrentMoney();
              },
            ),
            Image(image: AssetImage('assets/euros/teneuros.png')),
            IconButton(
              icon: Icon(Icons.add_circle_outline),
              tooltip: 'Voeg 1 toe',
              onPressed: () {
                n_10_euro++;
                printCurrentMoney();
              },
            ),
            IconButton(
              icon: Icon(Icons.remove_circle_outline),
              tooltip: 'Verwijder 1',
              onPressed: () {
                n_20_euro--;
                printCurrentMoney();
              },
            ),
            Image(image: AssetImage('assets/euros/twentyeuros.png')),
            IconButton(
              icon: Icon(Icons.add_circle_outline),
              tooltip: 'Voeg 1 toe',
              onPressed: () {
                n_20_euro++;
                printCurrentMoney();
              },
            ),
            IconButton(
              icon: Icon(Icons.remove_circle_outline),
              tooltip: 'Verwijder 1',
              onPressed: () {
                n_50_euro--;
                printCurrentMoney();
              },
            ),
            Image(image: AssetImage('assets/euros/fiftyeuros.png')),
            IconButton(
              icon: Icon(Icons.add_circle_outline),
              tooltip: 'Voeg 1 toe',
              onPressed: () {
                n_50_euro++;
                printCurrentMoney();
              },
            ),
            IconButton(
              icon: Icon(Icons.remove_circle_outline),
              tooltip: 'Verwijder 1',
              onPressed: () {
                n_100_euro--;
                printCurrentMoney();
              },
            ),
            Image(image: AssetImage('assets/euros/hundredeuros.png')),
            IconButton(
              icon: Icon(Icons.add_circle_outline),
              tooltip: 'Voeg 1 toe',
              onPressed: () {
                n_100_euro++;
                printCurrentMoney();
              },
            ),
//            IconButton(
//              icon: Icon(Icons.remove_circle_outline),
//              tooltip: 'Verwijder 1',
//              onPressed: () {
//                n_1_cent--;
//              },
//            ),
//            Container(
//              padding: const EdgeInsets.all(8),
//              child: const Text('200 euro'),
//              color: Colors.teal[500],
//            ),
//            IconButton(
//              icon: Icon(Icons.add_circle_outline),
//              tooltip: 'Voeg 1 toe',
//              onPressed: () {
//                n_1_cent++;
//              },
//            ),
//            IconButton(
//              icon: Icon(Icons.remove_circle_outline),
//              tooltip: 'Verwijder 1',
//              onPressed: () {
//                n_1_cent--;
//              },
//            ),
//            Container(
//              padding: const EdgeInsets.all(8),
//              child: const Text('500 euro'),
//              color: Colors.teal[500],
//            ),
//            IconButton(
//              icon: Icon(Icons.add_circle_outline),
//              tooltip: 'Voeg 1 toe',
//              onPressed: () {
//                n_1_cent++;
//              },
//            ),
          ],
        )
    );
  }
}