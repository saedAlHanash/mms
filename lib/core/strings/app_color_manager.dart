import 'package:flutter/material.dart';

class AppColorManager {
  static const mainColor = Color(0xFF8431A7);
  static const mainColorDark = Color(0xFF8324AB);
  static const mainColorLight = Color(0xFF8940A8);
  static const textColor = Color(0xFF606060);
  static const black = Color(0xFF000000);
  static const ampere = Color(0xFFFFC107);
  static const grey = Color(0xFF848484);
  static const lightGray = Color(0xFFFBFBFB);
  static const lightGrayAb = Color(0xFFABABAB);
  static const lightGrayEd = Color(0xFFEDEDED);
  static const offWhit = Color(0xFFD9D9D9);
  static const whit = Color(0xFFFFFFFF);
  static const red = Color(0xFFC60000);
  static const redPrice = Color(0xFF910202);
  static const cardColor = Color(0xFFEFEFEF);
  static const blue = Color(0xFF0D479E);
  static const c8f = Color(0xFF8F7752);

  static const dividerColor = Color(0xFFCFCFCF);
  static const f1 = Color(0xFFf1f1f1);
  static const f9 = Color(0xFFf9f9f9);
  static const f8f9 = Color(0xFFF8F9FA);
  static const f6 = Color(0xFFf6f6f6);
  static const e4 = Color(0xFF4E5053);
  static const ac = Color(0xFFACACAC);
  static const ee = Color(0xFFEEEEEE);
  static const d9 = Color(0xFFD9D9D9);

  static const fc = Color(0xFFFCFCFC);
  static const c50 = Color(0xFF505050);
  static const c6e = Color(0xFF6E6E6E);

  static const f8 = Color(0xFFF8F8F8);

 static Color getColor(int i) {
    switch (i) {
      case 0:
      case 1:
        return Colors.grey.withOpacity(0.1);
      case 2:
        return Colors.grey.withOpacity(0.2);
      case 3:
        return Colors.grey.withOpacity(0.3);
      case 4:
        return Colors.grey.withOpacity(0.4);
      case 5:
        return Colors.grey.withOpacity(0.5);
    }
    return f8f9;
  }
}

Color getColorFromHex(String hexColor) {
  String formattedHexColor =
      hexColor.replaceAll("#", ""); // Remove the '#' character if present
  if (formattedHexColor.length == 6) {
    formattedHexColor =
        "FF$formattedHexColor"; // Add the alpha value if it's missing
  }
  int colorValue =
      int.parse(formattedHexColor, radix: 16); // Parse the hex color string
  return Color(colorValue);
}

bool isColorDark(Color color) {
  final luminance =
      (0.2126 * color.red + 0.7152 * color.green + 0.0722 * color.blue) / 255;
  return luminance < 0.5;
}

Color getCheckColor(Color color) {
  if (isColorDark(color)) {
    return Colors.white;
  } else {
    return AppColorManager.grey;
  }
}

/*
    <color name="purple_200">#8BB93E</color>
    <color name="purple_500">#4CA243</color>
    <color name="purple_700">#008543</color>
    <color name="teal_200">#FFC107</color>
    <color name="teal_700">#A17A05</color>
    <color name="black">#000000</color>
    <color name="white">#FFFFFFFF</color>
    <color name="TRANSPARENT">#00000000</color>
    <color name="back_fill_F6">#F6F6F6</color>
    <color name="back_fill_F1">#F1F1F1</color>
    <color name="back_fill_F5">#F5F5F5</color>
    <color name="ampere">#FFC107</color>
    <color name="dark_ampere">#A17A05</color>
    <color name="light_ampere">#45FFD24C</color>
    <color name="ampere_bg">#EDB100</color>
    <color name="red">#F10303</color>
    <color name="light_gray">#F5F5F5</color>
    <color name="light_gray_alpha">#CCF1F1F1</color>
    <color name="light_bg">#E8E3E3</color>
    <color name="transparency_gray">#CCF1F1F1</color>
    <color name="orange">#EDB100</color>
    <color name="blur">#F1F1F1</color>
    <color name="gray">#FF8F8F8F</color>
    <color name="off_white">#F1F1F1</color>
    <color name="dark_green">#008543</color>
    <color name="green">#4CA243</color>
    <color name="light_green">#8BB93E</color>
    <color name="light_green_2">#D9FF9A</color>

 */
