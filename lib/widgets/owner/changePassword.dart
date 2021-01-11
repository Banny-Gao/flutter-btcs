import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../scopedModels/index.dart';
import '../../models/index.dart' as Models;
import '../../util/index.dart' as Utils;
import '../../common/index.dart' as Common;

class ChangePassword extends StatefulWidget {
  final phone;
  ChangePassword({Key key, this.phone}) : super(key: key);

  @override
  _ChangePassword createState() => _ChangePassword();
}

class _ChangePassword extends State<ChangePassword> {
  Models.User user = ProfileModel.profile.user;

  final _formKey = GlobalKey<FormState>();

  TextEditingController _passwordController = TextEditingController();
  String _password;
  bool _obscureText = true;
  String _code = '';

  Timer _timer;

  TextEditingController _codeController = new TextEditingController();
  var countdownTime = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((val) {
      _handleGetCode();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
      builder: (context, child, model) => Scaffold(
        appBar: AppBar(
          title: Text('修改密码'),
          actions: [
            FlatButton(
              child: Text('保存'),
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
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: 10.0, bottom: 10.0, left: 25.0, right: 25.0),
            child: TextFormField(
              autofocus: true,
              controller: _passwordController,
              obscureText: _obscureText,
              style: TextStyle(fontSize: 16.0, color: Colors.black),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: FaIcon(
                    FontAwesomeIcons.lock,
                    size: 22.0,
                    color: Common.Colors.primaryFontColor,
                  ),
                  labelText: "请输入新密码",
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: FaIcon(
                        _obscureText
                            ? FontAwesomeIcons.eye
                            : FontAwesomeIcons.eyeSlash,
                        size: 15.0,
                        color: Colors.black,
                      ),
                    ),
                  )),
              validator: _validatePassword,
              onSaved: (val) {
                _password = val.trim();
              },
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.only(
                top: 10.0, bottom: 10.0, left: 25.0, right: 25.0),
            child: TextFormField(
                autofocus: true,
                controller: _codeController,
                style: TextStyle(fontSize: 16.0, color: Colors.black),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: FaIcon(
                    FontAwesomeIcons.shieldAlt,
                    size: 22.0,
                    color: Common.Colors.primaryFontColor,
                  ),
                  labelText: "验证码",
                  suffixIcon: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: RaisedButton(
                      onPressed: countdownTime == 0 ? _handleGetCode : null,
                      child: Text(
                        countdownTime > 0 ? '${countdownTime}s后重新获取' : '获取验证码',
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
    _passwordController?.dispose();
    _codeController?.dispose();

    if (_timer != null) {
      _timer.cancel();
    }
    super.dispose();
  }

  String _validatePassword(String value) {
    return Utils.Re.passWord.hasMatch(value.trim())
        ? null
        : Utils.Tips.passwordErrorText;
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
    final phone =
        widget.phone != null ? widget.phone : ProfileModel.profile.phone;
    EasyLoading.show();
    final response = await Utils.API.getCode(phone, 5);
    final resp = Models.ResponseBasic.fromJson(response);
    EasyLoading.dismiss();
    if (resp.code != 200) {
      EasyLoading.showError(resp.message);
      return;
    }

    EasyLoading.showSuccess(Utils.Tips.signUpCodeSendSuccess);
    if (countdownTime == 0) {
      startCountdown();
    }
  }

  _handleSave(AppModel model) async {
    final _userForm = _formKey.currentState;

    if (!_userForm.validate()) return;
    _userForm.save();

    final response = await Utils.API.changePassword(
      phone: ProfileModel.profile.phone,
      code: _code,
      newPassword: _password,
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
    EasyLoading.showInfo('密码修改成功，请重新登录');

    Navigator.of(context).popAndPushNamed('/login');
  }
}
