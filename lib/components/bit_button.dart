import 'package:flutter/material.dart';

class BitButton extends StatelessWidget {
  final Function removeBit;
  final Function addBit;
  final double bit;

  BitButton(
      {@required this.bit, @required this.removeBit, @required this.addBit});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
          child: GestureDetector(
            onTap: removeBit,
            child: Container(
              width: 50,
              height: 50,
              color: Colors.blueGrey[200],
              child: Icon(
                Icons.remove,
                color: Theme.of(context).backgroundColor,
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: 80,
          height: 50,
          color: Colors.grey[300],
          child: Text(
            bit.toStringAsFixed(0),
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(fontWeight: FontWeight.w200),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
          child: GestureDetector(
            onTap: addBit,
            child: Container(
              width: 50,
              height: 50,
              color: Colors.blueGrey[200],
              child: Icon(
                Icons.add,
                color: Theme.of(context).backgroundColor,
              ),
            ),
          ),
        )
      ],
    );
  }
}
