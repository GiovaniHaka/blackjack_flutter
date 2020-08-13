import 'package:twentyoneblackjack/utils/Deck.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Memorize extends StatefulWidget {
  @override
  _MemorizeState createState() => _MemorizeState();
}

class _MemorizeState extends State<Memorize> {
  Deck dequeMemorize = new Deck(1);
  String card;
  Color backColor;
  bool isRight;
  int total;
  int hits;
  int errors;

  @override
  void initState() {
    super.initState();
    card = dequeMemorize.openCard();
    backColor = Colors.grey[300];
    total = 0;
    hits = 0;
    errors = 0;
  }

  //Return true se acertou e false se errou
  Color checkCount(String card, int valueCount) {
    if (valueCount == -1) {
      if (card[0] == "1" ||
          card[0] == "J" ||
          card[0] == "Q" ||
          card[0] == "K" ||
          card[0] == "A") {
        hits += 1;
        total += 1;
        return Colors.green;
      } else {
        errors += 1;
        total += 1;
        return Colors.red;
      }
    } else if (valueCount == 0) {
      if (card[0] == "7" || card[0] == "8" || card[0] == "9") {
        hits += 1;
        return Colors.green;
      } else {
        errors += 1;
        total += 1;
        return Colors.red;
      }
    } else if (valueCount == 1) {
      if (card[0] == "2" ||
          card[0] == "3" ||
          card[0] == "4" ||
          card[0] == "5" ||
          card[0] == "6") {
        hits += 1;
        total += 1;
        return Colors.green;
      } else {
        total += 1;
        errors += 1;
        return Colors.red;
      }
    } else {
      return Colors.grey[300];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          color: Theme.of(context).accentColor,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Memorize",
          style: Theme.of(context).textTheme.headline6,
        ),
        backgroundColor: backColor,
        elevation: 0,
      ),
      body: dequeMemorize.getOpenedCards != 52
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Total"),
                            Text(total.toString()),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Hits"),
                            Text(hits.toString()),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Errors"),
                            Text(errors.toString()),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Container(
                    child: SvgPicture.asset(
                      'assets/images/cards/$card.svg',
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RaisedButton(
                          padding: EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          onPressed: () {
                            setState(() {
                              backColor = checkCount(card, -1);
                              Future.delayed(Duration(milliseconds: 500), () {
                                setState(() {
                                  card = dequeMemorize.openCard();
                                  backColor = Colors.grey[300];
                                });
                              });
                            });
                            print(card);
                            print(dequeMemorize.getOpenedCards);
                          },
                          color: Colors.indigo[900],
                          child: Text(
                            "-1",
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(color: Colors.white),
                          ),
                        ),
                        RaisedButton(
                          padding: EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          onPressed: () {
                            setState(() {
                              backColor = checkCount(card, 0);
                              Future.delayed(Duration(milliseconds: 500), () {
                                setState(() {
                                  card = dequeMemorize.openCard();
                                  backColor = Colors.grey[300];
                                });
                              });
                            });
                            print(card);
                            print(dequeMemorize.getOpenedCards);
                          },
                          color: Colors.indigo[100],
                          child: Text(
                            "0",
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(color: Colors.white),
                          ),
                        ),
                        RaisedButton(
                          padding: EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          onPressed: () {
                            setState(() {
                              backColor = checkCount(card, 1);
                              Future.delayed(Duration(milliseconds: 500), () {
                                setState(() {
                                  card = dequeMemorize.openCard();
                                  backColor = Colors.grey[300];
                                });
                              });
                            });
                            print(card);
                            print(dequeMemorize.getOpenedCards);
                          },
                          color: Colors.indigo[400],
                          child: Text(
                            "+1",
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          : RaisedButton(
              onPressed: () {
                setState(() {
                  card = dequeMemorize.openCard();
                });
              },
              child: Text("PLAY AGAIN"),
            ),
    );
  }
}
