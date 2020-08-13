

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

///Botão de jogos da Home()
class CardGame extends StatelessWidget {
  final String _category;
  final String _name;
  final String _svgImage;
  final String _route;
  final Color _colorCard;

CardGame(this._category, this._name, this._svgImage, this._route, this._colorCard);

  @override
  Widget build(BuildContext context) {
   return Expanded(
    child: GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '${this._route}');
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 2.0,
              spreadRadius: 1.0,
              color: Colors.grey[300],
            )
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "${this._category}",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: Color(0xff090265),
              ),
            ),
            Container(
              height: 3,
              width: 50,
              color: this._colorCard,
            ),
            Text(
              "${this._name}",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: Color(0xff090265),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: SvgPicture.asset(
                "${this._svgImage}",
                color: this._colorCard,
                width: 80,
                height: 80,
              ),
            ),
          ],
        ),
      ),
    ),
  );
  }
}