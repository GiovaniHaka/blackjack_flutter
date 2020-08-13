import 'package:twentyoneblackjack/utils/Person.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlayerHand extends StatelessWidget {
  final Person player;
  final Color colorPlayer;

  PlayerHand({@required this.player, @required this.colorPlayer});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 20, left: 15),
            height: 110,
            color: colorPlayer,
            child: player.getCards.length == 0
                ? Center(child: Text("Erro"))
                : Stack(
                    children: [
                      for (int i = 0; i < player.getCards.length; i++)
                        Positioned(
                          left: i.toDouble() * 30,
                          child: SvgPicture.asset(
                            'assets/images/cards/${player.getCards[i]}.svg',
                            width: 100,
                            height: 110,
                            fit: BoxFit.fill,
                          ),
                        ),
                    ],
                  ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(5))),
              padding: EdgeInsets.all(5),
              child: Text(player.getCardsTotal.toString()),
            ),
          ),
        ],
      ),
    );
  }
}

class DealerHand extends StatelessWidget {
  final Person dealer;
  final Person player;
  final Color colorDealer;

  DealerHand(
      {@required this.dealer,
      @required this.player,
      @required this.colorDealer});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 20, left: 15),
            height: 110,
            color: colorDealer,
            child: !player.getExplode && !player.getStand
                ? Stack(
                    children: [
                      Positioned(
                        left: 0,
                        child: SvgPicture.asset(
                          'assets/images/cards/${dealer.getCards[0]}.svg',
                          width: 100,
                          height: 110,
                        ),
                      ),
                      Positioned(
                        left: 30,
                        child: SvgPicture.asset(
                          'assets/images/cards/back.svg',
                          width: 100,
                          height: 110,
                        ),
                      ),
                    ],
                  )
                : Stack(
                    children: [
                      for (int i = 0; i < dealer.getCards.length; i++)
                        Positioned(
                          left: i.toDouble() * 30,
                          child: SvgPicture.asset(
                            'assets/images/cards/${dealer.getCards[i]}.svg',
                            width: 100,
                            height: 110,
                          ),
                        ),
                    ],
                  ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(5))),
                child: !player.getExplode && !player.getStand
                    ? Text((dealer.getCardsValue - dealer.getIndex1Value)
                        .toString())
                    : Text(dealer.getCardsValue.toString())),
          ),
        ],
      ),
    );
  }
}
