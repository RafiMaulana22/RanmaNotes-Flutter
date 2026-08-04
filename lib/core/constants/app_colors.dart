import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Brand & Primary Colors
  static const Color primary = Color(0xFF4F46E5);
  static const Color primaryLight = Color(0xFFE0E7FF);
  static const Color primaryDark = Color(0xFF3730A3);
  static const Color primaryContainer = Color(0xFFEEF2FF);

  // Accent Colors (Untuk Variasi Kartu Bento)
  static const Color accentIndigo = Color(0xFF6366F1);
  static const Color accentPurple = Color(0xFF8B5CF6);
  static const Color accentSky = Color(0xFF0EA5E9);
  static const Color accentTeal = Color(0xFF14B8A6);

  // Background & Surface
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF1F5F9);

  // Text & Typography
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF475569);
  static const Color textMuted = Color(0xFF64748B);
  static const Color textHint = Color(0xFF94A3B8);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // Border & Dividers
  static const Color border = Color(0xFFE2E8F0);
  static const Color borderSubtle = Color(0xFFF1F5F9);
  static const Color divider = Color(0xFFE5E7EB);

  // Status & Alerts
  static const Color success = Color(0xFF22C55E);
  static const Color successContainer = Color(0xFFDCFCE7);

  static const Color warning = Color(0xFFF59E0B);
  static const Color warningContainer = Color(0xFFFEF3C7);

  static const Color error = Color(0xFFEF4444);
  static const Color errorContainer = Color(0xFFFEE2E2);

  static const Color info = Color(0xFF3B82F6);
  static const Color infoContainer = Color(0xFFDBEAFE);

  // Icons & Interactive Controls
  static const Color icon = Color(0xFF475569);
  static const Color iconSecondary = Color(0xFF94A3B8);
  static const Color iconActive = Color(0xFF4F46E5);

  // Cards, Elevational Shadows & Gradients (Gaya Modern Bento)
  static const Color card = Color(0xFFFFFFFF);

  // Shadows
  static const Color shadowColor = Color(
    0x0F0F172A,
  ); // Soft ambient shadow (6% opacity)
  static const Color shadowColorHover = Color(
    0x1F0F172A,
  ); // Stronger elevation shadow (12% opacity)

  static const List<BoxShadow> bentoShadow = [
    BoxShadow(color: Color(0x0A0F172A), blurRadius: 10, offset: Offset(0, 4)),
    BoxShadow(color: Color(0x050F172A), blurRadius: 25, offset: Offset(0, 10)),
  ];

  // Gradients untuk Featured/Hero Bento Cards
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF6366F1), Color(0xFF4F46E5), Color(0xFF3730A3)],
  );

  static const LinearGradient surfaceGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFFFFF), Color(0xFFF8FAFC)],
  );
}
