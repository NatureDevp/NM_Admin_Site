import 'package:flutter/material.dart';

class CustomColors {
  static _Primary primary = _Primary();
  static _Secondary secondary = _Secondary();
  static _Dark dark = _Dark();
  static _Light light = _Light();
  static _Error error = _Error();
}

class _Primary {
  Color normal = const Color(0xff003a678);
  Color medium = const Color(0xFF4FC1A1);
  Color light = const Color(0xFF80D2BB);
  Color lighter = const Color(0xFFB4E5D7);
  Color lightest = const Color(0xFFE6F7F2);
}

class _Secondary {
  Color normal = const Color(0xFFF1D077);
  Color medium = const Color(0xFFF6DFA0);
  Color light = const Color(0xFFF7E7BA);
  Color lighter = const Color(0xFFFBF1D7);
  Color lightest = const Color(0xFFFEFBF2);
}

class _Dark {
  Color normal = const Color(0xFF101720);
  Color hard = const Color(0xFF40454D);
  Color medium = const Color(0xFF707479);
  Color light = const Color(0xFF9FA2A6);
  Color lighter = const Color(0xFFCFD1D2);
  Color lightest = const Color(0xFFE8E8E9);
}

class _Light {
  Color normal = const Color(0xFFF8F8FF);
  Color hard = const Color(0xFFFFFFFF);
}

class _Error {
  Color normal = const Color(0xFFCC0000);
  Color light = const Color(0xFFE27C7F);
  Color lighter = const Color(0xFFEBAEB3);
  Color lightest = const Color(0xFFF4E0E6);
}
