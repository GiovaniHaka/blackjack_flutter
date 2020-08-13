import 'package:twentyoneblackjack/utils/Round.dart';
import 'package:twentyoneblackjack/utils/db_sqlite.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

// How to comunicate with global keys
//https://medium.com/flutter-community/flutter-communication-between-widgets-f5590230df1e

///Card de estatísticas de vitória, derrota e empate
class StatsCard extends StatefulWidget {
  //Essa constante serve para habilitar keys na classe/widget StatsCard
  const StatsCard({Key key}) : super(key: key);

  @override
  StatsCardState createState() => StatsCardState();
}

//Essa classe não é privada para que seja possível acessá-la em outras classes com a GlobalKey();
class StatsCardState extends State<StatsCard> {
  double victorys;
  double defeats;
  double ties;
  int roundsNum;
  List<Round> _rounds = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      getDataRounds();
    });
  }

  void updateState(){
    setState(() {
      print("Stats updated");
      getDataRounds();
    });
  }

  void getDataRounds() async {
    _rounds = await DbSQLite.getData('historic');
    roundsNum = _rounds.length;
    print("aqui $_rounds");
    print("aqui lenght ${_rounds.length} ou $roundsNum");
    victorys = victoryStats(_rounds);
    defeats = defeatStats(_rounds);
    ties = tieStats(_rounds);
  }

  double victoryStats(List<Round> list) {
    var size = list.length;
    var count = 0;
    for (Round i in list) {
      if (i.state == 1) {
        count++;
      }
    }
    print("Size: $size");
    print("Count: $count");
    var result = (count / size);
    if (result.isNaN) return 0.0;
    if (!result.isNaN) print("Esse NÃO é NAN $result");
    print("Result VICTORYS: $result");
    return result;
  }

  double defeatStats(List list) {
    int size = list.length;
    int count = 0;
    for (Round i in list) {
      if (i.state == -1) {
        count++;
      }
    }
    var result = (count / size);
    print("Result DEFEATS: $result");
    if (result.isNaN) return 0.0;

    return result;
  }

  double tieStats(List list) {
    int size = list.length;
    int count = 0;
    for (Round i in list) {
      if (i.state == 0) {
        count++;
      }
    }
    var result = (count / size);
    print("Result TIES: $result");
    if (result.isNaN) return 0.0;

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: Container(
        padding: EdgeInsets.all(10),
        color: Color(0xffE5E5E5),
        child: FutureBuilder(
          future: DbSQLite.getData('historic'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  PercentIndicator("Victorys", 0.0, Colors.green),
                  PercentIndicator("Defeats", 0.0, Colors.red),
                  PercentIndicator("Ties", 0.0, Colors.blue),
                ],
              );
            } else {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  PercentIndicator("Victorys", victorys, Colors.green),
                  PercentIndicator("Defeats", defeats, Colors.red),
                  PercentIndicator("Ties", ties, Colors.blue),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class PercentIndicator extends StatelessWidget {
  final double percent;
  final String name;
  final Color color;

  PercentIndicator(this.name, this.percent, this.color);

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: (MediaQuery.of(context).size.width - 18) / 5,
      lineWidth: 8.0,
      animation: true,
      percent: percent,
      center: Text(
        percent == 0.0 || percent == null
            ? "0.0%"
            : "${(percent * 100).toStringAsFixed(1)}%",
        // : "${(percent * 100.0).toStringAsFixed(1)}%",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
      ),
      footer: Text(
        "$name",
        style: TextStyle(fontSize: 14.0),
      ),
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: color,
    );
  }
}
