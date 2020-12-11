import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NewWalletAddress extends StatefulWidget {
  NewWalletAddress({Key key}) : super(key: key);

  @override
  _NewWalletAddress createState() => _NewWalletAddress();
}

class _NewWalletAddress extends State<NewWalletAddress> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('新建地址'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0, bottom: 40.0),
          child: Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.btc,
                        color: Colors.primaries[
                            Random().nextInt(17) % Colors.primaries.length],
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Icon(
                        FontAwesomeIcons.chevronRight,
                        size: 16.0,
                        color: Theme.of(context).indicatorColor,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
