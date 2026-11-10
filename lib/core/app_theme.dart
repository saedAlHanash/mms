import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/util/my_style.dart';

const primaryColor = AppColorManager.black;
const secondaryColor = AppColorManager.mainColorDark;

OutlineInputBorder _inputBorder(Color color, double width) => OutlineInputBorder(
      borderSide: BorderSide(color: color, width: width),
      borderRadius: BorderRadius.circular(8),
    );

final appTheme = ThemeData(
  fontFamily: 'cairo',
  brightness: Brightness.light,
  primaryColor: AppColorManager.primary500,
  scaffoldBackgroundColor: AppColorManager.neutral0,
  colorScheme: const ColorScheme.light(
    primary: AppColorManager.primary500,
    secondary: AppColorManager.primary600,
    surface: AppColorManager.neutral0,
    onSurface: AppColorManager.neutral900,
    error: AppColorManager.danger,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: AppColorManager.neutral0,
    surfaceTintColor: AppColorManager.neutral0,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: MyStyle.appBarTitle.copyWith(color: AppColorManager.neutral900),
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: AppColorManager.f9,
    ),
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(color: AppColorManager.primary500),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColorManager.primary500,
    foregroundColor: AppColorManager.neutral0,
  ),
  inputDecorationTheme: InputDecorationTheme(
    floatingLabelStyle: const TextStyle(color: AppColorManager.primary700),
    iconColor: AppColorManager.primary500,
    hintStyle: MyStyle.bodyLg.copyWith(color: AppColorManager.neutral500),
    labelStyle: MyStyle.bodyLg.copyWith(color: AppColorManager.neutral500),
    border: _inputBorder(AppColorManager.neutral200, 1),
    enabledBorder: _inputBorder(AppColorManager.neutral200, 1),
    focusedBorder: _inputBorder(AppColorManager.primary500, 2),
    errorBorder: _inputBorder(AppColorManager.danger, 1),
    focusedErrorBorder: _inputBorder(AppColorManager.danger, 2),
    disabledBorder: _inputBorder(AppColorManager.neutral100, 1),
  ),
  textSelectionTheme: const TextSelectionThemeData(cursorColor: AppColorManager.primary500),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      alignment: Alignment.center,
      minimumSize: WidgetStatePropertyAll(Size(0, 52.h)),
      padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 16.w)),
      textStyle: WidgetStatePropertyAll(MyStyle.button),
      foregroundColor: const WidgetStatePropertyAll(AppColorManager.neutral0),
      backgroundColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.pressed)) return AppColorManager.primary600;
          return AppColorManager.primary500;
        },
      ),
      surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
      shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      overlayColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) => AppColorManager.primary600.withValues(alpha: 0.12),
      ),
    ),
  ),
  dividerTheme: DividerThemeData(
    color: AppColorManager.neutral100,
    thickness: 1.0,
    space: 1.0,
    indent: 0,
    endIndent: 0,
  ),
  iconButtonTheme: IconButtonThemeData(style: ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.all(2.0.r)))),
  checkboxTheme: const CheckboxThemeData(
    fillColor: WidgetStatePropertyAll(AppColorManager.primary500),
  ),
  radioTheme: RadioThemeData(
    fillColor: WidgetStateProperty.resolveWith<Color?>(
      (states) => states.contains(WidgetState.selected) ? AppColorManager.primary500 : AppColorManager.neutral500,
    ),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith<Color?>(
      (states) => states.contains(WidgetState.selected) ? AppColorManager.neutral0 : null,
    ),
    trackColor: WidgetStateProperty.resolveWith<Color?>(
      (states) => states.contains(WidgetState.selected) ? AppColorManager.primary500 : null,
    ),
  ),
);
