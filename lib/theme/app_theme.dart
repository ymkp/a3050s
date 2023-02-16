import 'package:a3050s/theme/color/app_color_scheme.dart';
import 'package:a3050s/theme/text/app_text_theme.dart';
import 'package:a3050s/theme/text/app_typography.dart';
import 'package:a3050s/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData createTheme({
  Color? color,
  required Brightness brightness,
}) {
  final colorScheme = _getColorScheme(color: color, brightness: brightness);

  final appColorScheme = _getAppColorScheme(
    colorScheme: colorScheme,
    brightness: brightness,
  );

  final appTypography =
      AppTypography.create(fontFamily: $constants.theme.defaultFontFamily);
  final textTheme =
      _getTextTheme(appTypography: appTypography, brightness: brightness);

  final primaryColor = ElevationOverlay.colorWithOverlay(
    appColorScheme.surface,
    appColorScheme.primary,
    3,
  );

  return ThemeData(
    textTheme: textTheme.materialTextTheme,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    colorScheme: appColorScheme.materialColorScheme,
    brightness: appColorScheme.brightness,
    typography: appTypography.materialTypography,
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      elevation: $constants.theme.defaultElevation,
      systemOverlayStyle: createOverlayStyle(
        brightness: brightness,
        primaryColor: primaryColor,
      ),
    ),
    splashFactory: InkRipple.splashFactory,
    scaffoldBackgroundColor: appColorScheme.surface,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      elevation: $constants.theme.defaultElevation,
      highlightElevation: $constants.theme.defaultElevation,
    ),
    iconTheme: IconThemeData(
      color: appColorScheme.primary,
    ),
    cardTheme: CardTheme(
      elevation: $constants.theme.defaultElevation,
      color: primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            $constants.theme.defaultBorderRadius,
          ),
        ),
      ),
    ),
  );
}

SystemUiOverlayStyle createOverlayStyle({
  required Brightness brightness,
  required Color primaryColor,
}) {
  final isDark = brightness == Brightness.dark;

  return SystemUiOverlayStyle(
    systemNavigationBarColor: primaryColor,
    systemNavigationBarContrastEnforced: false,
    systemStatusBarContrastEnforced: false,
    systemNavigationBarIconBrightness:
        isDark ? Brightness.light : Brightness.dark,
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
    statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
  );
}

ColorScheme _getColorScheme({
  Color? color,
  required Brightness brightness,
}) {
  return ColorScheme.fromSeed(
    seedColor: color ?? $constants.theme.defaultThemeColor,
    brightness: brightness,
  );
}

AppColorScheme _getAppColorScheme({
  required ColorScheme colorScheme,
  required Brightness brightness,
}) {
  final isDark = brightness == Brightness.dark;

  return AppColorScheme.fromMaterialColorScheme(
    colorScheme,
    disabled: $constants.palette.grey,
    onDisabled: isDark ? $constants.palette.white : $constants.palette.black,
  );
}

AppTextTheme _getTextTheme({
  required AppTypography appTypography,
  required Brightness brightness,
}) {
  return brightness == Brightness.dark
      ? appTypography.white
      : appTypography.black;
}
