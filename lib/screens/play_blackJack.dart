import 'dart:async';
import 'dart:math';
import 'package:twentyoneblackjack/components/bit_button.dart';
import 'package:twentyoneblackjack/components/blackjack_button.dart';
import 'package:twentyoneblackjack/components/hand_cards.dart';
import 'package:twentyoneblackjack/utils/Round.dart';
import 'package:twentyoneblackjack/utils/db_sqlite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twentyoneblackjack/utils/Person.dart';
import 'package:twentyoneblackjack/utils/Deck.dart';

///pagina que roda o jogo BlackJack
class BlackJack extends StatefulWidget {
  @override
  _BlackJackState createState() => _BlackJackState();
}

class _BlackJackState extends State<BlackJack> {
  Deck deque = new Deck(8);
  Person player = new Person("You", false);
  Person dealer = new Person("Dealer", true);
  bool _showReplayButton = false;
  int _playerDefeatVictory;
  String _playerResultShow;
  double _progressValue;
  Color _colorPlayer;
  Color _colorDealer;
  bool _loadPage = false;
  double bit;
  bool playerWhitoutMoney;

  @override
  void initState() {
    super.initState();
    print("Tamanho: " + deque.getDeck.length.toString());
    player.newRound(deque);
    dealer.newRound(deque);
    player.hitHand(deque.openCard());
    dealer.hitHand(deque.openCard());
    player.hitHand(deque.openCard());
    dealer.hitHand(deque.openCard());
    print("Cartas do player: " + player.getCards.toString());
    _progressValue = 0;
    _colorDealer = Color(0xff090265);
    _colorPlayer = Color(0xff090265);
    bit = 20;
    _playerResultShow = "BlackJack";
    //Esse Future.delayed vai fazer a pagina esperar 2 segundos antes de carrega-la
    Future.delayed(Duration(milliseconds: 1000), () {
      setState(() {
        _loadPage = true;
      });
    });
    playerWhitoutMoney = false;
  }

  ///Reinicia a rodada para uma nova partida
  void replay() {
    setState(() {
      player.newRound(deque);
      dealer.newRound(deque);
      player.hitHand(deque.openCard());
      dealer.hitHand(deque.openCard());
      player.hitHand(deque.openCard());
      dealer.hitHand(deque.openCard());
      _colorDealer = Color(0xff090265);
      _colorPlayer = Color(0xff090265);
      _playerResultShow = 'BlackJack';
      if (bit > player.getMoney) {
        bit = 20;
      }
      if (player.getMoney < 20) {
        print("You`re without money...");
        playerWhitoutMoney = true;
      }
    });
  }

  Color _colorResultShow(String s) {
    if (s == "Victory") {
      return Colors.green;
    } else if (s == "Defeat") {
      return Colors.red;
    } else if (s == "Tie") {
      return Colors.blue[200];
    } else {
      return Theme.of(context).accentColor;
    }
  }

  ///Quando chamada essa função é o intervalo entre uma partida e outra, chamando uma barra de progresso que dura quase 2 segundos
  void _updateProgress() {
    const oneSec = const Duration(milliseconds: 20);
    int test = 0;
    Timer.periodic(oneSec, (Timer t) async {
      setState(() {
        _progressValue += 0.013;
        test += 20;
        print(_progressValue);
        print(test);
        // we "finish" downloading here
        if (_progressValue >= 1) {
          _showReplayButton = false;
          _progressValue = 0.0;
          replay();
          t.cancel();
          print("entrou aqui no updateProgress");
          return;
        }
      });
    });
  }

  ///Função que analisa e classifica o jogo, assim como é responsável por fazer os movimentos do Dealer();
  void playGame() {
    if (player.getStand == true) {
      while (!dealer.getStand && !dealer.getExplode) {
        if (dealer.getCardsTotal > 16 && dealer.getCardsTotal < 22) {
          dealer.standHand();
          if (dealer.getCardsTotal > player.getCardsTotal) {
            print("-------Player PERDEU-------");
            _colorDealer = Colors.green;
            _colorPlayer = Colors.red;
            dealer.win();
            player.lose();
            _playerDefeatVictory = -1;
            _playerResultShow = "Defeat";
            player.setMoney = player.getMoney - bit;
          } else if (dealer.getCardsTotal == player.getCardsTotal) {
            print("===EMPATE===");
            _colorDealer = Colors.blue[200];
            _colorPlayer = Colors.blue[200];
            _playerDefeatVictory = 0;
            _playerResultShow = "Tie";
          } else {
            print("+++++++Dealer PERDEU+++++++");
            _colorDealer = Colors.red;
            _colorPlayer = Colors.green;
            player.win();
            dealer.lose();
            _playerDefeatVictory = 1;
            _playerResultShow = "Victory";
            if (player.getCardsValue == 21) {
              player.setMoney = player.getMoney + 1.5 * bit;
            } else {
              player.setMoney = player.getMoney + bit;
            }
          }
        } else {
          var card = deque.openCard();
          dealer.hitHand(card);
          print("Abriu " + card);
        }
        if (dealer.getExplode) {
          print("EXPLODIU A MÃO DO DEALER");
          _colorDealer = Colors.red;
          _colorPlayer = Colors.green;
          player.win();
          dealer.lose();
          _playerDefeatVictory = 1;
          _playerResultShow = "Victory";
          if (player.getCardsValue == 21) {
            player.setMoney = player.getMoney + 1.5 * bit;
          } else {
            player.setMoney = player.getMoney + bit;
          }
        }
        if (dealer.getStand) print("DEALER ENCERROU");
      }
    } else if (player.getExplode) {
      print("-------Player PERDEU-------");
      _colorDealer = Colors.green;
      _colorPlayer = Colors.red;
      dealer.win();
      player.lose();
      _playerDefeatVictory = -1;
      _playerResultShow = "Defeat";
      player.setMoney = player.getMoney - bit;
    }

    addRoundDB(_playerDefeatVictory, player.getCardsValue, dealer.getCardsValue,
        player.getCards);
  }

  ///Essa função adiciona as informações da rodada do banco de dados, [state], [playerPoints], [dealerPoints], [playerCards]
  void addRoundDB(
      int state, int playerPoints, int dealerPoints, List playerCards) {
    final newRound = Round(
      id: Random().nextDouble(),
      state: state,
      playerPoints: playerPoints,
      dealerPoints: dealerPoints,
      playerCards: playerCards.toString(),
    );

    DbSQLite.insert('historic', newRound);
  }

  @override
  Widget build(BuildContext context) {
    return _loadPage
        ?
        //WillPopScope está bloqueando a função do botão de voltar do celular.
        WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Scaffold(
              backgroundColor: Theme.of(context).backgroundColor,
              appBar: AppBar(
                leading: new IconButton(
                  icon: new Icon(Icons.arrow_back),
                  color: Theme.of(context).accentColor,
                  onPressed: !_showReplayButton
                      ? () {
                          Navigator.pop(context, () {});
                        }
                      :
                      //Se a barra de progresso estiver sendo exibida, o botão de voltar será bloqueado
                      null,
                ),
                backgroundColor: Theme.of(context).backgroundColor,
                elevation: 0,
                title: Text(
                  _playerResultShow,
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: _colorResultShow(_playerResultShow)),
                ),
                actions: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              "${player.getMoney.toStringAsFixed(0)}",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  .copyWith(
                                      color: Theme.of(context).accentColor),
                            ),
                            SizedBox(width: 5),
                            SvgPicture.asset("assets/images/casino_coin.svg",
                                width: 20,
                                color: Theme.of(context).accentColor),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              body: Stack(
                children: <Widget>[
                  playerWhitoutMoney
                      ? Center(
                          child: Center(
                              child: Text(
                            "You`re without money...",
                            style: Theme.of(context).textTheme.headline5,
                          )),
                        )
                      : SingleChildScrollView(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5),
                                  child: Text(
                                    dealer.getName,
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                ),
                              ),
                              DealerHand(
                                dealer: dealer,
                                player: player,
                                colorDealer: _colorDealer,
                              ),
                              Divider(color: Colors.transparent),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5),
                                  child: Text(
                                    player.getName,
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                ),
                              ),
                              PlayerHand(
                                  player: player, colorPlayer: _colorPlayer),
                              Divider(),
                              BitButton(
                                bit: bit,
                                removeBit: () {
                                  setState(() {
                                    if (bit > 20) {
                                      bit = bit - 20;
                                    }
                                  });
                                },
                                addBit: () {
                                  setState(() {
                                    if (bit <= player.getMoney - 20) {
                                      bit = bit + 20;
                                    }
                                  });
                                },
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  ButtonBlackjack(
                                    name: "Hit",
                                    color: Colors.green[400],
                                    function: !_showReplayButton &&
                                            !playerWhitoutMoney
                                        ? () {
                                            setState(() {
                                              player.hitHand(deque.openCard());
                                              print("Foi! " +
                                                  player.getCards.toString());
                                              if (player.getExplode) {
                                                _showReplayButton = true;
                                                _colorPlayer = Colors.red;
                                                _playerDefeatVictory = -1;
                                                _playerResultShow = "Defeat";
                                                player.setMoney =
                                                    player.getMoney - bit;

                                                addRoundDB(
                                                  _playerDefeatVictory,
                                                  player.getCardsValue,
                                                  dealer.getCardsValue,
                                                  player.getCards,
                                                );
                                                _updateProgress();
                                              }
                                              if (player.getBlackjack == true) {
                                                player.standHand();
                                              }
                                            });
                                          }
                                        : null,
                                  ),
                                  ButtonBlackjack(
                                    name: "Stand",
                                    color: Colors.red[400],
                                    function: !_showReplayButton &&
                                            !playerWhitoutMoney
                                        ? () {
                                            setState(() {
                                              player.standHand();
                                              playGame();
                                              _showReplayButton = true;
                                              _updateProgress();
                                              // Future.delayed(Duration(seconds: 2), () {
                                              //   replay();
                                              //   print("deveria ter ido...");
                                              // });
                                            });
                                          }
                                        : null,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  ButtonBlackjack(
                                    name: "Split",
                                    color: Colors.blue[400],
                                    function: !_showReplayButton &&
                                            !playerWhitoutMoney
                                        ? () {
                                            setState(() {
                                              player.getCards
                                                  .add(deque.openCard());
                                              // Future<String> test = deque.openCard();
                                              print("Foi! " +
                                                  player.getCards.toString());
                                              // print("Esse teste " + test.toString());
                                            });
                                          }
                                        : null,
                                  ),
                                  ButtonBlackjack(
                                    name: "Double",
                                    color: Colors.yellow[400],
                                    function: !_showReplayButton &&
                                            !playerWhitoutMoney
                                        ? () {
                                            setState(() {
                                              bit = bit * 2;
                                              player.getCards
                                                  .add(deque.openCard());
                                              // Future<String> test = deque.openCard();
                                              player.standHand();
                                              playGame();
                                              _showReplayButton = true;
                                              _updateProgress();
                                              print("Foi! " +
                                                  dealer.getCards.toString());
                                              // print("Esse teste " + test.toString());
                                              bit = bit / 2;
                                            });
                                          }
                                        : null,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                  _showReplayButton
                      ? LinearProgressIndicator(
                          value: _progressValue,
                        )
                      : Container(),
                ],
              ),
            ),
          )
        : Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text("Starting game...")
                ],
              ),
            ),
          );
  }
}

// playGame(Person dealer, Person player, Deck deque) {
//   print("------------------//------------------");
//   dealer.newRound(deque);
//   player.newRound(deque);

//   print("Dealer: " +
//       dealer.getCards.toString() +
//       "\nSoma: " +
//       dealer.getCardsTotal.toString());
//   print("${player.getName}" +
//       player.getCards.toString() +
//       "\nSoma: " +
//       player.getCardsTotal.toString());

//   while (!player.getStand && !player.getExplode) {
//     stdout.write("Você quer mais uma carta? S/N ");
//     String answer = stdin.readLineSync();
//     if (answer == "S" || answer == "s") {
//       player.hitHand(deque.openCard());
//       print("${player.getName} - " + player.getCards.toString());
//       print("Soma: " + player.getCardsValue.toString());
//     } else {
//       player.standHand();
//     }

//     if (player.getExplode) print("EXPLODIU A MÃO DO PLAYER");
//     if (player.getStand) print("PLAYER ENCERROU");
//   }

//   String winner;
//   if (player.getStand == true) {
//     while (!dealer.getStand && !dealer.getExplode) {
//       var card = deque.openCard();
//       dealer.hitHand(card);
//       print("Abriu " + card);
//       if (dealer.getCardsTotal > 16 && dealer.getCardsTotal < 22) {
//         dealer.standHand();
//         if (dealer.getCardsTotal > player.getCardsTotal) {
//           winner = "-------Player PERDEU-------";
//           dealer.win();
//         } else if (dealer.getCardsTotal == player.getCardsTotal) {
//           winner = "===EMPATE===";
//         } else {
//           winner = "+++++++Dealer PERDEU+++++++";
//           player.win();
//         }
//       } else if (dealer.getCardsTotal > 21) {
//         winner = "+++++++Dealer PERDEU+++++++";
//         player.win();
//       }
//       if (dealer.getExplode) print("EXPLODIU A MÃO DO DEALER");
//       if (dealer.getStand) print("DEALER ENCERROU");
//     }
//   } else if (player.getExplode) {
//     winner = "-------Player PERDEU-------";
//     dealer.win();
//   }

//   print(winner);
//   print("Player terminou com " + player.getCardsTotal.toString());
//   print("Dealer terminou com " + dealer.getCardsTotal.toString());
// }
