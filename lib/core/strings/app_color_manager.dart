import 'package:flutter/material.dart';

class AppColorManager {
  //region design tokens (redesign)
  static const primary50 = Color(0xFFF6EEFA);
  static const primary100 = Color(0xFFEBDAF3);
  static const primary200 = Color(0xFFD6B5E6);
  static const primary300 = Color(0xFFBC88D4);
  static const primary400 = Color(0xFF9A4FBB);
  static const primary500 = Color(0xFF8431A7);
  static const primary600 = Color(0xFF6E2690);
  static const primary700 = Color(0xFF591E75);
  static const primary800 = Color(0xFF44175A);
  static const primary900 = Color(0xFF2E0F3D);

  static const neutral0 = Color(0xFFFFFFFF);
  static const neutral25 = Color(0xFFFAF9FB);
  static const neutral50 = Color(0xFFF4F2F6);
  static const neutral100 = Color(0xFFEAE7EE);
  static const neutral200 = Color(0xFFD9D5DF);
  static const neutral300 = Color(0xFFB9B3C2);
  static const neutral500 = Color(0xFF6F6878);
  static const neutral700 = Color(0xFF3F3947);
  static const neutral900 = Color(0xFF1D1922);

  static const success = Color(0xFF1F8A3B);
  static const successSoft = Color(0xFFE3F6E6);
  static const successText = Color(0xFF1A6E27);
  static const warning = Color(0xFFB26B00);
  static const warningSoft = Color(0xFFFFF4D6);
  static const warningText = Color(0xFF8A5A00);
  static const danger = Color(0xFFC62828);
  static const dangerSoft = Color(0xFFFCE8E8);
  static const dangerText = Color(0xFFB42323);
  static const info = Color(0xFF2449C4);
  static const infoSoft = Color(0xFFE6EDFE);
  //endregion

  //region legacy names (aliases to the new tokens)
  static const mainColor = primary500;
  static const mainColorDark = primary600;
  static const mainColorLight = primary700;
  static const textColor = neutral700;
  static const black = Color(0xFF000000);
  static const ampere = Color(0xFFFFC107);
  static const grey = neutral500;
  static const lightGray = Color(0xFFFBFBFB);
  static const offWhit = neutral200;
  static const whit = Color(0xFFFFFFFF);
  static const red = danger;
  static const cardColor = Color(0xFFEFEFEF);

  static const f9 = Color(0xFFf9f9f9);
  static const f8f9 = Color(0xFFF8F9FA);


  //endregion

  static Color getColor(int i) {
    switch (i) {
      case 0:
      case 1:
        return Colors.grey.withValues(alpha: 0.1);
      case 2:
        return Colors.grey.withValues(alpha: 0.2);
      case 3:
        return Colors.grey.withValues(alpha: 0.3);
      case 4:
        return Colors.grey.withValues(alpha: 0.4);
      case 5:
        return Colors.grey.withValues(alpha: 0.5);
    }
    return f8f9;
  }

  static Color getPollColor(int i) {
    switch (i) {
      case 0:
        return Color(0xFF45227B);
      case 1:
        return Color(0xFF572C9A);
      case 2:
        return Color(0xFF624296);
      case 3:
        return Color(0xFF8F64D5);
      case 4:
        return Color(0xFFB085F5);
      case 5:
        return Color(0xffbaa2ff);
    }
    return f8f9;
  }

  /// Same palette as [getPollColor], but picks well-separated shades
  /// according to how many options exist (2 → 0,4 · 3 → 0,3,5 · 4 → 0,2,3,5).
  static Color getPollColorSpread(int i, int count) {
    const spreads = <int, List<int>>{
      2: [0, 4],
      3: [0, 3, 5],
      4: [0, 2, 3, 5],
    };
    final indexes = spreads[count];
    if (indexes == null || i < 0 || i >= indexes.length) return getPollColor(i);
    return getPollColor(indexes[i]);
  }
}

Color getColorFromHex(String hexColor) {
  String formattedHexColor = hexColor.replaceAll("#", ""); // Remove the '#' character if present
  if (formattedHexColor.length == 6) {
    formattedHexColor = "FF$formattedHexColor"; // Add the alpha value if it's missing
  }
  int colorValue = int.parse(formattedHexColor, radix: 16); // Parse the hex color string
  return Color(colorValue);
}

bool isColorDark(Color? color) {
  if (color == null) return false;
  final luminance = (0.2126 * color.red + 0.7152 * color.green + 0.0722 * color.blue) / 255;
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
