import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final String hintText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final int maxLines;
  final TextInputType keyboardType;
  final bool readOnly;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final bool showClearButton;

  const CustomTextField({
    super.key,
    required this.controller,
    this.labelText,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
    this.validator,
    this.onChanged,
    this.showClearButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Top Label (jika disediakan) untuk hierarki visual modern
        if (labelText != null && labelText!.isNotEmpty) ...[
          Text(
            labelText!,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
              letterSpacing: 0.1,
            ),
          ),
          const SizedBox(height: 8),
        ],

        // Container Input Field
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          readOnly: readOnly,
          validator: validator,
          onChanged: onChanged,
          style: const TextStyle(
            fontSize: 15,
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              color: AppColors.textHint,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            filled: true,
            fillColor: readOnly ? AppColors.surfaceVariant : AppColors.surface,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 18,
              vertical: maxLines > 1 ? 16 : 14,
            ),

            // Prefiks Ikon Modern
            prefixIcon: prefixIcon != null
                ? Padding(
                    padding: const EdgeInsets.only(left: 14, right: 10),
                    child: Icon(prefixIcon, size: 20, color: AppColors.icon),
                  )
                : null,
            prefixIconConstraints: const BoxConstraints(
              minWidth: 44,
              minHeight: 44,
            ),

            // Suffix Ikon / Tombol Clear
            suffixIcon: showClearButton && controller.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(
                      Icons.cancel_rounded,
                      size: 18,
                      color: AppColors.iconSecondary,
                    ),
                    onPressed: () {
                      controller.clear();
                      if (onChanged != null) onChanged!('');
                    },
                  )
                : suffixIcon,

            // Border Styling (Menyesuaikan estetika Bento & AppTheme)
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: AppColors.border, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: AppColors.error, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: AppColors.error, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
