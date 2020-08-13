import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

///Esqueleto de Card de rodada, que mostra os dados de uma partida.
class RoundCard extends StatelessWidget {
  final int state;
  final int playerPoints;
  final int dealerPoints;
  final String cards;

  Color colorRound(int i) {
    // print("Esse é o valor do state: $i");
    if (i == -1) {
      //defeat
      return Colors.red[300];
    } else if (i == 0) {
      //tie
      return Colors.blue[300];
    } else if (i == 1) {
      //victory
      return Colors.green[300];
    } else {
      return null;
    }
  }

  List<String> readCards(String s) {
    List<String> aux = [];
    for (int count = 0; count < s.length - 1; count++) {
      if (s[count] == '[' ||
          s[count] == ' ' ||
          s[count] == ',' ||
          s[count] == ']') {
      } else {
        switch (s[count]) {
          case 'A':
            aux.add("A${checkSuit(s[count + 1])}");
            break;
          case '2':
            aux.add("2${checkSuit(s[count + 1])}");
            break;
          case '3':
            aux.add("3${checkSuit(s[count + 1])}");
            break;
          case '4':
            aux.add("4${checkSuit(s[count + 1])}");
            break;
          case '5':
            aux.add("5${checkSuit(s[count + 1])}");
            break;
          case '6':
            aux.add("6${checkSuit(s[count + 1])}");
            break;
          case '7':
            aux.add("7${checkSuit(s[count + 1])}");
            break;
          case '8':
            aux.add("8${checkSuit(s[count + 1])}");
            break;
          case '9':
            aux.add("9${checkSuit(s[count + 1])}");
            break;
          case '1':
            aux.add("10${checkSuit(s[count + 2])}");
            break;
          case 'J':
            aux.add("J${checkSuit(s[count + 1])}");
            break;
          case 'Q':
            aux.add("Q${checkSuit(s[count + 1])}");
            break;
          case 'K':
            aux.add("K${checkSuit(s[count + 1])}");
            break;
        }
      }
    }
    return aux;
  }

  String checkSuit(String s) {
    switch (s) {
      case 'C':
        return 'C';
        break;
      case 'D':
        return 'D';
        break;
      case 'H':
        return 'H';
        break;
      case 'S':
        return 'H';
        break;
      default:
        return null;
        break;
    }
  }

  ///Used to show a round already finished in historic
  RoundCard(this.state, this.cards, this.playerPoints, this.dealerPoints);

  @override
  Widget build(BuildContext context) {
    List _roundCards = readCards(this.cards);

    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: colorRound(this.state),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(5),
      ),
      // margin: EdgeInsets.only(bottom: 5, top: 5),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      height: 80,
      child: Stack(
        children: <Widget>[
          Stack(
            children: [
              for (int i = 0; i < _roundCards.length; i++)
                Positioned(
                  left: i.toDouble() * 20,
                  child: SvgPicture.asset(
                    'assets/images/cards/${_roundCards[i]}.svg',
                    width: 100,
                    height: 70,
                  ),
                ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("You", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                  Text("${this.playerPoints}", style: TextStyle(color: Color(0xff090265), fontWeight: FontWeight.bold)),
                ],
              ),
              Container(
                width: 2,
                height: 40,
                color: Colors.white,
                margin: EdgeInsets.symmetric(horizontal: 5),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Dealer", style: TextStyle(color: Colors.grey[100],),),
                  Text("${this.dealerPoints}", style: TextStyle(color: Color(0xff090265)),),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
