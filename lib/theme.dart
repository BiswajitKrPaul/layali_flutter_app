import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// The [AppTheme] defines light and dark themes for the app.
///
/// Theme setup for FlexColorScheme package v8.
/// Use same major flex_color_scheme package version. If you use a
/// lower minor version, some properties may not be supported.
/// In that case, remove them after copying this theme to your
/// app or upgrade the package to version 8.2.0.
///
/// Use it in a [MaterialApp] like this:
///
/// MaterialApp(
///   theme: AppTheme.light,
///   darkTheme: AppTheme.dark,
/// );
abstract final class AppTheme {
  // The FlexColorScheme defined light mode ThemeData.
  static ThemeData light = FlexThemeData.light(
    // Playground built-in scheme made with FlexSchemeColor.from() API.
    colors: FlexSchemeColor.from(
      primary: const Color(0xFF065808),
      brightness: Brightness.light,
      swapOnMaterial3: true,
    ),
    // Component theme configurations for light mode.
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      useM2StyleDividerInM3: true,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      alignedDropdown: true,
      navigationRailUseIndicator: true,
    ),
    // Direct ThemeData properties.
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
  );

  // The FlexColorScheme defined dark mode ThemeData.
  static ThemeData dark = FlexThemeData.dark(
    // Playground built-in scheme made with FlexSchemeColor.from() API.
    colors: FlexSchemeColor.from(
      primary: const Color(0xFF065808),
      primaryLightRef: const Color(
        0xFF065808,
      ), // The color of light mode primary
      secondaryLightRef: const Color(
        0xFF365B37,
      ), // The color of light mode secondary
      tertiaryLightRef: const Color(
        0xFF2C7E2E,
      ), // The color of light mode tertiary
      brightness: Brightness.dark,
      swapOnMaterial3: true,
    ),
    // Component theme configurations for dark mode.
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      blendOnColors: true,
      useM2StyleDividerInM3: true,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      alignedDropdown: true,
      navigationRailUseIndicator: true,
    ),
    // Direct ThemeData properties.
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
  );
}

/// Light [ColorScheme] made with FlexColorScheme v8.2.0.
/// Requires Flutter 3.22.0 or later.
const ColorScheme lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF065808),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFF9EE2A0),
  onPrimaryContainer: Color(0xFF000000),
  primaryFixed: Color(0xFFC2E3C3),
  primaryFixedDim: Color(0xFF90CB92),
  onPrimaryFixed: Color(0xFF000000),
  onPrimaryFixedVariant: Color(0xFF010F01),
  secondary: Color(0xFF365B37),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFAFBDAF),
  onSecondaryContainer: Color(0xFF000000),
  secondaryFixed: Color(0xFFD1DED2),
  secondaryFixedDim: Color(0xFFABC0AC),
  onSecondaryFixed: Color(0xFF0D150D),
  onSecondaryFixedVariant: Color(0xFF132014),
  tertiary: Color(0xFF2C7E2E),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFB9E6B9),
  onTertiaryContainer: Color(0xFF000000),
  tertiaryFixed: Color(0xFFCDE7CE),
  tertiaryFixedDim: Color(0xFFA4CFA5),
  onTertiaryFixed: Color(0xFF0D260E),
  onTertiaryFixedVariant: Color(0xFF123313),
  error: Color(0xFFB00020),
  onError: Color(0xFFFFFFFF),
  errorContainer: Color(0xFFFCD9DF),
  onErrorContainer: Color(0xFF000000),
  surface: Color(0xFFFCFCFC),
  onSurface: Color(0xFF111111),
  surfaceDim: Color(0xFFE0E0E0),
  surfaceBright: Color(0xFFFDFDFD),
  surfaceContainerLowest: Color(0xFFFFFFFF),
  surfaceContainerLow: Color(0xFFF8F8F8),
  surfaceContainer: Color(0xFFF3F3F3),
  surfaceContainerHigh: Color(0xFFEDEDED),
  surfaceContainerHighest: Color(0xFFE7E7E7),
  onSurfaceVariant: Color(0xFF393939),
  outline: Color(0xFF919191),
  outlineVariant: Color(0xFFD1D1D1),
  shadow: Color(0xFF000000),
  scrim: Color(0xFF000000),
  inverseSurface: Color(0xFF2A2A2A),
  onInverseSurface: Color(0xFFF1F1F1),
  inversePrimary: Color(0xFF8FCE91),
  surfaceTint: Color(0xFF065808),
);

/// Dark [ColorScheme] made with FlexColorScheme v8.2.0.
/// Requires Flutter 3.22.0 or later.
const ColorScheme darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF629F80),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFF284134),
  onPrimaryContainer: Color(0xFFFFFFFF),
  primaryFixed: Color(0xFFC2E3C3),
  primaryFixedDim: Color(0xFF90CB92),
  onPrimaryFixed: Color(0xFF000000),
  onPrimaryFixedVariant: Color(0xFF010F01),
  secondary: Color(0xFF81B39A),
  onSecondary: Color(0xFF000000),
  secondaryContainer: Color(0xFF4D6B5C),
  onSecondaryContainer: Color(0xFFFFFFFF),
  secondaryFixed: Color(0xFFD1DED2),
  secondaryFixedDim: Color(0xFFABC0AC),
  onSecondaryFixed: Color(0xFF0D150D),
  onSecondaryFixedVariant: Color(0xFF132014),
  tertiary: Color(0xFF88C5A6),
  onTertiary: Color(0xFF000000),
  tertiaryContainer: Color(0xFF356C51),
  onTertiaryContainer: Color(0xFFFFFFFF),
  tertiaryFixed: Color(0xFFCDE7CE),
  tertiaryFixedDim: Color(0xFFA4CFA5),
  onTertiaryFixed: Color(0xFF0D260E),
  onTertiaryFixedVariant: Color(0xFF123313),
  error: Color(0xFFCF6679),
  onError: Color(0xFF000000),
  errorContainer: Color(0xFFB1384E),
  onErrorContainer: Color(0xFFFFFFFF),
  surface: Color(0xFF080808),
  onSurface: Color(0xFFF1F1F1),
  surfaceDim: Color(0xFF060606),
  surfaceBright: Color(0xFF2C2C2C),
  surfaceContainerLowest: Color(0xFF010101),
  surfaceContainerLow: Color(0xFF0E0E0E),
  surfaceContainer: Color(0xFF151515),
  surfaceContainerHigh: Color(0xFF1D1D1D),
  surfaceContainerHighest: Color(0xFF282828),
  onSurfaceVariant: Color(0xFFCACACA),
  outline: Color(0xFF777777),
  outlineVariant: Color(0xFF414141),
  shadow: Color(0xFF000000),
  scrim: Color(0xFF000000),
  inverseSurface: Color(0xFFE8E8E8),
  onInverseSurface: Color(0xFF2A2A2A),
  inversePrimary: Color(0xFF314A3D),
  surfaceTint: Color(0xFF629F80),
);
