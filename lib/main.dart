import 'package:twentyoneblackjack/screens/hard_hand_screen.dart';
import 'package:twentyoneblackjack/screens/historic_screen.dart';
import 'package:twentyoneblackjack/screens/home_screen.dart';
import 'package:twentyoneblackjack/screens/play_memorize.dart';
import 'package:twentyoneblackjack/screens/select_memorize_screen.dart';
import 'package:twentyoneblackjack/screens/select_strategy_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/play_blackJack.dart';
//https://www.svgrepo.com/vectors/cards/6

void main() {
  //Quando se acessa dados é necessário chamar esta função
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          TextTheme(
            button: TextStyle(
              fontSize: 17,
            ),
            headline6: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xff090265),
            ),
            //Title person hand
            headline5: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xff090265),
            ),
            subtitle1: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color(0xff090265),
            ),
          ),
        ),
        accentColor: Color(0xff090265),
        backgroundColor: Color(0xffF0F0F0),
      ),
      initialRoute: "/",
      routes: {
        '/': (context) => Home(),
        '/blackjack': (context) => BlackJack(),
        '/historic': (context) => Historic(),
        '/selectStrategy': (context) => SelectStrategy(),
        '/hardhandgame': (context) => HardHandGame(),
        '/selectMemorize': (context) => SelectMemorize(),
        '/memorize': (context) => Memorize(),
      },
    ),
  );
}
//  WidgetsFlutterBinding.ensureInitialized();


