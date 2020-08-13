import 'Deck.dart';

class Person {
  String _name;
  List<String> _cards;
  int _cardsValue;
  int _victorys;
  int _loses;
  bool _stand;
  bool _explode;
  bool _dealer;
  bool _blackjack;
  double money;
  double bit;

  ///Constructor [Person]
  ///
  ///[n] - name of the person
  ///[d] - if is or isn`t a dealer
  Person(String n, bool d) {
    this._name = n;
    this._cards = [];
    this._stand = false;
    this._explode = false;
    this._victorys = 0;
    this._loses = 0;
    this._blackjack = false;
    this.money = 500;
    if (d) {
      this._dealer = true;
    } else {
      this._dealer = false;
    }
  }

  ///get the name of person
  String get getName => this._name;
  //set name
  set setName(String n) => this._name = n;

  ///get cards in hand
  List get getCards => this._cards;
  //set cards
  set setCards(List<String> l) => this._cards = l;

  ///get cardsValue in hand
  int get getCardsValue => this._cardsValue;
  //set cardsVAlue
  set setCardsValue(int i) => this._cardsValue = i;

  ///get if the person stand
  bool get getStand => this._stand;
  //set stand
  set setStand(bool b) => this._stand = b;

  ///get if the hand explode
  bool get getExplode => this._explode;
  //set explode
  set setExplode(bool b) => this._explode = b;

  ///get how many victorys have the person
  int get getVictorys => this._victorys;
  //set victorys
  set setVictorys(int i) => this._victorys = i;

  ///get how many loses have the person
  int get getLoses => this._loses;
  //set loses
  set setLoses(int i) => this._victorys = i;

  ///get if the person got it blackjack(21)
  bool get getBlackjack => this._blackjack;
  //set blackjack
  set setBlackjack(bool b) => this._blackjack = b;

  ///get person`s money
  double get getMoney => this.money;
  //set money
  set setMoney(double i) => this.money = i;

  ///get bit
  double get getBit => this.bit;
  //set money
  set setBit(double i) => this.bit = i;

  ///get dealer - return "true" case is dealer
  bool get getDealer => this._dealer;

  /// Hit - add one more card in hand
  ///
  /// [value] - value of the new card
  void hitHand(String value) {
    this.getCards.add(value);
    this.setCardsValue = getCardsTotal;
    if (this.getCardsTotal > 21) {
      this.explodeHand();
    } 
  }

  /// Split - separa as cartas e atribui um valor para cada mão cards
  void splitHand() {}

  /// Double - dobra a aposta e abre apenas uma carta
  ///
  ///[value] - value of the new card
  void doubleHand(String value) {
    hitHand(value);
    standHand();
  }

  /// Stand - stop a bit
  void standHand() => this.setStand = true;

  /// Explode - hand is above 21
  void explodeHand() => this.setExplode = true;

  /// Win - when the player win
  void win() => this.setVictorys = this.getVictorys + 1;

  /// Lose - when the player lose
  void lose() => this.setLoses = this.getLoses + 1;

  ///New round
  ///
  ///Reset the hand/attributes like [_explode], [_stand], [_cards], [_cardsValue] and [_blackjack]
  ///Already start the new round with values
  ///[d] - object type Deck
  void newRound(Deck d) {
    this.setExplode = false;
    this.setStand = false;
    this.setCards = [];
    this.setCardsValue = 0;
    this.setBlackjack = false;
  }

  ///Return the [cardsValue] of hand
  int get getCardsTotal {
    int aux = 0;
    int auxA = 0;
    for (int i = 0; i < this.getCards.length; i++) {
      switch (this.getCards[i][0]) {
        case "A":
          auxA++;
          aux += 11;
          break;
        case "2":
          aux += 2;
          break;
        case "3":
          aux += 3;
          break;
        case "4":
          aux += 4;
          break;
        case "5":
          aux += 5;
          break;
        case "6":
          aux += 6;
          break;
        case "7":
          aux += 7;
          break;
        case "8":
          aux += 8;
          break;
        case "9":
          aux += 9;
          break;
        case "1":
          aux += 10;
          break;
        case "J":
          aux += 10;
          break;
        case "Q":
          aux += 10;
          break;
        case "K":
          aux += 10;
          break;
        default:
          break;
      }
    }
    if (auxA != 0) {
      for (int i = auxA; i > 0; i--) {
        if (aux > 21) {
          aux -= 10;
        }
      }
    }
    return aux;
  }

  ///Return the [cardsValue] of hand
  int get getIndex1Value {
    int aux = 0;
    String card = this.getCards[1][0];
    switch (card) {
      case "A":
        aux += 11;
        break;
      case "2":
        aux += 2;
        break;
      case "3":
        aux += 3;
        break;
      case "4":
        aux += 4;
        break;
      case "5":
        aux += 5;
        break;
      case "6":
        aux += 6;
        break;
      case "7":
        aux += 7;
        break;
      case "8":
        aux += 8;
        break;
      case "9":
        aux += 9;
        break;
      case "1":
        aux += 10;
        break;
      case "J":
        aux += 10;
        break;
      case "Q":
        aux += 10;
        break;
      case "K":
        aux += 10;
        break;
      default:
        break;
    }

    return aux;
  }
}
