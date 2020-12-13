import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../models/index.dart' as Models;
import '../../util/index.dart' as Utils;

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
  List<Models.Coin> coins = [];

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero).then((value) {
      _getData();
      ;
    });
  }

  @override
  Widget build(BuildContext context) {
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
  }

  _getData() async {
    final response = await Utils.API.getCoinTypes();
    final resp = Models.CoinsResponse.fromJson(response);

    if (resp.code != 200) {
      EasyLoading.showError(resp.message);
      return;
    }

    if (mounted) {
      setState(() {
        coins = resp.data;
      });
    }
  }
}
