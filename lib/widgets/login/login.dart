import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'tabIndicationPainter.dart';
import '../../common/index.dart' as Common;
import '../../util/index.dart' as Utils;

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<Login> with SingleTickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final FocusNode myFocusNodePhoneLogin = FocusNode();
  final FocusNode myFocusNodePasswordLogin = FocusNode();
  final FocusNode myFocusNodePhoneRegister = FocusNode();
  final FocusNode myFocusNodeCodeRegister = FocusNode();
  final FocusNode myFocusNodePasswordRegister = FocusNode();
  final FocusNode myFocusNodeRepeatPasswordRegister = FocusNode();
  final FocusNode myFocusNodeInviteRegister = FocusNode();

  TextEditingController loginPhoneController = new TextEditingController();
  TextEditingController loginPasswordController = new TextEditingController();
  TextEditingController registerPhoneController = new TextEditingController();
  TextEditingController registerCodeController = new TextEditingController();
  TextEditingController registerPasswordController =
      new TextEditingController();
  TextEditingController registerPasswordRepeatController =
      new TextEditingController();
  TextEditingController registerInviteController = new TextEditingController();

  bool _obscureTextLogin = true;
  bool _obscureTextRegister = true;
  bool _obscureTextRepeatRegister = true;
  bool _couldGetRegisterCode = true;

  String _registerCodeText = "获取验证码";

  PageController _pageController;
  AnimationController _textStyleController;
  Animation _textStyleLeftAnimation;
  Animation _textStyleRightAnimation;

  Color _left = Colors.blue[600];
  Color _right = Common.Colors.whiteGradientStart;

  String _phone = '';
  String _loginPassword = '';
  String _registerCode = '';
  String _registerPassword = '';
  String _registerPasswordRepeat = '';
  String _registerInviteCode = '';

  @override
  void initState() {
    super.initState();

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

    myFocusNodePhoneLogin.addListener(() {
      if (!myFocusNodePhoneLogin.hasFocus) {
        // TextField has lost focus
        _handlePhoneChanged(loginPhoneController.text);
      }
    });

    myFocusNodePasswordLogin.addListener(() {
      if (!myFocusNodePasswordLogin.hasFocus) {
        // TextField has lost focus
        final String value = _handlePasswordChanged(
          loginPasswordController.text,
        );

        setState(() {
          _loginPassword = value;
        });
      }
    });

    myFocusNodePhoneRegister.addListener(() {
      if (!myFocusNodePhoneRegister.hasFocus) {
        // TextField has lost focus
        _handlePhoneChanged(registerPhoneController.text);
      }
    });

    myFocusNodeCodeRegister.addListener(() {
      if (!myFocusNodeCodeRegister.hasFocus) {
        // TextField has lost focus
        _handleCodeRegisterChanged(registerCodeController.text);
      }
    });

    myFocusNodePasswordRegister.addListener(() {
      if (!myFocusNodePasswordRegister.hasFocus) {
        // TextField has lost focus
        final String value = _handlePasswordChanged(
          registerPasswordController.text,
        );

        setState(() {
          _registerPassword = value;
        });
      }
    });

    myFocusNodeRepeatPasswordRegister.addListener(() {
      if (!myFocusNodeRepeatPasswordRegister.hasFocus) {
        // TextField has lost focus
        final String value = _handlePasswordChanged(
          registerPasswordRepeatController.text,
        );

        if (value != '' && _validateRepeatPassword(value))
          setState(() {
            _registerPasswordRepeat = value;
          });
      }
    });

    myFocusNodeInviteRegister.addListener(() {
      if (!myFocusNodeInviteRegister.hasFocus) {
        // TextField has lost focus
        _handleInviteCodeRegisterChanged(registerInviteController.text);
      }
    });
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
    return Container(
      padding: EdgeInsets.only(top: 23.0),
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
                    child: TextField(
                      focusNode: myFocusNodePhoneLogin,
                      controller: loginPhoneController,
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
                      onSubmitted: _handlePhoneChanged,
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
                    child: TextField(
                      focusNode: myFocusNodePasswordLogin,
                      controller: loginPasswordController,
                      obscureText: _obscureTextLogin,
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
                              onTap: _toggleLogin,
                              child: FaIcon(
                                _obscureTextLogin
                                    ? FontAwesomeIcons.eye
                                    : FontAwesomeIcons.eyeSlash,
                                size: 15.0,
                                color: Colors.black,
                              ),
                            ),
                          )),
                    ),
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
                onPressed: () => {}),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: FlatButton(
                onPressed: () {},
                child: Text(
                  "忘记密码?",
                  style: TextStyle(
                      decoration: TextDecoration.underline, fontSize: 14.0),
                )),
          ),
        ],
      ),
    );
  }

  Widget _buildSignUp(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 23.0),
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
                    padding: EdgeInsets.only(
                        top: 10.0, bottom: 10.0, left: 25.0, right: 25.0),
                    child: TextField(
                      focusNode: myFocusNodePhoneRegister,
                      controller: registerPhoneController,
                      keyboardType: TextInputType.phone,
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: FaIcon(
                          FontAwesomeIcons.phone,
                          color: Colors.black,
                        ),
                        labelText: "手机号",
                      ),
                      onSubmitted: _handlePhoneChanged,
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
                    child: TextField(
                      focusNode: myFocusNodeCodeRegister,
                      controller: registerCodeController,
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                      onSubmitted: _handleCodeRegisterChanged,
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
                              _registerCodeText,
                              style: TextStyle(
                                color: Common.Colors.blueGradientStart,
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                        ),
                      ),
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
                    child: TextField(
                      focusNode: myFocusNodePasswordRegister,
                      controller: registerPasswordController,
                      obscureText: _obscureTextRegister,
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
                              onTap: _toggleRegisterPassword,
                              child: FaIcon(
                                _obscureTextRegister
                                    ? FontAwesomeIcons.eye
                                    : FontAwesomeIcons.eyeSlash,
                                size: 15.0,
                                color: Colors.black,
                              ),
                            ),
                          )),
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
                    child: TextField(
                      focusNode: myFocusNodeRepeatPasswordRegister,
                      controller: registerPasswordRepeatController,
                      obscureText: _obscureTextRepeatRegister,
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
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
                              onTap: _toggleRegisterPasswordRepeat,
                              child: FaIcon(
                                _obscureTextRepeatRegister
                                    ? FontAwesomeIcons.eye
                                    : FontAwesomeIcons.eyeSlash,
                                size: 15.0,
                                color: Colors.black,
                              ),
                            ),
                          )),
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
                    child: TextField(
                      focusNode: myFocusNodeInviteRegister,
                      controller: registerInviteController,
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                      onSubmitted: _handleInviteCodeRegisterChanged,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: FaIcon(
                          FontAwesomeIcons.comments,
                          size: 22.0,
                          color: Common.Colors.primaryFontColor,
                        ),
                        labelText: "邀请码",
                      ),
                    ),
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
              onPressed: _handleSignUp,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    loginPhoneController.dispose();
    myFocusNodePasswordLogin.dispose();
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

  bool _validateCode(value) {
    if (!Utils.Re.number.hasMatch(value)) {
      Common.Alert.error(Utils.Constants.codeErrorText,
          currentState: _scaffoldKey.currentState);
      return false;
    }

    return true;
  }

  bool _validatePhone(value) {
    if (!Utils.Re.phone.hasMatch(value)) {
      Common.Alert.error(Utils.Constants.phoneErrorText,
          currentState: _scaffoldKey.currentState);
      return false;
    }
    return true;
  }

  bool _validatePassword(value) {
    if (!Utils.Re.passWord.hasMatch(value)) {
      Common.Alert.error(Utils.Constants.passwordErrorText,
          currentState: _scaffoldKey.currentState);
      return false;
    }
    return true;
  }

  bool _validateRepeatPassword(value) {
    if (value == _registerPassword) return true;

    Common.Alert.error(Utils.Constants.passwordRepeatErrorText,
        currentState: _scaffoldKey.currentState);
    return false;
  }

  void _handlePhoneChanged(value) {
    if (_validatePhone(value)) setState(() => {_phone = value});
  }

  String _handlePasswordChanged(value) {
    if (!_validatePassword(value)) return '';
    return value;
  }

  void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }

  void _toggleRegisterPassword() {
    setState(() {
      _obscureTextRegister = !_obscureTextRegister;
    });
  }

  void _toggleRegisterPasswordRepeat() {
    setState(() {
      _obscureTextRepeatRegister = !_obscureTextRepeatRegister;
    });
  }

  void _handleGetRegisterCode() {}

  void _handleCodeRegisterChanged(value) {
    if (_validateCode(value)) setState(() => {_registerCode = value});
  }

  void _handleInviteCodeRegisterChanged(value) {
    setState(() => {_registerInviteCode = value});
  }

  void _blurForms() {
    myFocusNodePhoneLogin.unfocus();
    myFocusNodePasswordLogin.unfocus();
    myFocusNodePhoneRegister.unfocus();
    myFocusNodeCodeRegister.unfocus();
    myFocusNodePasswordRegister.unfocus();
    myFocusNodeRepeatPasswordRegister.unfocus();
    myFocusNodeInviteRegister.unfocus();
  }

  bool _validateSignUpParams() {
    return _validatePhone(_phone) &&
        _validateCode(_registerCode) &&
        _validatePassword(_registerPassword) &&
        _validatePassword(_registerPasswordRepeat) &&
        _validateRepeatPassword(_registerPasswordRepeat);
  }

  void _handleSignUp() async {
    _blurForms();
    final isValidate = _validateSignUpParams();
    if (!isValidate) return;

    await Utils.API.signUp(
      phone: _phone,
      code: _registerCode,
      password: _registerPasswordRepeat,
      inviteCode: _registerInviteCode,
    );
  }
}
