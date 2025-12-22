import 'package:flutter/material.dart';

class PixelTheme {
  static const Color primaryGreen = Color(0xFF25D366);
  static const Color darkGreen = Color(0xFF128C7E);
  static const Color darkerGreen = Color(0xFF075E54);
  static const Color lightGreen = Color(0xFFDCF8C6);

  static const Color backgroundDark = Color(0xFF0A141F);
  static const Color backgroundLight = Color(0xFFF0F2F5);
  static const Color surfaceDark = Color(0xFF1A232F);
  static const Color surfaceLight = Color(0xFFFFFFFF);

  static const Color textDark = Color(0xFFFFFFFF);
  static const Color textLight = Color(0xFF111B21);
  static const Color textSecondaryDark = Color(0xFF8696A0);
  static const Color textSecondaryLight = Color(0xFF667781);

  static const Color pixelBorder = Color(0xFF2A3942);
  static const Color pixelHighlight = Color(0xFF4A5A6A);

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: primaryGreen,
      scaffoldBackgroundColor: backgroundDark,
      appBarTheme: const AppBarTheme(
        backgroundColor: darkerGreen,
        foregroundColor: textDark,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: textDark,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: 'Pixel',
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: surfaceDark,
        selectedItemColor: primaryGreen,
        unselectedItemColor: textSecondaryDark,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontFamily: 'Pixel',
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
          fontFamily: 'Pixel',
        ),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          color: textDark,
          fontSize: 16,
          fontFamily: 'Pixel',
        ),
        bodyMedium: TextStyle(
          color: textSecondaryDark,
          fontSize: 14,
          fontFamily: 'Pixel',
        ),
        headlineSmall: TextStyle(
          color: textDark,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: 'Pixel',
        ),
        labelLarge: TextStyle(
          color: textDark,
          fontSize: 14,
          fontWeight: FontWeight.bold,
          fontFamily: 'Pixel',
        ),
      ),
      cardTheme: CardTheme(
        color: surfaceDark,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
          side: const BorderSide(color: pixelBorder, width: 2),
        ),
      ),
      listTileTheme: const ListTileThemeData(
        iconColor: textSecondaryDark,
        textColor: textDark,
      ),
      iconTheme: const IconThemeData(
        color: textSecondaryDark,
        size: 24,
      ),
      dividerTheme: const DividerThemeData(
        color: pixelBorder,
        thickness: 1,
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: primaryGreen,
      scaffoldBackgroundColor: backgroundLight,
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryGreen,
        foregroundColor: textDark,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: textDark,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: 'Pixel',
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: surfaceLight,
        selectedItemColor: primaryGreen,
        unselectedItemColor: textSecondaryLight,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontFamily: 'Pixel',
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
          fontFamily: 'Pixel',
        ),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          color: textLight,
          fontSize: 16,
          fontFamily: 'Pixel',
        ),
        bodyMedium: TextStyle(
          color: textSecondaryLight,
          fontSize: 14,
          fontFamily: 'Pixel',
        ),
        headlineSmall: TextStyle(
          color: textLight,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: 'Pixel',
        ),
        labelLarge: TextStyle(
          color: textLight,
          fontSize: 14,
          fontWeight: FontWeight.bold,
          fontFamily: 'Pixel',
        ),
      ),
      cardTheme: CardTheme(
        color: surfaceLight,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
          side: BorderSide(color: Colors.grey.shade300, width: 2),
        ),
      ),
      listTileTheme: const ListTileThemeData(
        iconColor: textSecondaryLight,
        textColor: textLight,
      ),
      iconTheme: const IconThemeData(
        color: textSecondaryLight,
        size: 24,
      ),
      dividerTheme: DividerThemeData(
        color: Colors.grey.shade300,
        thickness: 1,
      ),
    );
  }

  static BoxDecoration get pixelBorderDecoration {
    return BoxDecoration(
      border: Border.all(color: pixelBorder, width: 2),
      borderRadius: BorderRadius.circular(0),
    );
  }

  static BoxDecoration get pixelButtonDecoration {
    return BoxDecoration(
      color: primaryGreen,
      border: Border.all(color: darkGreen, width: 2),
      borderRadius: BorderRadius.circular(0),
      boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          offset: Offset(2, 2),
          blurRadius: 0,
        ),
      ],
    );
  }

  static EdgeInsets get pixelPadding {
    return const EdgeInsets.all(16);
  }

  static double get pixelBorderRadius {
    return 0;
  }
}