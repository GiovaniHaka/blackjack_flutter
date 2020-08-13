import 'package:twentyoneblackjack/components/game_card.dart';
import 'package:twentyoneblackjack/components/stats_card.dart';
import 'package:twentyoneblackjack/components/round_card.dart';
import 'package:twentyoneblackjack/utils/Round.dart';
import 'package:twentyoneblackjack/utils/db_sqlite.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Serve para atualizar o estado de uma outra classe/componente do aplicativo
  GlobalKey<StatsCardState> keyStatsCard = GlobalKey();
  Round _lastRound;

  //InitState é utilizado para carregar a págna pela primeira vez
  @override
  void initState() {
    super.initState();
    setState(() {
      getLastRound();
    });
  }

  ///Essa função chama uma request no DB SQL para pegar a última rodada
  void getLastRound() async {
    _lastRound = await DbSQLite.getLastRound('historic');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF0F0F0),
      appBar: AppBar(
        backgroundColor: Color(0xffF0F0F0),
        elevation: 0,
        title: Text(
          "BlackJack",
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              //Essa funçao atualiza a tela com o último round, e atualizado o estado do StatsCard em outra classe ou Widget.
              setState(() {
                keyStatsCard.currentState.updateState();
                getLastRound();
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(
                Icons.refresh,
                color: Color(0xff090265),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Statistics",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
              ),
              StatsCard(key: keyStatsCard),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Last round",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, "/historic"),
                //FutureBuilder serve para construir widgets que necessitam de requests em algum lugar, sejam dados locias ou na nuvem.
                child: FutureBuilder(
                  future: DbSQLite.getLastRound('historic'),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                          padding: EdgeInsets.all(10),
                          color: Color(0xffE5E5E5),
                          height: 80,
                          child: Center(child: Text("Loading")));
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      if (_lastRound == null) {
                        return Container(
                            decoration: BoxDecoration(
                              color: Color(0xffE5E5E5),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: EdgeInsets.all(10),
                            height: 80,
                            child: Center(child: Text("Play one round!")));
                      } else {
                        return RoundCard(
                          _lastRound.state,
                          _lastRound.playerCards,
                          _lastRound.playerPoints,
                          _lastRound.dealerPoints,
                        );
                      }
                    }
                  },
                ),
              ),
              Divider(
                color: Colors.transparent,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Colors.white,
                  onPressed: () {
                    print(Navigator);
                    Navigator.pushNamed(context, '/blackjack');
                  },
                  child: FittedBox(
                    child: Text(
                      "How to play BlackJack?",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff090265),
                      ),
                    ),
                  ),
                ),
              ),
              Divider(
                color: Colors.transparent,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CardGame(
                        "BlackJack ",
                        "Play",
                        "assets/images/deck.svg",
                        '/blackjack',
                        Color(0xff5A5FEF),
                      ),
                      SizedBox(width: 8),
                      CardGame(
                        "BlackJack ",
                        "Estrategy",
                        "assets/images/strategy.svg",
                        '/selectStrategy',
                        Color(0xff00D48F),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CardGame(
                        "Counting ",
                        "Memorize",
                        "assets/images/brain.svg",
                        '/selectMemorize',
                        Color(0xffFDD92B),
                      ),
                      SizedBox(width: 8),
                      CardGame(
                        "Counting ",
                        "Practice",
                        "assets/images/fist.svg",
                        '/blackjack',
                        Color(0xffD4002C),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}