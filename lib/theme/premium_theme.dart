import 'package:flutter/material.dart';

/// Premium Kid-Friendly Theme for A.A.K.A.R
/// Soft pastels, rounded corners, warm and playful
class PremiumTheme {
  // 🎨 Pastel Color Palette
  static const Color primaryPurple = Color(0xFF8B7FD6);
  static const Color primaryBlue = Color(0xFF6EC8E8);
  static const Color accentMint = Color(0xFF88DEB8);
  static const Color accentPeach = Color(0xFFFFB4A2);
  static const Color accentYellow = Color(0xFFFFE66D);
  static const Color neutralLight = Color(0xFFF5F7FA);
  static const Color neutralDark = Color(0xFF2D3748);
  
  // 🌈 Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryPurple, primaryBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient warmGradient = LinearGradient(
    colors: [accentPeach, accentYellow],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient calmGradient = LinearGradient(
    colors: [Color(0xFF5E35B1), Color(0xFF1A237E)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  // 📐 Shapes
  static const double borderRadiusSmall = 12.0;
  static const double borderRadiusMedium = 20.0;
  static const double borderRadiusLarge = 30.0;
  
  // 🎭 Shadows
  static List<BoxShadow> softShadow = [
    BoxShadow(
      color: primaryPurple.withOpacity(0.15),
      blurRadius: 20,
      offset: const Offset(0, 8),
    ),
  ];
  
  static List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.08),
      blurRadius: 15,
      offset: const Offset(0, 4),
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.04),
      blurRadius: 30,
      offset: const Offset(0, 10),
    ),
  ];
  
  // 🎨 Theme Data
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryPurple,
        brightness: Brightness.light,
        primary: primaryPurple,
        secondary: primaryBlue,
        surface: neutralLight,
      ),
      
      // Typography - Kid-friendly, large and clear
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.bold,
          color: neutralDark,
        ),
        displayMedium: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: neutralDark,
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: neutralDark,
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: neutralDark,
        ),
        bodyLarge: TextStyle(
          fontSize: 18,
          color: neutralDark,
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          color: neutralDark,
        ),
      ),
      
      // Card Theme
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadiusMedium),
        ),
        color: Colors.white,
        shadowColor: Colors.black.withOpacity(0.1),
      ),
      
      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryPurple,
          foregroundColor: Colors.white,
          elevation: 4,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadiusLarge),
          ),
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryPurple,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          side: const BorderSide(color: primaryPurple, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadiusLarge),
          ),
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // AppBar Theme
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: neutralDark,
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: neutralDark,
        ),
      ),
    );
  }
}
