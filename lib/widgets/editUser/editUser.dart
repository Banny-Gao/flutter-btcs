import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path/path.dart' as p;

import '../../scopedModels/index.dart';
import '../../models/index.dart' as Models;
import '../../util/index.dart' as Utils;

class EditUser extends StatefulWidget {
  EditUser({Key key}) : super(key: key);

  @override
  _EditUser createState() => _EditUser();
}

class _EditUser extends State<EditUser> {
  Models.User user = ProfileModel.profile.user;

  final _editKey = GlobalKey<FormState>();
  final picker = ImagePicker();

  TextEditingController _userNameController = TextEditingController();
  TextEditingController _avatarUrlController = TextEditingController();

  String _defaultAvatarUrl = 'assets/img/avatar.png';
  String _userName;
  String _avatarUrl;

  @override
  void initState() {
    super.initState();

    print(user.memberName);

    _userName = user.memberName;
    _userNameController.text = _userName;
    _avatarUrl = user.memberAvatar;
    _avatarUrlController.text =
        _avatarUrl != null ? _avatarUrl : _defaultAvatarUrl;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
      builder: (context, child, model) => Scaffold(
        appBar: AppBar(
          title: Text('编辑个人信息'),
          actions: [
            FlatButton(
              child: Text(
                '保存',
                style: TextStyle(
                  color: Theme.of(context).bottomAppBarColor,
                  fontSize: 16.0,
                ),
              ),
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
      key: _editKey,
      child: Column(
        children: [
          Padding(
            padding:
                EdgeInsets.only(left: 20.0, right: 20.0, top: 6.0, bottom: 6.0),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: getImageBottomSheet,
              child: Row(
                children: [
                  Container(
                    width: 72.0,
                    height: 72.0,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 2.0,
                      ),
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                      image: DecorationImage(
                        image: _avatarUrl == null
                            ? AssetImage(_defaultAvatarUrl)
                            : NetworkImage(_avatarUrl),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Opacity(
                      opacity: 0,
                      child: TextFormField(
                        onTap: getImageBottomSheet,
                        controller: _avatarUrlController,
                        readOnly: true,
                        onSaved: (v) {
                          _avatarUrl = v;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Icon(
                      FontAwesomeIcons.chevronRight,
                      size: 14.0,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: TextFormField(
              controller: _userNameController,
              cursorWidth: 0.0,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
                decoration: TextDecoration.none,
              ),
              decoration: InputDecoration(
                labelText: '昵称',
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              validator: (val) =>
                  val.trim().length != 0 ? null : Utils.Tips.userNameErrorText,
              onSaved: (val) {
                _userName = val.trim();
              },
            ),
          ),
          Divider(),
        ],
      ),
    );
  }

  getImageBottomSheet() {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(children: <Widget>[
          ListTile(
            leading: Icon(Icons.photo_camera),
            title: Text("相机"),
            onTap: () {
              getImage(ImageSource.camera);
            },
          ),
          ListTile(
            leading: Icon(Icons.photo_library),
            title: Text("图库"),
            onTap: () {
              getImage(ImageSource.gallery);
            },
          ),
        ]);
      },
    );
  }

  Future getImage(ImageSource source) async {
    PickedFile pickedFile = await picker.getImage(source: source);

    if (pickedFile == null) return;

    final response = await Utils.API.upload(
      pickedFile.path,
      p.basename(pickedFile.path),
    );
    final resp = Models.UploadResponse.fromJson(response);

    if (resp.code != 200) return;

    Navigator.of(context).pop();
    setState(() {
      _avatarUrl = resp.data?.url;
      _avatarUrlController.text = _avatarUrl;
    });
  }

  _handleSave(AppModel model) async {
    final _userForm = _editKey.currentState;

    if (!_userForm.validate()) return;
    _userForm.save();

    final response = await Utils.API.changeUserInfo(
      memberAvatar: _avatarUrl,
      memberName: _userName,
    );
    final resp = Models.ChangeUserInfoResponse.fromJson(response);

    if (resp.code != 200) return;

    ProfileModel.profile.user
      ..memberAvatar = _avatarUrl
      ..memberName = _userName;

    model.saveProfile();

    Navigator.of(context).pop();
  }
}
