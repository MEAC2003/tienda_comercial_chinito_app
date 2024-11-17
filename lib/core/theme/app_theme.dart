import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
        // Font
        fontFamily: GoogleFonts.poppins().fontFamily,
        textTheme: GoogleFonts.poppinsTextTheme(),
        // Colors
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryColor,
          brightness: Brightness.light,
          primary: AppColors.primaryColor,
        ),
      );

  static ThemeData get darkTheme => ThemeData(
        // Font
        fontFamily: GoogleFonts.poppins().fontFamily,
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
        // Colors
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryGrey,
          brightness: Brightness.dark,
          primary: AppColors.primaryGrey,
        ),
      );
}
