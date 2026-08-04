import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_strings.dart';
import 'custom_button.dart';

class EmptyNotes extends StatelessWidget {
  final VoidCallback? onCreateNotePressed;

  const EmptyNotes({super.key, this.onCreateNotePressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 420),
        margin: const EdgeInsets.all(24),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: AppColors.border, width: 1),
          boxShadow: AppColors.bentoShadow,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ilustrasi Ikon Gaya Bento Modern
            Container(
              width: 88,
              height: 88,
              decoration: const BoxDecoration(
                color: AppColors.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryLight,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.note_add_rounded,
                    size: 34,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Teks Judul
            Text(
              AppStrings.emptyTitle,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
                letterSpacing: -0.3,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            // Deskripsi Pesan Kosong
            Text(
              AppStrings.emptyMessage,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),

            // Action Button Opsional jika dipanggil langsung
            if (onCreateNotePressed != null) ...[
              const SizedBox(height: 24),
              CustomButton(
                text: AppStrings.addNoteTitle,
                icon: Icons.add_rounded,
                isFullWidth: false,
                onPressed: onCreateNotePressed,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
