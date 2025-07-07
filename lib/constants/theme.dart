import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  static const Color primaryColor = Color(0xFFFF6B00);
  static const Color accentColor = Color(0xFF2ECC71);
  static const Color errorColor = Color(0xFFE74C3C);
  static const Color containerLightGreyColor = Color(0xFFF0F0F0);
  static const Color containerDarkGreyColor = Color(0xFF2A2A2A);

  static const LinearGradient lightCardGradient = LinearGradient(
    colors: [Color(0xFFFFE0B2), Color(0xFFFFCC80)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkCardGradient = LinearGradient(
    colors: [Color(0xFF2A2A2A), Color(0xFF1E1E1E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient lightCard = LinearGradient(
    colors: [Color(0xFF81afc7), Color(0xFFd8e1f2)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );




  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    cardColor:containerLightGreyColor,
    iconTheme: const IconThemeData(color: Colors.black87),
    textTheme:  TextTheme(
      bodyLarge: GoogleFonts.poppins(color: const Color(0xFF212121), fontWeight: FontWeight.w600, fontSize: 23.sp, letterSpacing: -0.38),
      bodyMedium: GoogleFonts.poppins(color: const Color(0xFF212121),fontWeight: FontWeight.w500, fontSize: 16.sp, letterSpacing: -0.38),
      bodySmall: GoogleFonts.poppins(color: const Color(0xFF212121),fontWeight: FontWeight.w400, fontSize: 13.sp),
      titleSmall: GoogleFonts.poppins(color: const Color(0xFF212121),fontWeight: FontWeight.w500, fontSize: 13.sp),

    ),
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: accentColor,
      error: errorColor,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFFFF8C42),
    scaffoldBackgroundColor: const Color(0xFF1E1E1E),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF2A2A2A),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    cardColor:containerDarkGreyColor,

    iconTheme: const IconThemeData(color: Colors.white70),
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.poppins(color: const Color(0xFFEEEEEE),fontWeight: FontWeight.w600, fontSize: 23.sp),
    //  TextStyle(color: Color(0xFFEEEEEE)),
      bodyMedium: GoogleFonts.poppins(color: const Color(0xFFEEEEEE),fontWeight: FontWeight.w500, fontSize: 16.sp),
      bodySmall: GoogleFonts.poppins(color: const Color(0xFFEEEEEE),fontWeight: FontWeight.w400, fontSize: 13.sp),
      titleSmall: GoogleFonts.poppins(color: const Color(0xFFEEEEEE),fontWeight: FontWeight.w500, fontSize: 13.sp),
    ),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFFFF8C42),
      secondary: Color(0xFF27AE60),
      error: Color(0xFFE74C3C),
    ),
  );
}
