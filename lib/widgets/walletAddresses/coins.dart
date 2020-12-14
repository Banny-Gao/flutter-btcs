import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../scopedModels/index.dart';

// ignore: must_be_immutable
class Coins extends StatefulWidget {
  Function choiceCoin;

  Coins({
    Key key,
    @required this.choiceCoin,
  }) : super(key: key);

  @override
  _Coin createState() => _Coin();
}

class _Coin extends State<Coins> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(builder: (context, child, model) {
      final coins = model.coins;

      return Padding(
        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
        child: ListView.builder(
          itemExtent: 80.0,
          itemCount: coins.length,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
            child: InkWell(
              onTap: () {
                widget.choiceCoin(coins[index]);
              },
              child: Card(
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Image.network(
                        coins[index].iconPath,
                        width: 24.0,
                        height: 24.0,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 12.0, right: 12.0),
                      child: Text(coins[index].currencyName),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
