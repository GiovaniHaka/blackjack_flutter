import 'package:twentyoneblackjack/components/round_card.dart';
import 'package:twentyoneblackjack/utils/Round.dart';
import 'package:twentyoneblackjack/utils/db_sqlite.dart';
import 'package:flutter/material.dart';

class Historic extends StatefulWidget {
  @override
  _HistoricState createState() => _HistoricState();
}

class _HistoricState extends State<Historic> {
  List<Round> _rounds = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      recebeDados();
      print(_rounds);
    });
  }

  void recebeDados() async {
    _rounds = await DbSQLite.getData('historic');
  }

  String winLoseTie(String s) {
    if (s == "-1") {
      return "defeat";
    } else if (s == '0') {
      return "tie";
    } else if (s == '1') {
      return "victory";
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).accentColor),
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        title: Text(
          "Historic",
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(
              icon: Icon(Icons.delete_outline),
              color: Theme.of(context).accentColor,
              onPressed: () {
                setState(() {
                  DbSQLite.truncate('historic');
                  recebeDados();
                });
              },
            ),
          )
        ],
      ),
      body: Center(
        child: FutureBuilder(
          future: DbSQLite.getData('historic'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (_rounds.isEmpty) {
                return Center(child: Text("Play one round!"));
              } else {
                return ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.transparent,
                    height: 10,
                  ),
                  padding: EdgeInsets.all(8),
                  itemCount: _rounds.length,
                  itemBuilder: (context, index) {
                    return RoundCard(
                      _rounds[_rounds.length - 1 - index].state,
                      _rounds[_rounds.length - 1 - index].playerCards,
                      _rounds[_rounds.length - 1 - index].playerPoints,
                      _rounds[_rounds.length - 1 - index].dealerPoints,
                    );
                  },
                );
              }
            }
          },
        ),
      ),
    );
  }
}
