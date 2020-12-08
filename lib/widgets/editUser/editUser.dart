import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../scopedModels/index.dart';

class EditUser extends StatefulWidget {
  EditUser({Key key}) : super(key: key);

  @override
  _EditUser createState() => _EditUser();
}

class _EditUser extends State<EditUser> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModelDescendant<AppModel>(
      builder: (context, child, model) => Scaffold(
        appBar: AppBar(
          title: Text('编辑个人信息'),
        ),
        body: Container(),
      ),
    );
  }
}
