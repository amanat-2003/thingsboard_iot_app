import 'package:flutter/material.dart' show BuildContext, MediaQuery, Brightness;

bool isDarkMode(BuildContext context) {
    return MediaQuery.of(context).platformBrightness == Brightness.dark;
  }