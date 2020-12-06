import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'tabIndicationPainter.dart';
import '../../common/index.dart' as Common;
import '../../util/index.dart' as Utils;
import '../../scopedModels/index.dart' as ScopeModels;
import '../../models/index.dart' as Models;

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<Login> with SingleTickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _signUpKey = GlobalKey<FormState>();
  final _signInKey = GlobalKey<FormState>();

  TextEditingController _signInPhoneController = new TextEditingController();
  TextEditingController _signInPasswordController = new TextEditingController();
  TextEditingController _signUpPhoneController = new TextEditingController();
  TextEditingController _signUpCodeController = new TextEditingController();
  TextEditingController _signUpPasswordController = new TextEditingController();
  TextEditingController _signUpPasswordRepeatController =
      new TextEditingController();
  TextEditingController _signUpInviteController = new TextEditingController();

  bool _signInObscureText = true;
  bool _signUpObscureText = true;
  bool _signUpObscureTextRepeat = true;

  bool _couldGetSignUpCode = true;
  String _signUpCodeText = "获取验证码";

  PageController _pageController;
  AnimationController _textStyleController;
  Animation _textStyleLeftAnimation;
  Animation _textStyleRightAnimation;

  Color _left = Colors.blue[600];
  Color _right = Common.Colors.whiteGradientStart;

  String _phone = '';
  String _signInPassword = '';
  String _signUpCode = '';
  String _signUpPassword = '';
  String _signUpPasswordRepeat = '';
  String _signUpInviteCode = '';

  @override
  void initState() {
    _textStyleController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    _textStyleLeftAnimation = TextStyleTween(
      begin: TextStyle(color: _left),
      end: TextStyle(color: _right),
    ).animate(_textStyleController);

    _textStyleRightAnimation = TextStyleTween(
      begin: TextStyle(color: _right),
      end: TextStyle(color: _left),
    ).animate(_textStyleController);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _pageController = PageController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
        },
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height >= 775.0
                ? MediaQuery.of(context).size.height
                : 775.0,
            decoration: new BoxDecoration(
              gradient: new LinearGradient(colors: [
                Common.Colors.whiteGradientEnd,
                Common.Colors.greenGradientEnd,
              ], stops: [
                0.0,
                1.0
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 200.0),
                  child: _buildMenuBar(context),
                ),
                Expanded(
                  flex: 1,
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (i) {
                      swapLeftAndRight();
                    },
                    children: <Widget>[
                      new ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child: _buildSignIn(context),
                      ),
                      new ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child: _buildSignUp(context),
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

  Widget _buildMenuBar(BuildContext context) {
    return Container(
      width: 300.0,
      height: 50.0,
      margin: EdgeInsets.only(bottom: 24.0),
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Common.Colors.blueGradientStart,
            offset: Offset(0.0, -4.0),
            blurRadius: 12.5,
          ),
          BoxShadow(
            color: Common.Colors.blueGradientEnd,
            offset: Offset(0.0, 4.0),
            blurRadius: 12.5,
          ),
        ],
        gradient: Common.Colors.blueGradient,
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: CustomPaint(
        painter: TabIndicationPainter(pageController: _pageController),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _onSignInButtonPress,
                child: DefaultTextStyleTransition(
                  style: _textStyleLeftAnimation,
                  child: Text(
                    "密码登录",
                    style: TextStyle(color: _left, fontSize: 16.0),
                  ),
                ),
              ),
            ),
            //Container(height: 33.0, width: 1.0, color: Colors.white),
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _onSignUpButtonPress,
                child: DefaultTextStyleTransition(
                  style: _textStyleRightAnimation,
                  child: Text(
                    "账号注册",
                    style: TextStyle(color: _right, fontSize: 16.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignIn(BuildContext context) {
    return ScopedModelDescendant<ScopeModels.AppModel>(
      builder: (context, child, model) => Form(
        key: _signInKey,
        child: Column(
          children: <Widget>[
            Card(
              elevation: 2.0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Container(
                width: 300.0,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding:
                          EdgeInsets.only(top: 10.0, left: 25.0, right: 25.0),
                      child: TextFormField(
                        autofocus: true,
                        controller: _signInPhoneController,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(fontSize: 16.0, color: Colors.black),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: FaIcon(
                            FontAwesomeIcons.phone,
                            color: Common.Colors.primaryFontColor,
                            size: 22.0,
                          ),
                          labelText: "手机号",
                        ),
                        validator: _validatePhone,
                        onSaved: (val) {
                          _phone = val.trim();
                        },
                      ),
                    ),
                    Container(
                      width: 250.0,
                      height: 1.0,
                      color: Colors.grey[400],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 10.0, bottom: 10.0, left: 25.0, right: 25.0),
                      child: TextFormField(
                          autofocus: true,
                          controller: _signInPasswordController,
                          obscureText: _signInObscureText,
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: FaIcon(
                                FontAwesomeIcons.lock,
                                size: 22.0,
                                color: Common.Colors.primaryFontColor,
                              ),
                              labelText: "密码",
                              suffixIcon: Padding(
                                padding: EdgeInsets.only(top: 16.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _signInObscureText = !_signInObscureText;
                                    });
                                  },
                                  child: FaIcon(
                                    _signInObscureText
                                        ? FontAwesomeIcons.eye
                                        : FontAwesomeIcons.eyeSlash,
                                    size: 15.0,
                                    color: Colors.black,
                                  ),
                                ),
                              )),
                          validator: _validatePassword,
                          onSaved: (val) {
                            _signInPassword = val.trim();
                          }),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Common.Colors.blueGradientStart,
                    offset: Offset(1.0, 6.0),
                    blurRadius: 20.0,
                  ),
                  BoxShadow(
                    color: Common.Colors.blueGradientEnd,
                    offset: Offset(1.0, 6.0),
                    blurRadius: 20.0,
                  ),
                ],
                gradient: Common.Colors.blueGradient,
              ),
              child: MaterialButton(
                  highlightColor: Colors.transparent,
                  // splashColor: Common.Colors.loginGradientEnd,
                  //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 40.0),
                    child: Text(
                      "登录",
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  ),
                  onPressed: () => _handleSignIn(model)),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                    onPressed: () {},
                    child: Text(
                      "短信登录?",
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: Text(
                      "忘记密码?",
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.black54,
                      ),
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

  Widget _buildSignUp(BuildContext context) {
    return ScopedModelDescendant<ScopeModels.AppModel>(
        builder: (context, child, model) => Form(
              key: _signUpKey,
              child: Column(
                children: <Widget>[
                  Card(
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Container(
                      width: 300.0,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                top: 10.0,
                                bottom: 10.0,
                                left: 25.0,
                                right: 25.0),
                            child: TextFormField(
                              autofocus: true,
                              controller: _signUpPhoneController,
                              keyboardType: TextInputType.phone,
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.black),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                icon: FaIcon(
                                  FontAwesomeIcons.phone,
                                  color: Colors.black,
                                ),
                                labelText: "手机号",
                              ),
                              validator: _validatePhone,
                              onSaved: (val) {
                                _phone = val.trim();
                              },
                            ),
                          ),
                          Container(
                            width: 250.0,
                            height: 1.0,
                            color: Colors.grey[400],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 10.0,
                                bottom: 10.0,
                                left: 25.0,
                                right: 25.0),
                            child: TextFormField(
                                autofocus: true,
                                controller: _signUpCodeController,
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.black),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: FaIcon(
                                    FontAwesomeIcons.shieldAlt,
                                    size: 22.0,
                                    color: Common.Colors.primaryFontColor,
                                  ),
                                  labelText: "验证码",
                                  suffixIcon: Padding(
                                    padding: EdgeInsets.only(top: 16.0),
                                    child: GestureDetector(
                                      onTap: _handleGetRegisterCode,
                                      child: Text(
                                        _signUpCodeText,
                                        style: TextStyle(
                                          color:
                                              Common.Colors.blueGradientStart,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                validator: (val) {
                                  return Utils.Re.number.hasMatch(val.trim())
                                      ? null
                                      : Utils.Constants.codeErrorText;
                                },
                                onSaved: (val) {
                                  _signUpCode = val.trim();
                                }),
                          ),
                          Container(
                            width: 250.0,
                            height: 1.0,
                            color: Colors.grey[400],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 10.0,
                                bottom: 10.0,
                                left: 25.0,
                                right: 25.0),
                            child: TextFormField(
                              autofocus: true,
                              controller: _signUpPasswordController,
                              obscureText: _signUpObscureText,
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.black),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: FaIcon(
                                    FontAwesomeIcons.lock,
                                    size: 22.0,
                                    color: Common.Colors.primaryFontColor,
                                  ),
                                  labelText: "密码",
                                  suffixIcon: Padding(
                                    padding: EdgeInsets.only(top: 16.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _signUpObscureText =
                                              !_signUpObscureText;
                                        });
                                      },
                                      child: FaIcon(
                                        _signUpObscureText
                                            ? FontAwesomeIcons.eye
                                            : FontAwesomeIcons.eyeSlash,
                                        size: 15.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  )),
                              validator: _validatePassword,
                              onSaved: (val) {
                                _signUpPassword = val.trim();
                              },
                            ),
                          ),
                          Container(
                            width: 250.0,
                            height: 1.0,
                            color: Colors.grey[400],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 10.0,
                                bottom: 10.0,
                                left: 25.0,
                                right: 25.0),
                            child: TextFormField(
                              autofocus: true,
                              controller: _signUpPasswordRepeatController,
                              obscureText: _signUpObscureTextRepeat,
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.black),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: FaIcon(
                                    FontAwesomeIcons.lock,
                                    size: 22.0,
                                    color: Common.Colors.primaryFontColor,
                                  ),
                                  labelText: "确认密码",
                                  suffixIcon: Padding(
                                    padding: EdgeInsets.only(top: 16.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _signUpObscureTextRepeat =
                                              !_signUpObscureTextRepeat;
                                        });
                                      },
                                      child: FaIcon(
                                        _signUpObscureTextRepeat
                                            ? FontAwesomeIcons.eye
                                            : FontAwesomeIcons.eyeSlash,
                                        size: 15.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  )),
                              validator: _validatePassword,
                              onSaved: (val) {
                                _signUpPasswordRepeat = val.trim();
                              },
                            ),
                          ),
                          Container(
                            width: 250.0,
                            height: 1.0,
                            color: Colors.grey[400],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 10.0,
                                bottom: 10.0,
                                left: 25.0,
                                right: 25.0),
                            child: TextFormField(
                                autofocus: true,
                                controller: _signUpInviteController,
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.black),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: FaIcon(
                                    FontAwesomeIcons.comments,
                                    size: 22.0,
                                    color: Common.Colors.primaryFontColor,
                                  ),
                                  labelText: "邀请码",
                                ),
                                onSaved: (val) {
                                  _signUpInviteCode = val.trim();
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Common.Colors.blueGradientStart,
                          offset: Offset(1.0, 6.0),
                          blurRadius: 20.0,
                        ),
                        BoxShadow(
                          color: Common.Colors.blueGradientEnd,
                          offset: Offset(1.0, 6.0),
                          blurRadius: 20.0,
                        ),
                      ],
                      gradient: Common.Colors.blueGradient,
                    ),
                    child: MaterialButton(
                      highlightColor: Colors.transparent,
                      // splashColor: Common.Colors.loginGradientEnd,
                      //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Text(
                          "注册",
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      ),
                      onPressed: () => _handleSignUp(model),
                    ),
                  ),
                ],
              ),
            ));
  }

  @override
  void dispose() {
    _pageController?.dispose();
    _textStyleController?.dispose();
    super.dispose();
  }

  void swapLeftAndRight() {
    final temp = _left;
    _left = _right;
    _right = temp;

    setState(() => {_left = _left, _right = _right});
    _textStyleController.forward();
  }

  void _onSignUpButtonPress() {
    _pageController?.animateToPage(1,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _onSignInButtonPress() {
    _pageController.animateToPage(0,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  String _validatePhone(String value) {
    return Utils.Re.phone.hasMatch(value.trim())
        ? null
        : Utils.Constants.phoneErrorText;
  }

  String _validatePassword(String value) {
    return Utils.Re.passWord.hasMatch(value.trim())
        ? null
        : Utils.Constants.passwordErrorText;
  }

  void _handleGetRegisterCode() {}

  void _handleSignUp(model) async {
    final _signUpForm = _signUpKey.currentState;
    if (!_signUpForm.validate()) return;

    _signUpForm.save();

    if (_signUpPassword != _signUpPasswordRepeat) {
      EasyLoading.showError(Utils.Constants.passwordRepeatErrorText);
      return;
    }

    final response = await Utils.API.signUp(
      phone: _phone,
      code: _signUpCode,
      password: _signUpPassword,
      inviteCode: _signUpInviteCode,
    );

    final resp = Models.UserSignResponse.fromJson(response);
    bool isLogin = resp.code == 200;

    if (!isLogin) return;

    model.toggleLogStatus(isLogin,
        token: resp.data?.token, phone: resp.data?.phone);

    Navigator.of(context).pushReplacementNamed('/');
  }

  void _handleSignIn(model) async {
    final _signInForm = _signInKey.currentState;

    if (!_signInForm.validate()) return;

    _signInForm.save();

    final response = await Utils.API.passwordSignIn(
      phone: _phone,
      password: _signInPassword,
    );

    final resp = Models.UserSignResponse.fromJson(response);
    bool isLogin = resp.code == 200;

    if (!isLogin) return;

    model.toggleLogStatus(isLogin,
        token: resp.data?.token, phone: resp.data?.phone);

    Navigator.of(context).pushReplacementNamed('/');
  }
}
