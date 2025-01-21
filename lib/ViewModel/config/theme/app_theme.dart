// import 'package:flex_color_scheme/flex_color_scheme.dart';
// import 'package:flutter/material.dart';
//
// @immutable
// class AppTheme {
//   const AppTheme._();
//
//   static final light = FlexThemeData.light(
//     scheme: FlexScheme.sakura,
//     surfaceMode: FlexSurfaceMode.highScaffoldLowSurfacesVariantDialog,
//     blendLevel: 40,
//     appBarStyle: FlexAppBarStyle.primary,
//     appBarOpacity: 0.95,
//     appBarElevation: 0,
//     transparentStatusBar: true,
//     tabBarStyle: FlexTabBarStyle.forBackground,
//     tooltipsMatchBackground: true,
//     swapColors: true,
//     lightIsWhite: true,
//     visualDensity: FlexColorScheme.comfortablePlatformDensity,
//     fontFamily: "Muli",
//     subThemesData: const FlexSubThemesData(
//       useTextTheme: true,
//       fabUseShape: true,
//       interactionEffects: true,
//       bottomNavigationBarElevation: 0,
//       bottomNavigationBarOpacity: 1,
//       navigationBarOpacity: 1,
//       navigationBarMutedUnselectedIcon: true,
//       inputDecoratorIsFilled: true,
//       inputDecoratorBorderType: FlexInputBorderType.outline,
//       inputDecoratorUnfocusedHasBorder: true,
//       blendOnColors: true,
//       blendTextTheme: true,
//       popupMenuOpacity: 0.95,
//     ),
//   );
//   static final dark = FlexThemeData.dark(
//     scheme: FlexScheme.shark,
//     primary: Colors.blue,
//     secondary: Colors.lightBlue,
//     surface: Color(0xFF181818),
//     onSurface: Colors.white,
//     surfaceMode: FlexSurfaceMode.highScaffoldLowSurfacesVariantDialog,
//     blendLevel: 40,
//     appBarStyle: FlexAppBarStyle.primary,
//     appBarOpacity: 0.95,
//     appBarElevation: 0,
//     transparentStatusBar: true,
//     tabBarStyle: FlexTabBarStyle.forBackground,
//     tooltipsMatchBackground: true,
//     swapColors: true,
//     visualDensity: FlexColorScheme.comfortablePlatformDensity,
//     fontFamily: "Muli",
//     subThemesData: const FlexSubThemesData(
//       useTextTheme: true,
//       fabUseShape: true,
//       interactionEffects: true,
//       bottomNavigationBarElevation: 0,
//       bottomNavigationBarOpacity: 1,
//       navigationBarOpacity: 1,
//       navigationBarMutedUnselectedIcon: true,
//       inputDecoratorIsFilled: true,
//       inputDecoratorBorderType: FlexInputBorderType.outline,
//       inputDecoratorUnfocusedHasBorder: true,
//       blendOnColors: true,
//       blendTextTheme: true,
//       popupMenuOpacity: 0.95,
//     ),
//   );
// }

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

@immutable
class AppTheme {
  const AppTheme._();

  static final light = FlexThemeData.light(
    scheme: FlexScheme.sakura,
    surfaceMode: FlexSurfaceMode.highScaffoldLowSurfacesVariantDialog,
    blendLevel: 40,
    appBarStyle: FlexAppBarStyle.primary,
    appBarOpacity: 0.95,
    appBarElevation: 0,
    transparentStatusBar: true,
    tabBarStyle: FlexTabBarStyle.forBackground,
    tooltipsMatchBackground: true,
    swapColors: true,
    lightIsWhite: true,
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    fontFamily: "Muli",
    subThemesData: const FlexSubThemesData(
      useTextTheme: true,
      fabUseShape: true,
      interactionEffects: true,
      bottomNavigationBarElevation: 0,
      bottomNavigationBarOpacity: 1,
      navigationBarOpacity: 1,
      navigationBarMutedUnselectedIcon: true,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      inputDecoratorUnfocusedHasBorder: true,
      blendOnColors: true,
      blendTextTheme: true,
      popupMenuOpacity: 0.95,
    ),
  );

  static final dark = FlexThemeData.dark(
    scheme: FlexScheme.shark,
    primary: Colors.blue,
    primaryLightRef: Colors.blue, // Match light theme primary
    secondary: Colors.lightBlue,
    secondaryLightRef: Colors.lightBlue, // Match light theme secondary
    surface: Color(0xFF181818),
    onSurface: Colors.white,
    surfaceMode: FlexSurfaceMode.highScaffoldLowSurfacesVariantDialog,
    blendLevel: 40,
    appBarStyle: FlexAppBarStyle.primary,
    appBarOpacity: 0.95,
    appBarElevation: 0,
    transparentStatusBar: true,
    tabBarStyle: FlexTabBarStyle.forBackground,
    tooltipsMatchBackground: true,
    swapColors: true,
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    fontFamily: "Muli",
    subThemesData: const FlexSubThemesData(
      useTextTheme: true,
      fabUseShape: true,
      interactionEffects: true,
      bottomNavigationBarElevation: 0,
      bottomNavigationBarOpacity: 1,
      navigationBarOpacity: 1,
      navigationBarMutedUnselectedIcon: true,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      inputDecoratorUnfocusedHasBorder: true,
      blendOnColors: true,
      blendTextTheme: true,
      popupMenuOpacity: 0.95,
    ),
  );
}
