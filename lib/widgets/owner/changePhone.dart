import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../scopedModels/index.dart';
import '../../models/index.dart' as Models;
import '../../util/index.dart' as Utils;

// ignore: must_be_immutable
class ChangePhone extends StatefulWidget {
  num mode;
  ChangePhone({Key key, @required this.mode}) : super(key: key);

  @override
  _ChangePhone createState() => _ChangePhone();
}

class _ChangePhone extends State<ChangePhone> {
  Models.User user = ProfileModel.profile.user;

  final _formKey = GlobalKey<FormState>();

  TextEditingController _phoneController = TextEditingController();
  TextEditingController _codeController = new TextEditingController();
  FocusNode _phoneFocusNode = FocusNode();
  String _phone = '';
  String _code = '';

  Timer _timer;
  var countdownTime = 0;

  String title = '';
  String actionTitle = '';
  String phoneText = '';

  @override
  void initState() {
    super.initState();

    switch (widget.mode) {
      case 0:
        title = '修改手机号';
        actionTitle = '保存';
        phoneText = '请输入新手机号';
        break;
      case 1:
        title = "短信登录";
        actionTitle = '登录';
        phoneText = '请输入手机号';
        break;
      default:
        title = "重置密码";
        actionTitle = '下一步';
        phoneText = '请输入手机号';
    }

    _phoneFocusNode.addListener(() {
      if (!_phoneFocusNode.hasFocus) {
        final value = _phoneController.text;
        if (Utils.Re.phone.hasMatch(value.trim())) {
          setState(() {
            _phone = value;
          });
        } else {
          setState(() {
            _phone = '';
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
      builder: (context, child, model) => Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: [
            FlatButton(
              child: Text(actionTitle),
              onPressed: () {
                _handleSave(model);
              },
            )
          ],
        ),
        body: _buildUserForm(),
      ),
    );
  }

  Widget _buildUserForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: 20.0, bottom: 10.0, left: 25.0, right: 25.0),
            child: TextFormField(
              autofocus: true,
              focusNode: _phoneFocusNode,
              controller: _phoneController,
              onChanged: (value) {
                if (Utils.Re.phone.hasMatch(value.trim())) {
                  setState(() {
                    _phone = value;
                  });
                } else {
                  setState(() {
                    _phone = '';
                  });
                }
              },
              keyboardType: TextInputType.phone,
              style: TextStyle(fontSize: 16.0, color: Colors.black),
              decoration: InputDecoration(
                hintText: phoneText,
              ),
              validator: _validatePhone,
              onSaved: (val) {
                _phone = val.trim();
              },
            ),
          ),
          widget.mode == 2
              ? Container()
              : Padding(
                  padding: EdgeInsets.only(
                      top: 10.0, bottom: 10.0, left: 25.0, right: 25.0),
                  child: TextFormField(
                      autofocus: true,
                      controller: _codeController,
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                      decoration: InputDecoration(
                        hintText: "验证码",
                        suffixIcon: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: RaisedButton(
                            onPressed: Utils.Re.phone.hasMatch(
                                      _phone.trim(),
                                    ) &&
                                    countdownTime == 0
                                ? _handleGetCode
                                : null,
                            child: Text(
                              countdownTime > 0
                                  ? '${countdownTime}s后重新获取'
                                  : '获取验证码',
                            ),
                          ),
                        ),
                      ),
                      validator: (val) {
                        return Utils.Re.number.hasMatch(val.trim())
                            ? null
                            : Utils.Tips.codeErrorText;
                      },
                      onSaved: (val) {
                        _code = val.trim();
                      }),
                ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _phoneController?.dispose();
    _codeController?.dispose();

    if (_timer != null) {
      _timer.cancel();
    }
    super.dispose();
  }

  String _validatePhone(String value) {
    return Utils.Re.phone.hasMatch(value.trim())
        ? null
        : Utils.Tips.phoneErrorText;
  }

  startCountdown() {
    countdownTime = 60;
    final call = (timer) {
      setState(() {
        if (countdownTime < 1) {
          _timer.cancel();
        } else {
          countdownTime -= 1;
        }
      });
    };
    _timer = Timer.periodic(Duration(seconds: 1), call);
  }

  void _handleGetCode() async {
    final response = await Utils.API.getCode(_phone, widget.mode == 0 ? 1 : 4);
    final resp = Models.ResponseBasic.fromJson(response);
    if (resp.code != 200) return;

    EasyLoading.showSuccess(Utils.Tips.signUpCodeSendSuccess);
    if (countdownTime == 0) {
      startCountdown();
    }
  }

  _handleSave(AppModel model) async {
    final _userForm = _formKey.currentState;

    if (!_userForm.validate()) return;
    _userForm.save();

    switch (widget.mode) {
      case 0:
        handleChangePhone();
        break;
      case 1:
        handlePhoneLogin(model);
        break;
      default:
        handleChangePassword();
    }
  }

  handleChangePhone() async {
    final response = await Utils.API.changePhone(
      memberPhone: _phone,
      code: _code,
    );

    final resp = Models.NonstandardResponse.fromJson(response);

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
    EasyLoading.showInfo('手机号修改成功，请重新登录');

    Navigator.of(context).popAndPushNamed('/login');
  }

  handlePhoneLogin(model) async {
    final response = await Utils.API.codeSignIn(
      phone: _phone,
      code: _code,
    );

    final resp = Models.UserSignResponse.fromJson(response);
    bool isLogin = resp.code == 200;

    if (!isLogin) return;

    await model.toggleLogStatus(isLogin,
        token: resp.data?.token, phone: resp.data?.phone);

    Navigator.of(context).popAndPushNamed('/');
  }

  handleChangePassword() {
    Navigator.of(context).popAndPushNamed('/changePassword', arguments: {
      'phone': _phone,
    });
  }
}
