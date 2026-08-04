import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../models/note.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final bool isFeatured; // Untuk membedakan kartu bento berukuran besar/utama

  const NoteCard({
    super.key,
    required this.note,
    this.onTap,
    this.onDelete,
    this.isFeatured = false,
  });

  @override
  Widget build(BuildContext context) {
    // Variasi gaya berdasarkan status Featured
    final cardBgColor = isFeatured ? AppColors.primary : AppColors.card;
    final titleColor = isFeatured ? Colors.white : AppColors.textPrimary;
    final contentColor = isFeatured
        ? AppColors.primaryLight
        : AppColors.textSecondary;
    final metaColor = isFeatured ? AppColors.primaryLight : AppColors.textHint;

    return Container(
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isFeatured ? Colors.transparent : AppColors.border,
          width: 1,
        ),
        boxShadow: AppColors.bentoShadow,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Kartu: Badge/Ikon & Aksi Hapus Opsional
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: isFeatured
                            ? Colors.white.withOpacity(0.2)
                            : AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.article_outlined,
                            size: 14,
                            color: isFeatured
                                ? Colors.white
                                : AppColors.primary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Catatan',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: isFeatured
                                  ? Colors.white
                                  : AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (onDelete != null)
                      GestureDetector(
                        onTap: onDelete,
                        child: Icon(
                          Icons.more_horiz_rounded,
                          size: 20,
                          color: metaColor,
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 12),

                // Konten Utama (Judul & Isi)
                Expanded(
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          note.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: titleColor,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          note.content,
                          maxLines: isFeatured ? 5 : 4,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            color: contentColor,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // Footer Kartu: Informasi Waktu
                Row(
                  children: [
                    Icon(Icons.schedule_rounded, size: 14, color: metaColor),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        note.createdAt,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: metaColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
