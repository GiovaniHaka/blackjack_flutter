class Deck {
  int _numberOfDecks;
  int _openedCards;
  int _closedCards;
  List<String> _deck = [];
  int _deckCount;

  Deck(int n) {
    this._numberOfDecks = n;
    this._deck = initDeck();
    this._openedCards = 0;
    this._closedCards = _deck.length;
    this._deckCount = 0;
  }

  ///get List deck
  List get getDeck => this._deck;
  //set List deck
  set setDeck(List<String> l) => this._deck = l;

  ///get count opened cards
  int get getOpenedCards => this._openedCards;
  //set count opened cards
  set setOpenedCards(int i) => this._openedCards = i;

  ///get count closed cards
  int get getClosedCards => this._closedCards;
  //set count closed cards
  set setClosedCards(int i) => this._closedCards = i;

  ///get deckCount
  int get getDeckCount => this._deckCount;

  ///get numberOfDecks
  int get getNumberOfDecks => this._numberOfDecks;

  /// OpenCard - open a new card in the sequence of the deck
  String openCard() {
    if (this._closedCards != 0) {
      String result = this.getDeck[(this.getNumberOfDecks * 52) - this.getClosedCards];
      this.setClosedCards = this.getClosedCards - 1;
      this.setOpenedCards = this.getOpenedCards + 1;
      countCard(result);
      return result;
    } else {
      print("Misturando novo conjunto de cartas!");
      this.getDeck.shuffle();
      this.setOpenedCards = 0;
      this.setClosedCards = this.getDeck.length;
      return this.getDeck[(this.getNumberOfDecks * 52) - this.getClosedCards];
    }
  }

  /// CountCard - check the counting of each card (+1, 0, -1)
  /// 
  /// [s] - card to be analised
  void countCard(String s) {
    switch (s[0]) {
      case "A":
        this._deckCount -= 1;
        break;
      case "2":
        this._deckCount += 1;
        break;
      case "3":
        this._deckCount += 1;
        break;
      case "4":
        this._deckCount += 1;
        break;
      case "5":
        this._deckCount += 1;
        break;
      case "6":
        this._deckCount += 1;
        break;
      case "1":
        this._deckCount -= 1;
        break;
      case "J":
        this._deckCount -= 1;
        break;
      case "Q":
        this._deckCount -= 1;
        break;
      case "K":
        this._deckCount -= 1;
        break;
      default:
        break;
    }
  }

  ///InitDeck - init a new deck with 52 cards and how many the player wants, already shuffled
  List initDeck() {
    List<String> auxDeck = [];

    for (int i = 0; i < 4; i++) {
      String suit;
      switch(i) {
        case 0:
          suit = "C"; //Clubs
          break;
        case 1:
          suit = "D"; //Diamonds
          break;
        case 2:
          suit = "H"; //Hearts
          break;
        case 3:
          suit = "S"; //Sword
          break;
      }
      auxDeck += [
        'A' + suit,
        '2' + suit,
        '3' + suit,
        '4' + suit,
        '5' + suit,
        '6' + suit,
        '7' + suit,
        '8' + suit,
        '9' + suit,
        '10' + suit,
        'J' + suit,
        'Q' + suit,
        'K' + suit
      ];
    }
    List<String> finalDeck = [];

    for (int k = 0; k < this._numberOfDecks; k++) {
      finalDeck += auxDeck;
    }
    finalDeck.shuffle();
    return finalDeck;
  }
}
