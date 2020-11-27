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

  TextEditingController loginPhoneController = new TextEditingController();
  TextEditingController loginPasswordController = new TextEditingController();

  bool _obscureTextLogin = true;

  PageController _pageController;
  AnimationController _textStyleController;
  Animation _textStyleLeftAnimation;
  Animation _textStyleRightAnimation;

  Color _left = Colors.blue[600];
  Color _right = Common.Colors.whiteGradientStart;

  String _phone;
  String _password;

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
        handlePhoneChanged(loginPhoneController.text);
      }
    });

    myFocusNodePasswordLogin.addListener(() {
      if (!myFocusNodePasswordLogin.hasFocus) {
        // TextField has lost focus
        handlePasswordChanged(loginPasswordController.text);
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
                        child: _buildCodeLogin(context),
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
                    "短信登录",
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
                        EdgeInsets.only(top: 20.0, left: 25.0, right: 25.0),
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
                      onSubmitted: handlePhoneChanged,
                    ),
                  ),
                  Container(
                    width: 250.0,
                    height: 1.0,
                    color: Colors.grey[400],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
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

  Widget _buildCodeLogin(BuildContext context) {
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
              height: 110.0,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                    child: TextField(
                      focusNode: myFocusNodePhoneLogin,
                      controller: loginPhoneController,
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
                      onSubmitted: handlePhoneChanged,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 90.0),
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
                    "获取验证码",
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                ),
                onPressed: () => {}),
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

  void handlePhoneChanged(value) {
    if (!Utils.Re.phone.hasMatch(value)) {
      Common.Alert.error(Utils.Constants.phoneErrorText,
          currentState: _scaffoldKey.currentState);
      return;
    }

    setState(() => {_phone = value});
  }

  void handlePasswordChanged(value) {
    if (!Utils.Re.passWord.hasMatch(value)) {
      Common.Alert.error(Utils.Constants.passwordErrorText,
          currentState: _scaffoldKey.currentState);
      return;
    }

    setState(() => {_password = value});
  }

  void _onSignInButtonPress() {
    _pageController.animateToPage(0,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _onSignUpButtonPress() {
    _pageController?.animateToPage(1,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }
}
