import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StackCards extends StatelessWidget {
  final List cards;
  final double heightCard;

  StackCards({@required this.cards, this.heightCard = 110});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightCard+10,
      child: Stack(
        children: [
          for (int i = 0; i < cards.length; i++)
            Positioned(
              left: (i.toDouble() * 30),
              child: SvgPicture.asset(
                'assets/images/cards/${cards[i]}.svg',
                width: 100,
                height: heightCard,
              ),
            ),
        ],
      ),
    );
  }
}
