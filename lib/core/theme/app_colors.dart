import 'package:flutter/material.dart';

/// App color palette matching the Figma 8-Screen AutoPassport system.
abstract class AppColors {
  // Backgrounds
  static const Color darkBackground = Color(0xFF0B101D); // Deep Slate Navy
  static const Color darkSurface = Color(0xFF111A2E); // Elevated Card Surface
  static const Color darkSurfaceVariant = Color(0xFF16223D); // Secondary / Nested Card Surface
  static const Color darkBorder = Color(0xFF1E2D4A); // Clean card borders
  static const Color darkDivider = Color(0xFF19253E);

  // Light Palette (Fallback & Theme Support)
  static const Color lightBackground = Color(0xFFF8FAFC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceVariant = Color(0xFFF1F5F9);
  static const Color lightBorder = Color(0xFFE2E8F0);
  static const Color lightTextPrimary = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF64748B);
  static const Color lightTextMuted = Color(0xFF94A3B8);

  // Primary Accent & Action Colors
  static const Color primary = Color(0xFF2563EB); // Vibrant Electric Blue
  static const Color primaryLight = Color(0xFF38BDF8); // Sky Cyan
  static const Color primaryDark = Color(0xFF1D4ED8); // Deep Blue

  // Status & Verification Badges
  static const Color verified = Color(0xFF10B981); // Emerald Green (14 Verified)
  static const Color verifiedBg = Color(0xFF064E3B);
  static const Color warning = Color(0xFFF59E0B); // Amber (Photo-Verified Part / Informal Master)
  static const Color warningBg = Color(0xFF451A03);
  static const Color error = Color(0xFFEF4444); // Crimson
  static const Color info = Color(0xFF3B82F6); // Formal Store Receipt Blue
  static const Color purple = Color(0xFF8B5CF6); // AI Voice Parser

  // Typography Colors (Dark Mode Default)
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFF64748B);

  // Aliases for Dark Text
  static const Color darkTextPrimary = textPrimary;
  static const Color darkTextSecondary = textSecondary;
  static const Color darkTextMuted = textMuted;

  // Status Aliases
  static const Color pending = warning;
  static const Color expired = error;
  static const Color accent = primaryLight;

  // Currency & Badge Accents
  static const Color amdCurrency = Color(0xFF2563EB); // Armenian Dram Blue
  static const Color idramOrange = Color(0xFFF97316); // Idram transfer badge

  // Gradients
  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFF131F37), Color(0xFF0E172B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient metallicCardGradient = LinearGradient(
    colors: [Color(0xFF16223D), Color(0xFF0F172A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cyanGlowGradient = LinearGradient(
    colors: [Color(0xFF38BDF8), Color(0xFF2563EB)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient proBadgeGradient = LinearGradient(
    colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient blueButtonGradient = LinearGradient(
    colors: [Color(0xFF2563EB), Color(0xFF1D4ED8)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF2563EB), Color(0xFF1D4ED8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
