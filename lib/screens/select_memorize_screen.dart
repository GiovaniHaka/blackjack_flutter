import 'package:twentyoneblackjack/components/stack_cards.dart';
import 'package:flutter/material.dart';

class SelectMemorize extends StatefulWidget {
  @override
  _SelectMemorizeState createState() => _SelectMemorizeState();
}

class _SelectMemorizeState extends State<SelectMemorize> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
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
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Now you will learn how to attribute values to counting cards.\n* The values are for all suits.",
              textAlign: TextAlign.justify,
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text(
                    "Cards value:",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Text(
                    "+1",
                    style: Theme.of(context).textTheme.headline5.copyWith(fontSize: 20),
                  ),
                ],
              ),
            ),
            StackCards(
              cards: [
                "2S",
                "3S",
                "4S",
                "5S",
                "6S",
              ],
              heightCard: 60,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Cards value:",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Text(
                    "0",
                    style: Theme.of(context).textTheme.headline5.copyWith(fontSize: 20),
                  ),
                ],
              ),
            ),
            StackCards(
              cards: [
                "7S",
                "8S",
                "9S",
              ],
              heightCard: 60,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Cards value:",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Text(
                    "-1",
                    style: Theme.of(context).textTheme.headline5.copyWith(fontSize: 20),
                  ),
                ],
              ),
            ),
            StackCards(
              cards: [
                "10S",
                "JS",
                "QS",
                "KS",
                "AS",
              ],
              heightCard: 60,
            ),
            Divider(),
            Align(
              alignment: Alignment.center,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () {
                  Navigator.pushNamed(context, '/memorize');
                },
                color: Theme.of(context).accentColor,
                child: Text(
                  "Play",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: Colors.white, fontSize: 40),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
