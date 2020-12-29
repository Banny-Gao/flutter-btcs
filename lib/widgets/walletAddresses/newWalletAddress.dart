import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:scoped_model/scoped_model.dart';

import 'coins.dart';
import '../../scopedModels/index.dart';
import '../../models/index.dart' as Models;
import '../../util/index.dart' as Utils;

class NewWalletAddress extends StatefulWidget {
  final Function refreshWalletAddresses;
  final currencyId;
  final addressId;
  final address;
  final memberId;
  NewWalletAddress({
    Key key,
    @required this.refreshWalletAddresses,
    this.currencyId,
    this.addressId,
    this.address,
    this.memberId,
  }) : super(key: key);

  @override
  _NewWalletAddress createState() => _NewWalletAddress();
}

class _NewWalletAddress extends State<NewWalletAddress> {
  final _walletAddressFormKey = GlobalKey<FormState>();

  TextEditingController _walletAddressController = TextEditingController();

  num coinChoicedId;
  String coinChoicedIdTitle;
  String coinChoicedIconPath;
  String walletAddress;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => ScopedModelDescendant<AppModel>(
        builder: (context, child, model) {
          if (widget.addressId != null) {
            final coin = _getCoinById(model.coins, widget.currencyId);

            walletAddress = widget.address;
            _walletAddressController.text = widget.address;
            coinChoicedId = coin?.currencyId;
            coinChoicedIdTitle = coin?.currencyName;
            coinChoicedIconPath = coin?.iconPath;
          }

          return Scaffold(
            appBar: AppBar(
              title: Text('新建地址'),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 40.0, bottom: 40.0),
                child: Column(
                  children: [
                    buildCoinType(context),
                    buildCoinAddress(context),
                    buildButton(context),
                  ],
                ),
              ),
            ),
          );
        },
      );

  Widget buildCoinType(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: InkWell(
        onTap: _showCoinChoice,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              coinChoicedIconPath != null
                  ? Image.network(
                      coinChoicedIconPath,
                      width: 24.0,
                      height: 24.0,
                      fit: BoxFit.fill,
                    )
                  : Padding(
                      padding: EdgeInsets.only(left: 24.0),
                    ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text(
                    coinChoicedId != null ? coinChoicedIdTitle : '请选择币种',
                    style: TextStyle(
                      color: coinChoicedId != null
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).disabledColor,
                    ),
                  ),
                ),
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
    );
  }

  Widget buildCoinAddress(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text('币种地址'),
                  ),
                  // InkWell(
                  //   onTap: _scanQR,
                  //   child: Icon(FontAwesomeIcons.qrcode),
                  // ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Form(
                  key: _walletAddressFormKey,
                  child: TextFormField(
                    controller: _walletAddressController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: "输入或长按复制粘贴",
                      contentPadding: EdgeInsets.all(10.0),
                      isDense: true,
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                    validator: (val) =>
                        val.trim().length == 0 ? '币种地址不能为空' : null,
                    onSaved: (val) {
                      walletAddress = val.trim();
                    },
                  ),
                ),
              ),
              // walletAddress != null
              //     ? Center(
              //         child: QrImage(
              //           data: walletAddress,
              //           version: QrVersions.auto,
              //           size: 200.0,
              //         ),
              //       )
              //     : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40.0),
      child: RaisedButton(
        onPressed: _handleNewWalletAddress,
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: EdgeInsets.fromLTRB(60.0, 12.0, 60.0, 12.0),
          child: Text(
            '保存',
            style: TextStyle(
              color: Theme.of(context).bottomAppBarColor,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }

  @override
  // ignore: must_call_super
  dispose() {
    _walletAddressController.dispose();
    super.dispose();
  }

  _showCoinChoice() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Coins(choiceCoin: choiceCoin),
    );
  }

  choiceCoin(coin) {
    Navigator.of(context).pop();
    setState(() {
      coinChoicedId = coin.currencyId;
      coinChoicedIdTitle = coin.currencyName;
      coinChoicedIconPath = coin.iconPath;
    });
  }

  Future<void> _scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#fff", "取消", true, ScanMode.QR);
    } on PlatformException {
      EasyLoading.showError("Failed to get platform version.");
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted || barcodeScanRes == -1) return;
    setState(() {
      walletAddress = barcodeScanRes;
      _walletAddressController.text = barcodeScanRes;
    });
  }

  _handleNewWalletAddress() async {
    if (coinChoicedId == null) {
      EasyLoading.showError(Utils.Tips.choiceCoinEmpty);
      return;
    }
    final _walletAddressForm = _walletAddressFormKey.currentState;
    if (!_walletAddressForm.validate()) return;
    _walletAddressForm.save();

    dynamic response;
    dynamic resp;

    if (widget.addressId != null) {
      response = await Utils.API.updateWalletAddress(
        address: walletAddress,
        currencyId: coinChoicedId,
        id: widget.addressId,
        memberId: widget.memberId,
      );
      resp = Models.UpdateWalletAddressResponse.fromJson(response);
    } else {
      response = await Utils.API.addWalletAddress(
        address: walletAddress,
        currencyId: coinChoicedId,
      );
      resp = Models.AddWalletAddressesResponse.fromJson(response);
    }

    if (resp.code == 401) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/login',
        (Route route) => false,
      );
      return;
    }

    if (resp.code != 200) {
      EasyLoading.showError(resp.message);
      return;
    }

    widget.refreshWalletAddresses();
    Navigator.of(context).pop();
  }

  _getCoinById(coins, id) {
    final coin = coins.length != 0
        ? coins.singleWhere((coin) => coin.currencyId == id)
        : null;
    return coin != null ? coin : null;
  }
}
