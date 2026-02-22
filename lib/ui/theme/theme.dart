import 'package:flutter/material.dart';
import 'color.dart';
import 'type.dart';

final darkColorScheme = ColorScheme.dark(
  primary: purple80,
  secondary: purpleGrey80,
  tertiary: pink80,
);

final lightColorScheme = ColorScheme.light(
  primary: purple40,
  secondary: purpleGrey40,
  tertiary: pink40,
);

ThemeData civisTheme(bool darkTheme) {
  return ThemeData(
    useMaterial3: true,
    colorScheme: darkTheme ? darkColorScheme : lightColorScheme,
    textTheme: typography,
  );
}
