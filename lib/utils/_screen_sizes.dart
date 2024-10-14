import 'package:flutter/rendering.dart';

class Screen {
  Screen();
  double width = 0;
  double height = 0;

  factory Screen.constraints(BoxConstraints constraints) {
    Screen screen = Screen();
    screen.width = constraints.maxWidth;
    screen.height = constraints.maxHeight;
    return screen;
  }
}
