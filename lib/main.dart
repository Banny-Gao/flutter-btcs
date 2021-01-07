import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'scopedModels/index.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AppModel model = AppModel();
  await model.init();

  runApp(ScopedModel<AppModel>(model: model, child: OreApp()));
}
