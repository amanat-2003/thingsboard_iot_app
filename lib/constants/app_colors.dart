// import 'package:flutter/material.dart'
//     show immutable, Color, ColorScheme, Brightness;

// extension RemoveAll on String {
//   String removeAll(Iterable<String> values) => values.fold(
//       this,
//       (
//         String result,
//         String pattern,
//       ) =>
//           result.replaceAll(pattern, ''));
// }

// @immutable
// class AppColors {
//   static final lightColorScheme = ColorScheme.fromSeed(
//     seedColor: AppColors.lightSeedColor,
//     brightness: Brightness.light,
//   );

//   static final darkColorScheme = ColorScheme.fromSeed(
//     seedColor: AppColors.darkSeedColor,
//     brightness: Brightness.dark,
//   );

//   static final lightSeedColor = Color(
//     int.parse(
//       '11c3a9'.removeAll(['0x', '#']).padLeft(8, 'ff'),
//       radix: 16,
//     ),
//   );
//   static final darkSeedColor = Color(
//     int.parse(
//       '11c3a9'.removeAll(['0x', '#']).padLeft(8, 'ff'),
//       radix: 16,
//     ),
//   );

//   static final whiteColor = Color(0xffffffff);
//   static final navigationbarColor = Color.fromARGB(255, 39, 39, 39);
//   static final selectedNavigationbarItemColor =
//       Color.fromARGB(255, 127, 102, 212);

//   static final primaryLightMode = Color(int.parse('4278217564'));
//   static final onPrimaryLightMode = Color(int.parse('4294967295'));
//   static final primaryContainerLightMode = Color(int.parse('4287952094'));
//   static final onPrimaryContainerLightMode = Color(int.parse('4278198298'));
//   static final secondaryLightMode = Color(int.parse('4283065181'));
//   static final onSecondaryLightMode = Color(int.parse('4294967295'));
//   static final secondaryContainerLightMode = Color(int.parse('4291684576'));
//   static final onSecondaryContainerLightMode = Color(int.parse('4278591515'));
//   static final tertiaryLightMode = Color(int.parse('4282606200'));
//   static final onTertiaryLightMode = Color(int.parse('4294967295'));
//   static final tertiaryContainerLightMode = Color(int.parse('4291421951'));
//   static final onTertiaryContainerLightMode = Color(int.parse('4278197807'));
//   static final errorLightMode = Color(int.parse('4290386458'));
//   static final onErrorLightMode = Color(int.parse('4294967295'));
//   static final errorContainerLightMode = Color(int.parse('4294957782'));
//   static final onErrorContainerLightMode = Color(int.parse('4282449922'));
//   static final outlineLightMode = Color(int.parse('4285495670'));
//   static final outlineVariantLightMode = Color(int.parse('4290693573'));
//   static final backgroundLightMode = Color(int.parse('4294639098'));
//   static final onBackgroundLightMode = Color(int.parse('4279835675'));
//   static final surfaceLightMode = Color(int.parse('4294639098'));
//   static final onSurfaceLightMode = Color(int.parse('4279835675'));
//   static final surfaceVariantLightMode = Color(int.parse('4292535776'));
//   static final onSurfaceVariantLightMode = Color(int.parse('4282337606'));
//   static final inverseSurfaceLightMode = Color(int.parse('4281151792'));
//   static final onInverseSurfaceLightMode = Color(int.parse('4293915119'));
//   static final inversePrimaryLightMode = Color(int.parse('4282637762'));
//   static final shadowLightMode = Color(int.parse('4278190080'));
//   static final scrimLightMode = Color(int.parse('4278190080'));
//   static final surfaceTintLightMode = Color(int.parse('4278217564'));

//   static final primaryDarkMode = Color(int.parse('4282637762'));
//   static final onPrimaryDarkMode = Color(int.parse('4278204463'));
//   static final primaryContainerDarkMode = Color(int.parse('4278210885'));
//   static final onPrimaryContainerDarkMode = Color(int.parse('4287952094'));
//   static final secondaryDarkMode = Color(int.parse('4289842372'));
//   static final onSecondaryDarkMode = Color(int.parse('4280104239'));
//   static final secondaryContainerDarkMode = Color(int.parse('4281551685'));
//   static final onSecondaryContainerDarkMode = Color(int.parse('4291684576'));
//   static final tertiaryDarkMode = Color(int.parse('4289448676'));
//   static final onTertiaryDarkMode = Color(int.parse('4279382856'));
//   static final tertiaryContainerDarkMode = Color(int.parse('4281027167'));
//   static final onTertiaryContainerDarkMode = Color(int.parse('4291421951'));
//   static final errorDarkMode = Color(int.parse('4294948011'));
//   static final onErrorDarkMode = Color(int.parse('4285071365'));
//   static final errorContainerDarkMode = Color(int.parse('4287823882'));
//   static final onErrorContainerDarkMode = Color(int.parse('4294948011'));
//   static final outlineDarkMode = Color(int.parse('4287206287'));
//   static final outlineVariantDarkMode = Color(int.parse('4282337606'));
//   static final backgroundDarkMode = Color(int.parse('4279835675'));
//   static final onBackgroundDarkMode = Color(int.parse('4292928481'));
//   static final surfaceDarkMode = Color(int.parse('4279835675'));
//   static final onSurfaceDarkMode = Color(int.parse('4292928481'));
//   static final surfaceVariantDarkMode = Color(int.parse('4282337606'));
//   static final onSurfaceVariantDarkMode = Color(int.parse('4290693573'));
//   static final inverseSurfaceDarkMode = Color(int.parse('4292928481'));
//   static final onInverseSurfaceDarkMode = Color(int.parse('4281151792'));
//   static final inversePrimaryDarkMode = Color(int.parse('4278217564'));
//   static final shadowDarkMode = Color(int.parse('4278190080'));
//   static final scrimDarkMode = Color(int.parse('4278190080'));
//   static final surfaceTintDarkMode = Color(int.parse('4282637762'));

//   const AppColors._();
// }

import 'package:flutter/material.dart'
    show immutable, Color, ColorScheme, Brightness;

extension RemoveAll on String {
  String removeAll(Iterable<String> values) => values.fold(
      this,
      (
        String result,
        String pattern,
      ) =>
          result.replaceAll(pattern, ''));
}

@immutable
class AppColors {
  static final lightColorScheme = ColorScheme.fromSeed(
    seedColor: AppColors.lightSeedColor,
    brightness: Brightness.light,
  );

  static final darkColorScheme = ColorScheme.fromSeed(
    seedColor: AppColors.darkSeedColor,
    brightness: Brightness.dark,
  );

  static final lightSeedColor = Color(
    int.parse(
      '#0088b2'.removeAll(['0x', '#']).padLeft(8, 'ff'),
      radix: 16,
    ),
  );
  static final darkSeedColor = Color(
    int.parse(
      '#0088b2'.removeAll(['0x', '#']).padLeft(8, 'ff'),
      radix: 16,
    ),
  );

  static final primaryLightMode = Color(int.parse('4278216327'));
  static final onPrimaryLightMode = Color(int.parse('4294967295'));
  static final primaryContainerLightMode = Color(int.parse('4290832639'));
  static final onPrimaryContainerLightMode = Color(int.parse('4278197803'));
  static final secondaryLightMode = Color(int.parse('4283261292'));
  static final onSecondaryLightMode = Color(int.parse('4294967295'));
  static final secondaryContainerLightMode = Color(int.parse('4291880691'));
  static final onSecondaryContainerLightMode = Color(int.parse('4278787623'));
  static final tertiaryLightMode = Color(int.parse('4284439165'));
  static final onTertiaryLightMode = Color(int.parse('4294967295'));
  static final tertiaryContainerLightMode = Color(int.parse('4293189631'));
  static final onTertiaryContainerLightMode = Color(int.parse('4279965494'));
  static final errorLightMode = Color(int.parse('4290386458'));
  static final onErrorLightMode = Color(int.parse('4294967295'));
  static final errorContainerLightMode = Color(int.parse('4294957782'));
  static final onErrorContainerLightMode = Color(int.parse('4282449922'));
  static final outlineLightMode = Color(int.parse('4285626493'));
  static final outlineVariantLightMode = Color(int.parse('4290824141'));
  static final backgroundLightMode = Color(int.parse('4294704382'));
  static final onBackgroundLightMode = Color(int.parse('4279835678'));
  static final surfaceLightMode = Color(int.parse('4294704382'));
  static final onSurfaceLightMode = Color(int.parse('4279835678'));
  static final surfaceVariantLightMode = Color(int.parse('4292666345'));
  static final onSurfaceVariantLightMode = Color(int.parse('4282402892'));
  static final inverseSurfaceLightMode = Color(int.parse('4281217331'));
  static final onInverseSurfaceLightMode = Color(int.parse('4293980659'));
  static final inversePrimaryLightMode = Color(int.parse('4285649663'));
  static final shadowLightMode = Color(int.parse('4278190080'));
  static final scrimLightMode = Color(int.parse('4278190080'));
  static final surfaceTintLightMode = Color(int.parse('4278216327'));

  static final primaryDarkMode = Color(int.parse('4285649663'));
  static final onPrimaryDarkMode = Color(int.parse('4278203719'));
  static final primaryContainerDarkMode = Color(int.parse('4278209894'));
  static final onPrimaryContainerDarkMode = Color(int.parse('4290832639'));
  static final secondaryDarkMode = Color(int.parse('4290104022'));
  static final onSecondaryDarkMode = Color(int.parse('4280234813'));
  static final secondaryContainerDarkMode = Color(int.parse('4281747796'));
  static final onSecondaryContainerDarkMode = Color(int.parse('4291880691'));
  static final tertiaryDarkMode = Color(int.parse('4291347178'));
  static final onTertiaryDarkMode = Color(int.parse('4281347148'));
  static final tertiaryContainerDarkMode = Color(int.parse('4282860388'));
  static final onTertiaryContainerDarkMode = Color(int.parse('4293189631'));
  static final errorDarkMode = Color(int.parse('4294948011'));
  static final onErrorDarkMode = Color(int.parse('4285071365'));
  static final errorContainerDarkMode = Color(int.parse('4287823882'));
  static final onErrorContainerDarkMode = Color(int.parse('4294948011'));
  static final outlineDarkMode = Color(int.parse('4287271575'));
  static final outlineVariantDarkMode = Color(int.parse('4282402892'));
  static final backgroundDarkMode = Color(int.parse('4279835678'));
  static final onBackgroundDarkMode = Color(int.parse('4292993765'));
  static final surfaceDarkMode = Color(int.parse('4279835678'));
  static final onSurfaceDarkMode = Color(int.parse('4292993765'));
  static final surfaceVariantDarkMode = Color(int.parse('4282402892'));
  static final onSurfaceVariantDarkMode = Color(int.parse('4290824141'));
  static final inverseSurfaceDarkMode = Color(int.parse('4292993765'));
  static final onInverseSurfaceDarkMode = Color(int.parse('4281217331'));
  static final inversePrimaryDarkMode = Color(int.parse('4278216327'));
  static final shadowDarkMode = Color(int.parse('4278190080'));
  static final scrimDarkMode = Color(int.parse('4278190080'));
  static final surfaceTintDarkMode = Color(int.parse('4285649663'));

  static final whiteColor = Color(0xffffffff);
  static final blackColor = Color(0xff000000);
  static final greyColor = Color(0xffd9d9d9);
  static final transparentColor = Color.fromARGB(0, 217, 217, 217);
  static final navigationbarColorDarkMode = Color.fromARGB(255, 39, 39, 39);
  static final navigationbarColorLightMode = AppColors.surfaceVariantLightMode;
  static final selectedNavigationbarItemColor =
      Color.fromARGB(255, 127, 102, 212);

  const AppColors._();
}
