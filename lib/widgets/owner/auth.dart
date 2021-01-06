import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:path/path.dart' as p;

import '../../scopedModels/index.dart';
import '../../models/index.dart' as Models;
import '../../util/index.dart' as Utils;

class Auth extends StatefulWidget {
  bool shouldGetAuthInfo;
  Auth({Key key, this.shouldGetAuthInfo = false}) : super(key: key);

  @override
  _Auth createState() => _Auth();
}

class _Auth extends State<Auth> {
  Models.AuthInfo authInfo = Models.AuthInfo();

  final _authKey = GlobalKey<FormState>();
  final picker = ImagePicker();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();
  TextEditingController _idCardNumController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final sex = authInfo.sex;

    authInfo..sex = sex == null ? 1 : sex;
    if (widget.shouldGetAuthInfo) {
      Future.delayed(Duration.zero).then((val) {
        getData();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
      builder: (context, child, model) => Scaffold(
        appBar: AppBar(
          title: Text('实名认证'),
          actions: [
            FlatButton(
              child: Text('提交'),
              onPressed: () {
                _handleSave(model);
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: _buildUserForm(),
        ),
      ),
    );
  }

  Widget _buildUserForm() {
    return Form(
      key: _authKey,
      child: Column(
        children: [
          Padding(
            padding:
                EdgeInsets.only(left: 20.0, right: 20.0, top: 6.0, bottom: 6.0),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                getImageBottomSheet(1);
              },
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                height: 180.0,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(4.0),
                  color: Colors.transparent,
                ),
                child: authInfo.frontImage == null
                    ? Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(FontAwesomeIcons.plus, size: 16.0),
                            Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Text('请上传身份证正面'),
                            ),
                          ],
                        ),
                      )
                    : Image.network(authInfo.frontImage, fit: BoxFit.fill),
              ),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(left: 20.0, right: 20.0, top: 6.0, bottom: 6.0),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                getImageBottomSheet(2);
              },
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                height: 180.0,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(4.0),
                  color: Colors.transparent,
                ),
                child: authInfo.backImage == null
                    ? Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(FontAwesomeIcons.plus, size: 16.0),
                            Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Text('请上传身份证背面'),
                            ),
                          ],
                        ),
                      )
                    : Image.network(authInfo.backImage, fit: BoxFit.fill),
              ),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(left: 20.0, right: 20.0, top: 6.0, bottom: 6.0),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                getImageBottomSheet(3);
              },
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                height: 180.0,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(4.0),
                  color: Colors.transparent,
                ),
                child: authInfo.handheldImage == null
                    ? Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(FontAwesomeIcons.plus, size: 16.0),
                            Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Text('请上传手持身份证照片'),
                            ),
                          ],
                        ),
                      )
                    : Image.network(authInfo.handheldImage, fit: BoxFit.fill),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: TextFormField(
              controller: _startDateController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: '有效期开始时间',
              ),
              readOnly: true,
              onTap: () {
                getIdCardDate(1);
              },
              validator: (val) => val.trim().length != 0
                  ? null
                  : Utils.Tips.isCardDateStartError,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: TextFormField(
              controller: _endDateController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: '有效期结束时间',
              ),
              readOnly: true,
              onTap: () {
                getIdCardDate(2);
              },
              validator: (val) =>
                  val.trim().length != 0 ? null : Utils.Tips.isCardDateEndError,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: '姓名',
              ),
              validator: (val) =>
                  val.trim().length != 0 ? null : Utils.Tips.nameErrorText,
              onSaved: (val) {
                authInfo.name = val.trim();
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: TextFormField(
              controller: _idCardNumController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: '身份证号码',
              ),
              validator: _validateIdNum,
              onSaved: (val) {
                authInfo.idCardNum = val.trim();
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 40.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 0.5,
                  ),
                ),
              ),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Text('性别'),
                  ),
                  Radio(
                    value: 1,
                    groupValue: authInfo.sex,
                    onChanged: (value) {
                      setState(() {
                        authInfo.sex = value;
                      });
                    },
                  ),
                  Text('男'),
                  Radio(
                    value: 2,
                    groupValue: authInfo.sex,
                    onChanged: (value) {
                      setState(() {
                        authInfo.sex = value;
                      });
                    },
                  ),
                  Text('女'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  getImageBottomSheet(type) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(children: <Widget>[
          ListTile(
            leading: Icon(Icons.photo_camera),
            title: Text("相机"),
            onTap: () {
              getImage(ImageSource.camera, type);
            },
          ),
          ListTile(
            leading: Icon(Icons.photo_library),
            title: Text("图库"),
            onTap: () {
              getImage(ImageSource.gallery, type);
            },
          ),
        ]);
      },
    );
  }

  Future getImage(ImageSource source, type) async {
    PickedFile pickedFile = await picker.getImage(source: source);

    if (pickedFile == null) return;

    final response = await Utils.API.upload(
      pickedFile.path,
      p.basename(pickedFile.path),
    );
    final resp = Models.UploadResponse.fromJson(response);

    if (resp.code != 200) return;

    Navigator.of(context).pop();
    if (mounted)
      setState(() {
        final url = resp.data?.url ?? '';
        print(url);

        switch (type) {
          case 1:
            authInfo.frontImage = url;
            break;
          case 2:
            authInfo.backImage = url;
            break;
          case 3:
            authInfo.handheldImage = url;
            break;
          default:
        }
      });
  }

  String _validateIdNum(String value) {
    return Utils.Re.idCard.hasMatch(value.trim())
        ? null
        : Utils.Tips.idCardErrorText;
  }

  getIdCardDate(type) async {
    final result = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1949),
      lastDate: DateTime(2100),
    );

    if (result == null) return;

    switch (type) {
      case 1:
        authInfo.validityStartTime = result.toString();
        _startDateController.text = getFormatedDate(result);
        break;
      default:
        authInfo.validityEndTime = result.toString();
        _endDateController.text = getFormatedDate(result);
    }
  }

  getFormatedDate(DateTime date) {
    return '${date.year}/${date.month}/${date.day}';
  }

  _handleSave(AppModel model) async {
    final _authKeyForm = _authKey.currentState;

    if (!_authKeyForm.validate()) return;
    _authKeyForm.save();

    if (authInfo.frontImage == null) {
      EasyLoading.showError('请上传身份证正面');
      return;
    }

    if (authInfo.backImage == null) {
      EasyLoading.showError('请上传身份证背面');
      return;
    }

    if (authInfo.handheldImage == null) {
      EasyLoading.showError('请上传手持身份证照');
      return;
    }

    final response = await Utils.API.userAuth(
      backImage: authInfo.backImage,
      frontImage: authInfo.frontImage,
      handheldImage: authInfo.handheldImage,
      idCardNum: authInfo.idCardNum,
      name: authInfo.name,
      sex: authInfo.sex,
      validityEndTime: authInfo.validityEndTime,
      validityStartTime: authInfo.validityStartTime,
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

    EasyLoading.showInfo('认证提交成功，请等待工作人员审核');
    Future.delayed(Duration(seconds: 3)).then((val) {
      Navigator.of(context).pop();
    });
  }

  getData() async {
    final response = await Utils.API.getUserAuth();
    final resp = Models.GetAuthInfoResponse.fromJson(response);
    if (resp.code != 200) return;

    if (mounted)
      setState(() {
        authInfo = resp.data;
        _nameController.text = resp.data.name;
        _idCardNumController.text = resp.data.idCardNum.toString();
        _startDateController.text =
            getFormatedDate(DateTime.parse(resp.data.validityStartTime));
        _endDateController.text =
            getFormatedDate(DateTime.parse(resp.data.validityEndTime));
      });
  }
}
