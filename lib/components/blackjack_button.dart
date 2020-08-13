import 'package:flutter/material.dart';

///Botão de função no jogo Blackjack
class ButtonBlackjack extends StatelessWidget {
  final Color color;
  final String name;
  final Function function;

  ButtonBlackjack({@required this.name, @required this.color, @required this.function});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: this.color,
      onPressed: this.function,
      child: Text(this.name),
    );
  }
}
