import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';

enum ButtonVariant { primary, secondary, outlined }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final bool isFullWidth;
  final ButtonVariant variant;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double height;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = true,
    this.variant = ButtonVariant.primary,
    this.backgroundColor,
    this.foregroundColor,
    this.height = 52,
  });

  @override
  Widget build(BuildContext context) {
    // Menentukan warna berdasarkan varian tombol
    final effectiveBgColor = backgroundColor ?? _getBackgroundColor();
    final effectiveFgColor = foregroundColor ?? _getForegroundColor();

    final childWidget = isLoading
        ? SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              valueColor: AlwaysStoppedAnimation<Color>(effectiveFgColor),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 20, color: effectiveFgColor),
                const SizedBox(width: 8),
              ],
              Text(
                text,
                style: TextStyle(
                  color: effectiveFgColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          );

    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: effectiveBgColor,
      foregroundColor: effectiveFgColor,
      elevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: variant == ButtonVariant.outlined
            ? const BorderSide(color: AppColors.border, width: 1.5)
            : BorderSide.none,
      ),
    );

    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: buttonStyle,
        child: childWidget,
      ),
    );
  }

  Color _getBackgroundColor() {
    switch (variant) {
      case ButtonVariant.primary:
        return AppColors.primary;
      case ButtonVariant.secondary:
        return AppColors.primaryLight;
      case ButtonVariant.outlined:
        return AppColors.surface;
    }
  }

  Color _getForegroundColor() {
    switch (variant) {
      case ButtonVariant.primary:
        return Colors.white;
      case ButtonVariant.secondary:
        return AppColors.primary;
      case ButtonVariant.outlined:
        return AppColors.textPrimary;
    }
  }
}
