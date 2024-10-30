import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

List<ThemeData> getThemes() {
  return [
    ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme(
            brightness: Brightness.light,
            //background colors
            background: HexColor('#FFFFFF'),
            onBackground: HexColor('#1E1E1E'),
            surface: HexColor('#FFFFFF'),
            onSurface: HexColor('#1E1E1E'),
            //primary colors
            primary: HexColor('#008000'),
            onPrimary: HexColor('#FFFFFF'),
            primaryContainer: HexColor('#FFDDBD'),
            onPrimaryContainer: HexColor('#F97D09'),
            //secondary colors
            secondary: HexColor('#21A736'),
            onSecondary: HexColor('#FFFFFF'),
            secondaryContainer: HexColor("#C9FCD1"),
            onSecondaryContainer: HexColor("#21A736"),
            //error colors
            error: HexColor('#C04024'),
            onError: HexColor('#FFFFFF'),
            errorContainer: HexColor('#FADAD2'),
            onErrorContainer: HexColor('#C04024'),
            // additional colors:
            outline: HexColor('#1e1e1e'),
            shadow: HexColor('#000000'))),
    ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: HexColor("#F97D09"), brightness: Brightness.dark)),
  ];
}
