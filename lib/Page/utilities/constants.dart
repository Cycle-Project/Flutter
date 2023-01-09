import 'dart:math';
import 'package:flutter/material.dart';

class Constants {
  static const googleApiKey = "AIzaSyA9fb2IaIuN_aEB4Ykqs1SgqyJ2-1SjqUQ";
  static const openWeatherKey = "1f3413676a6ff7bcae401502cb9cd820";

  static const bluishGreyColor = Color(0xFFA7B8B6);
  static const darkBluishGreyColor = Color(0xFF343B3A);
  static const backgroundColor = Color(0xFFC7D1D0);
  static const primaryColor = Color(0xFF39D2C0);
  static const lightSalmonColor = Color(0xFFFFA07A);
  static const tealColor = Color(0xFF008C8C);
  static const lilaColor = Color(0xFF5C2EE6);

  static MaterialColor generateMaterialColor(Color color) {
    return MaterialColor(color.value, {
      50: _tintColor(color, 0.9),
      100: _tintColor(color, 0.8),
      200: _tintColor(color, 0.6),
      300: _tintColor(color, 0.4),
      400: _tintColor(color, 0.2),
      500: color,
      600: _shadeColor(color, 0.1),
      700: _shadeColor(color, 0.2),
      800: _shadeColor(color, 0.3),
      900: _shadeColor(color, 0.4),
    });
  }

  static int _tintValue(int value, double factor) =>
      max(0, min((value + ((255 - value) * factor)).round(), 255));

  static Color _tintColor(Color color, double factor) => Color.fromRGBO(
      _tintValue(color.red, factor),
      _tintValue(color.green, factor),
      _tintValue(color.blue, factor),
      1);

  static int _shadeValue(int value, double factor) =>
      max(0, min(value - (value * factor).round(), 255));

  static Color _shadeColor(Color color, double factor) => Color.fromRGBO(
      _shadeValue(color.red, factor),
      _shadeValue(color.green, factor),
      _shadeValue(color.blue, factor),
      1);
}
