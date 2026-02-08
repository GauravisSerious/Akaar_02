import 'package:flutter/material.dart';

/// 🎨 Premium Kid-Friendly Theme for A.A.K.A.R
/// Soft pastels, big rounded corners, warm and playful
class AppColors {
  // 🌈 Pastel Palette
  static const Color primaryPurple = Color(0xFF9B8FE8);
  static const Color primaryBlue = Color(0xFF7EC8E3);
  static const Color accentMint = Color(0xFF98E4C1);
  static const Color accentPeach = Color(0xFFFFB5A7);
  static const Color accentYellow = Color(0xFFFFE66D);
  static const Color accentPink = Color(0xFFFFB7D5);
  static const Color backgroundLight = Color(0xFFF8F6FF);
  static const Color cardWhite = Colors.white;
  static const Color textDark = Color(0xFF2D3142);
  static const Color textMuted = Color(0xFF6B7280);
  
  // 🌅 Gradients
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
  
  static const LinearGradient mintGradient = LinearGradient(
    colors: [accentMint, primaryBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient calmGradient = LinearGradient(
    colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

class AppTheme {
  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryPurple,
        brightness: Brightness.light,
        primary: AppColors.primaryPurple,
        secondary: AppColors.primaryBlue,
        surface: AppColors.backgroundLight,
      ),
      
      // 📝 Typography - Large, clear, kid-friendly
      fontFamily: 'Quicksand',
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: AppColors.textDark),
        displayMedium: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: AppColors.textDark),
        headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.textDark),
        titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: AppColors.textDark),
        titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.textDark),
        bodyLarge: TextStyle(fontSize: 18, color: AppColors.textDark),
        bodyMedium: TextStyle(fontSize: 16, color: AppColors.textDark),
      ),
      
      // 🎴 Card Theme - Soft and rounded
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        color: Colors.white,
      ),
      
      // 🔘 Elevated Button - Big, rounded, bouncy
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryPurple,
          foregroundColor: Colors.white,
          elevation: 4,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      
      // 🔲 Outlined Button
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryPurple,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
          side: const BorderSide(color: AppColors.primaryPurple, width: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      
      // 📱 AppBar - Transparent and clean
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.textDark,
        titleTextStyle: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: AppColors.textDark,
        ),
      ),
      
      // 📥 Input fields
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
    );
  }
}
