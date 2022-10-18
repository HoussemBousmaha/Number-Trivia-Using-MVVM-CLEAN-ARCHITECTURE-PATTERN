import 'package:flutter/material.dart';

class ColorManager {
  static Color primary = HexColor.fromHex("#ED9728"); // primary
  static Color primaryOpacity70 = HexColor.fromHex("#B3ED9728"); // primary with 0.7 opacity
  static Color darkGrey = HexColor.fromHex("#525252"); // dark grey
  static Color grey = HexColor.fromHex("#737477"); // grey
  static Color lightGrey = HexColor.fromHex("#9E9E9E"); // light grey
  static Color darkPrimary = HexColor.fromHex("#D17D11"); // dark
  static Color grey1 = HexColor.fromHex("#707070"); // grey
  static Color grey2 = HexColor.fromHex("#D17D11"); // grey
  static Color white = HexColor.fromHex("#FFFFFF"); // white
  static Color black = HexColor.fromHex("#000000"); // black
  static Color error = HexColor.fromHex("#E61F34"); // red

}

// convert string hex color to dart Color object
extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = 'FF$hexColorString'; // 8 char with opacity 100%
    }

    return Color(
      int.parse(hexColorString, radix: 16), // radix: 16 means it is hexadecimal number
    );
  }
}
