import 'package:flutter/material.dart';

/// All custom application theme
class AppTheme {

  /// Default application theme
  static ThemeData get basic => ThemeData(

    /// TextField Theme
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colors.black12, width: 1),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colors.black12, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colors.black12, width: 1),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colors.red, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colors.lightBlueAccent, width: 1),
      ),
      fillColor: Colors.white,
      filled: true,
    ),


    /// Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: Colors.redAccent,
        ).merge(
          ButtonStyle(
              elevation: MaterialStateProperty.all(0),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  )
              ),
              padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 25
                  )
              )
          ),
        )
    ),

    /// AppBar Theme
    appBarTheme: const AppBarTheme(
      color: Colors.transparent,
      elevation: 0
    )

  );

}