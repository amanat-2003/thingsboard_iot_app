import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iot_app/constants/app_colors.dart';
import 'package:iot_app/utils/transition/page_transitions.dart';

// var tbTypography = Typography.material2018();

// final ThemeData lightTheme = ThemeData(
//   useMaterial3: true,
//   scaffoldBackgroundColor: AppColors.backgroundLightMode,
//   colorScheme: AppColors.lightColorScheme,
//   textTheme: GoogleFonts.latoTextTheme(),
//   brightness: Brightness.light,
// );

final ThemeData nqLightTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: AppColors.backgroundLightMode,
  colorScheme: AppColors.lightColorScheme,
  textTheme: GoogleFonts.latoTextTheme(),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: AppColors.darkSeedColor,
      foregroundColor: AppColors.whiteColor,
      // primary: AppColors.whiteColor,
      // onSurface: AppColors.darkSeedColor,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(fontSize: 13),
    floatingLabelBehavior: FloatingLabelBehavior.always,
    labelStyle: TextStyle(
      color: AppColors.onSurfaceDarkMode,
      fontSize: 17,
    ),
  ),
  appBarTheme: AppBarTheme(elevation: 0),
  brightness: Brightness.light,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    showSelectedLabels: true,
    showUnselectedLabels: true,
  ),
  pageTransitionsTheme: PageTransitionsTheme(
    builders: {
      TargetPlatform.iOS: FadeOpenPageTransitionsBuilder(),
      TargetPlatform.android: FadeOpenPageTransitionsBuilder(),
    },
  ),
);

// final ThemeData darkTheme = ThemeData(
//   useMaterial3: true,
//   scaffoldBackgroundColor: AppColors.backgroundDarkMode,
//   colorScheme: AppColors.darkColorScheme,
//   elevatedButtonTheme: ElevatedButtonThemeData(
//     style: ElevatedButton.styleFrom(
//       padding: EdgeInsets.symmetric(vertical: 16),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       backgroundColor: AppColors.primaryDarkMode,
//       foregroundColor: AppColors.whiteColor,
//       // primary: AppColors.whiteColor,
//       // onSurface: AppColors.primaryDarkMode,
//     ),
//   ),
//   textTheme: GoogleFonts.latoTextTheme(),
//   brightness: Brightness.dark,
//   bottomNavigationBarTheme: BottomNavigationBarThemeData(
//     showSelectedLabels: true,
//     showUnselectedLabels: true,
//   ),
//   pageTransitionsTheme: PageTransitionsTheme(
//     builders: {
//       TargetPlatform.iOS: FadeOpenPageTransitionsBuilder(),
//       TargetPlatform.android: FadeOpenPageTransitionsBuilder(),
//     },
//   ),
// );


final ThemeData nqDarkTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: AppColors.backgroundDarkMode,
  colorScheme: AppColors.darkColorScheme,
  textTheme: GoogleFonts.latoTextTheme(),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: AppColors.darkSeedColor,
      foregroundColor: AppColors.whiteColor,
      // primary: AppColors.whiteColor,
      // onSurface: AppColors.darkSeedColor,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(fontSize: 13),
    floatingLabelBehavior: FloatingLabelBehavior.always,
    labelStyle: TextStyle(
      color: AppColors.onSurfaceDarkMode,
      fontSize: 17,
    ),
  ),
  appBarTheme: AppBarTheme(elevation: 0),
  brightness: Brightness.dark,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    showSelectedLabels: true,
    showUnselectedLabels: true,
  ),
  pageTransitionsTheme: PageTransitionsTheme(
    builders: {
      TargetPlatform.iOS: FadeOpenPageTransitionsBuilder(),
      TargetPlatform.android: FadeOpenPageTransitionsBuilder(),
    },
  ),
);
