import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scopedModels/index.dart';

class ToggleThemeButton extends StatelessWidget {
  const ToggleThemeButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
      builder: (context, child, model) => IconButton(
          icon: Icon(
            Icons.color_lens,
            color: Colors.white,
          ),
          onPressed: () => model.toggleTheme()),
    );
  }
}
