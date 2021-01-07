import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../models/index.dart' as Models;
import '../../util/index.dart' as Utils;

// ignore: must_be_immutable
class Withdraw extends StatefulWidget {
  Models.Asset asset;
  Withdraw({Key key, @required this.asset}) : super(key: key);
  @override
  _Withdraw createState() => _Withdraw();
}

class _Withdraw extends State<Withdraw> {
  final _withdrawFormKey = GlobalKey<FormState>();
  TextEditingController _moneyController = TextEditingController();
  TextEditingController _remarkController = TextEditingController();

  List<Models.WalletAddress> currencyAddresses = [];

  String address;
  num money = 0;
  String remark;

  // num get serviceCharge =>
  //     widget.asset.isRollOut == 0 ? 0 : widget.asset.serviceCharge * money;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      getData();
    });
    super.initState();
  }

  @override
  // ignore: must_call_super
  dispose() {
    _moneyController.dispose();
    _remarkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.asset.currencyName)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildInfo(),
            buildTitle(),
            buildForm(),
          ],
        ),
      ),
    );
  }

  Widget buildInfo() {
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 20.0),
      child: Card(
        color: Colors.primaries[4],
        shadowColor: Colors.black54,
        child: Container(
          height: 120.0,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Stack(
              children: [
                Positioned(
                  right: 10.0,
                  height: 100.0,
                  child: Opacity(
                    opacity: 0.6,
                    child: Image.network(
                      widget.asset.iconPath,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Positioned(
                  left: 10.0,
                  top: 10.0,
                  height: 100.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                          children: [
                            TextSpan(text: '可用资产   '),
                            TextSpan(
                              text: '${widget.asset.currencyNumber}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                            )
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                          children: [
                            TextSpan(text: '冻结资产   '),
                            TextSpan(
                              text: '${widget.asset.freezeNumber}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTitle() {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 6.0),
            child: Icon(
              FontAwesomeIcons.gripVertical,
              size: 16.0,
              color: Colors.red[400],
            ),
          ),
          Expanded(
            child: Text(
              '提币',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildForm() {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Form(
        key: _withdrawFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('提币地址'),
            DropdownButtonFormField(
              hint: Text('选择地址'),
              value: address,
              style: TextStyle(
                fontSize: 12.0,
                color: Theme.of(context).primaryColor,
              ),
              items: currencyAddresses
                  .map<DropdownMenuItem<String>>(
                    (Models.WalletAddress currencyAddresses) =>
                        DropdownMenuItem(
                      child: Text(currencyAddresses.address),
                      value: currencyAddresses.address,
                    ),
                  )
                  .toList(),
              onChanged: (String value) {
                if (mounted)
                  setState(() {
                    address = value;
                  });
              },
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 20.0,
              ),
              child: Text('提币数量'),
            ),
            TextFormField(
              controller: _moneyController,
              keyboardType: TextInputType.number,
              style: TextStyle(
                fontSize: 12.0,
              ),
              decoration: InputDecoration(
                hintText: "最低转出金额为${widget.asset.minLimit}",
              ),
              validator: (val) {
                final m = double.parse(val.trim());
                if (m > widget.asset.currencyNumber) return '超出金额限制';
                if (m < widget.asset.minLimit)
                  return '最低转出${widget.asset.minLimit}';
                return null;
              },
              onSaved: (val) {
                money = double.parse(val.trim());
              },
            ),
            widget.asset.isRollOut == 0
                ? Container()
                : Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text('提现手续费: ${widget.asset.serviceCharge}',
                        style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontSize: 10.0,
                        )),
                  ),
            Padding(
              padding: EdgeInsets.only(
                top: 20.0,
                bottom: 10.0,
              ),
              child: Text('备注（选填）'),
            ),
            TextFormField(
              controller: _remarkController,
              decoration: InputDecoration(
                hintText: "仅在交易明细展示",
                border: OutlineInputBorder(),
              ),
              style: TextStyle(
                fontSize: 12.0,
              ),
              maxLines: 3,
              onSaved: (val) {
                remark = val;
              },
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 20.0,
              ),
              child: Text(
                '温馨提示:',
                style: TextStyle(color: Colors.black54, fontSize: 12.0),
              ),
            ),
            Text(
              '最小提币数量为: ${widget.asset.minLimit}${widget.asset.currencyName}',
              softWrap: true,
              style: TextStyle(color: Colors.black54, fontSize: 12.0),
            ),
            Text(
              '为保障资金安全，当您账户安全测了变更、密码修改、我们会对提币进行人工审核，请耐心等待工作人员电话联系。请务必确认电脑及浏览器安全，防止信息被篡改或泄露。您所提的数字资产为一币多链资产，无论您选择从哪个链上提出，均意味着您所拥有的该提币页面展示的数字资产总量减少相应的提出数量。',
              softWrap: true,
              style: TextStyle(color: Colors.black54, fontSize: 12.0),
            ),
            Padding(
              padding: EdgeInsets.only(top: 40.0),
              child: Row(
                children: [
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      highlightColor: Theme.of(context).primaryColorDark,
                      padding: EdgeInsets.symmetric(
                        vertical: 4.0,
                        horizontal: 6.0,
                      ),
                      child: Text(
                        "确认提币",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        submitWithdraw();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  getData() async {
    EasyLoading.show();
    try {
      getAddresses();
    } finally {
      EasyLoading.dismiss();
    }
  }

  getAddresses() async {
    final response =
        await Utils.API.getCurrencyAddress(currencyId: widget.asset.currencyId);
    final resp = Models.CurrencyAddresses.fromJson(response);

    if (resp.code == 401) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/login',
        (Route route) => false,
      );
      return;
    }
    if (resp.code != 200) return;

    if (mounted)
      setState(() {
        currencyAddresses = resp.data;
      });
  }

  submitWithdraw() async {
    final _withdrawForm = _withdrawFormKey.currentState;
    if (!_withdrawForm.validate()) return;

    _withdrawForm.save();

    final response = await Utils.API.addWithdrawAudit(
      address: address,
      currencyId: widget.asset.currencyId,
      money: money,
      serviceCharge: widget.asset.serviceCharge,
      remark: remark,
    );

    final resp = Models.NonstandardResponse.fromJson(response);

    if (resp.code == 401) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/login',
        (Route route) => false,
      );
      return;
    }
    if (resp.code != 200) return;

    Navigator.of(context).popAndPushNamed('/withdraws');
  }
}
