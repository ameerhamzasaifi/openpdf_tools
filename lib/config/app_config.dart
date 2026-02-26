import 'package:flutter/material.dart';
import 'package:openpdf_tools/utils/platform_helper.dart';

/// Global app configuration
class AppConfig {
  // App constants
  static const String appTitle = 'OpenPDF Tools';
  static const String appVersion = '1.0.0';
  static const String githubUrl =
      'https://github.com/AHS-Mobile-Labs/openpdf_tools';

  // Colors
  static const Color primaryColor = Color(0xFFC6302C);
  static const Color darkRedColor = Color(0xFF9A0000);
  static const Color accentColor = Color(0xFFFFB81C);

  // Responsive breakpoints
  static const double mobileMaxWidth = 600;
  static const double tabletMaxWidth = 1200;

  // Font sizes
  static const double fontSizeSmall = 12;
  static const double fontSizeBase = 14;
  static const double fontSizeLarge = 16;
  static const double fontSizeXLarge = 20;
  static const double fontSizeXXLarge = 24;

  // Padding & margins
  static const double paddingXSmall = 4;
  static const double paddingSmall = 8;
  static const double paddingBase = 12;
  static const double paddingLarge = 16;
  static const double paddingXLarge = 24;

  // Border radius
  static const double radiusSmall = 4;
  static const double radiusBase = 8;
  static const double radiusLarge = 12;
  static const double radiusXLarge = 16;

  /// Get theme data for the app
  static ThemeData getThemeData({bool isDark = false}) {
    if (isDark) {
      return _getDarkThemeData();
    }
    return _getLightThemeData();
  }

  /// Get light theme
  static ThemeData _getLightThemeData() {
    // Modern light theme with vibrant colors and good contrast
    const lightBgColor = Color(0xFFF8F9FA); // Clean light gray background
    const lightSurfaceColor = Color(0xFFFFFFFF); // Pure white for cards
    const lightSecondaryColor = Color(0xFF4A90E2); // Professional blue
    // const lightAccentRed = Color(0xFFE94560); // Vibrant pink-red
    // const lightAccentGreen = Color(0xFF2ECC71); // Fresh green

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: lightBgColor,
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        onPrimary: Colors.white,
        secondary: lightSecondaryColor,
        onSecondary: Colors.white,
        surface: lightSurfaceColor,
        error: Colors.red,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 1,
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusBase),
          ),
          elevation: 2,
          textStyle: const TextStyle(
            fontSize: fontSizeBase,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColor,
          textStyle: const TextStyle(
            fontSize: fontSizeBase,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 1,
        color: lightSurfaceColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusBase),
          side: const BorderSide(color: Color(0xFFE0E0E0), width: 0.5),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFF5F5F5),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: paddingLarge,
          vertical: paddingBase,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusBase),
          borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusBase),
          borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusBase),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          color: Color(0xFF333333),
          fontWeight: FontWeight.w500,
        ),
        bodyMedium: TextStyle(color: Color(0xFF555555)),
        labelLarge: TextStyle(
          color: Color(0xFF333333),
          fontWeight: FontWeight.w500,
        ),
        headlineSmall: TextStyle(
          color: Color(0xFF222222),
          fontWeight: FontWeight.bold,
        ),
        titleMedium: TextStyle(
          color: Color(0xFF222222),
          fontWeight: FontWeight.w600,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: lightSurfaceColor,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey[600],
        elevation: 1,
      ),
    );
  }

  /// Get dark theme
  static ThemeData _getDarkThemeData() {
    // Modern dark theme with better colors
    const darkBgColor = Color(
      0xFF1A1A2E,
    ); // Deep blue-gray instead of pure black
    const darkCardColor = Color(0xFF16213E); // Darker blue-gray
    const darkSurfaceColor = Color(0xFF0F3460); // Rich dark blue
    const accentOrange = Color(0xFFE94560); // Vibrant pink-red
    // const accentBlue = Color(0xFF4A90E2); // Professional blue
    // const accentGreen = Color(0xFF2ECC71); // Fresh green

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: darkBgColor,
      colorScheme: ColorScheme.dark(
        primary: primaryColor,
        onPrimary: Colors.white,
        secondary: accentOrange,
        onSecondary: Colors.white,
        tertiary: const Color(0xFFFFB81C),
        surface: darkCardColor,
        onSurface: Colors.white,
        error: Colors.redAccent,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF16213E),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusBase),
          ),
          textStyle: const TextStyle(
            fontSize: fontSizeBase,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: accentOrange,
          textStyle: const TextStyle(
            fontSize: fontSizeBase,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: darkCardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusBase),
          side: const BorderSide(color: Color(0xFF0F3460), width: 0.5),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkSurfaceColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: paddingLarge,
          vertical: paddingBase,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusBase),
          borderSide: const BorderSide(color: Color(0xFF0F3460)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusBase),
          borderSide: const BorderSide(color: Color(0xFF0F3460)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusBase),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Color(0xFFE8E8E8)),
        bodyMedium: TextStyle(color: Color(0xFFD0D0D0)),
        labelLarge: TextStyle(color: Color(0xFFE8E8E8)),
        headlineSmall: TextStyle(color: Colors.white),
        titleMedium: TextStyle(color: Colors.white),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: darkCardColor,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey[500],
      ),
    );
  }

  /// Get window size configuration
  static (double width, double height) getWindowSize() {
    if (PlatformHelper.isWindows) {
      return (1400, 900);
    } else if (PlatformHelper.isMacOS) {
      return (1300, 850);
    } else if (PlatformHelper.isLinux) {
      return (1300, 850);
    }
    return (1400, 900);
  }

  /// Get animation duration
  static Duration get animationDuration => const Duration(milliseconds: 300);
  static Duration get shortAnimationDuration =>
      const Duration(milliseconds: 150);
  static Duration get longAnimationDuration =>
      const Duration(milliseconds: 500);

  /// Check if should use compact layout
  static bool shouldUseCompactLayout(double screenWidth) {
    return screenWidth < mobileMaxWidth;
  }

  /// Get app bar height based on platform
  static double getAppBarHeight() {
    if (PlatformHelper.isMobile) return 56;
    return 64;
  }

  /// Get navigation bar height
  static double getNavigationBarHeight() {
    if (PlatformHelper.isMobile) return 56;
    return 64;
  }
}
