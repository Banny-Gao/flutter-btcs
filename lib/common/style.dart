import 'dart:ui';

import 'package:flutter/cupertino.dart';

class Colors {
  static const primaryFontColor = Color.fromARGB(255, 51, 51, 51);

  static const Color whiteGradientStart =
      const Color.fromARGB(255, 253, 251, 251);
  static const Color whiteGradientEnd =
      const Color.fromARGB(255, 235, 237, 238);

  static const Color blueGradientStart =
      const Color.fromARGB(255, 72, 198, 239);
  static const Color blueGradientEnd = const Color.fromARGB(255, 111, 134, 214);

  static const Color greenGradientStart =
      const Color.fromARGB(255, 55, 236, 186);
  static const Color greenGradientEnd =
      const Color.fromARGB(255, 114, 175, 211);

  static const whiteGradient = const LinearGradient(
    colors: const [whiteGradientStart, whiteGradientEnd],
    stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const blueGradient = const LinearGradient(
    colors: const [blueGradientStart, blueGradientEnd],
    stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const greenGradient = const LinearGradient(
    colors: const [greenGradientStart, greenGradientEnd],
    stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
