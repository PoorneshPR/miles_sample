import 'package:flutter/material.dart';

class ColorUtils {

  static  Color buttonTextColor = "#3399FF".toColor();
  static Color primaryIconColor = "#ACACAC".toColor();
  static Color appTextColor = "#FFFFFF".toColor();
  static Color appSecondaryTextColor = "##606060".toColor();

}

extension ColorExtension on String {
  toColor() {
    var hexString = this;
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}