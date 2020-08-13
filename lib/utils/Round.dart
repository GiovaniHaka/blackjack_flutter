class Round {
  double id;
  int state;
  int playerPoints;
  int dealerPoints;
  String playerCards;

  Round({this.id, this.state, this.playerPoints, this.dealerPoints, this.playerCards});

  Map<String, dynamic> roundToMap() {
    return {
      'id': id,
      'state': state,
      'playerPoints': playerPoints,
      'dealerPoints': dealerPoints,
      'playerCards': playerCards,
    };
  }
}
