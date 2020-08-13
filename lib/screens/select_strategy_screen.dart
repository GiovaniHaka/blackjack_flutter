import 'package:twentyoneblackjack/components/tables_strategy.dart';
import 'package:flutter/material.dart';

class SelectStrategy extends StatefulWidget {
  @override
  _SelectStrategyState createState() => _SelectStrategyState();
}

class _SelectStrategyState extends State<SelectStrategy> {
  // final GlobalKey _keyTable = GlobalKey();
  // Size tableSize;
  // double tableHeight = 0;

  // bool open = false;

  // @override
  // void initState() {
  //   super.initState();
  // WidgetsBinding.instance.addPostFrameCallback((_) => getTableSize());
  // }

  // getTableSize() {
  //   RenderBox _cardBox = _keyTable.currentContext.findRenderObject();
  //   tableSize = _cardBox.size;
  //   tableHeight = tableSize.height;
  //   print(tableSize);
  //   print(tableSize.height);
  //   print("Foi aqui...");
  // }

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
          "Select Strategy",
          style: Theme.of(context).textTheme.headline6,
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Learn the basic strategy in Blackjack to have a better chance of defeating the dealer!",
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: 16,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(
                height: 20,
                thickness: 2,
              ),
            ),
            cardStrategyType(
              context,
              "Hard Hand",
              "Hand with values between 5 and 20",
              Color(0xffBF19AE),
              TableHardHand(),
              '/hardhandgame',
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(
                height: 20,
                thickness: 2,
              ),
            ),
            cardStrategyType(
              context,
              "Soft Hand",
              "Hand with one card A",
              Color(0xffF7A500),
              TableSoftHand(),
              '/hardhandgame',
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(
                height: 20,
                thickness: 2,
              ),
            ),
            cardStrategyType(
              context,
              "Pairs",
              "Hand with pairs",
              Color(0xff0BDABF),
              TablePairs(),
              '/hardhandgame',
            ),
          ],
        ),
      ),
    );
  }
}

Widget tableClosed() {
  return AnimatedContainer(
    key: ValueKey("teste"),
    duration: Duration(seconds: 1),
    curve: Curves.easeInOut,
    height: 0,
    color: Color(0xffE5E5E5),
    padding: EdgeInsets.all(0),
    child: Container(),
  );
}

Widget cardStrategyType(BuildContext context, String title, String description,
    Color color, Widget table, String route) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: Container(
      color: Colors.grey[300],
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
            child: Text(
              title,
              style:
                  Theme.of(context).textTheme.headline6.copyWith(color: color),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 60,
              color: Theme.of(context).backgroundColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              description,
                              style: TextStyle(
                                  color: Theme.of(context).accentColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () => Navigator.pushNamed(context, route),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          color: color,
                          child: FittedBox(
                              child: Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                          )),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Opacity(
            opacity: 0.85,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: table,
            ),
          ),
        ],
      ),
    ),
  );
}
