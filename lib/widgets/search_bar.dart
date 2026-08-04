import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_strings.dart';

class SearchBarWidget extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback? onFilterTap;

  const SearchBarWidget({
    super.key,
    required this.controller,
    required this.onChanged,
    this.onFilterTap,
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {}); // Memperbarui UI tombol clear saat teks berubah
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border, width: 1),
        boxShadow: AppColors.bentoShadow,
      ),
      child: TextField(
        controller: widget.controller,
        onChanged: widget.onChanged,
        style: const TextStyle(
          fontSize: 15,
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: AppStrings.searchHint,
          hintStyle: const TextStyle(
            color: AppColors.textHint,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          filled: true,
          fillColor: Colors.transparent,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),

          // Ikon Pencarian Modern
          prefixIcon: const Padding(
            padding: EdgeInsets.only(left: 16, right: 10),
            child: Icon(Icons.search_rounded, size: 22, color: AppColors.icon),
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 48,
            minHeight: 48,
          ),

          // Suffix Actions (Tombol Clear & Tombol Filter Opsional)
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.controller.text.isNotEmpty)
                IconButton(
                  splashRadius: 20,
                  icon: const Icon(
                    Icons.cancel_rounded,
                    size: 18,
                    color: AppColors.iconSecondary,
                  ),
                  onPressed: () {
                    widget.controller.clear();
                    widget.onChanged('');
                  },
                ),
              if (widget.onFilterTap != null) ...[
                Container(
                  height: 24,
                  width: 1,
                  color: AppColors.divider,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                ),
                IconButton(
                  splashRadius: 20,
                  icon: const Icon(
                    Icons.tune_rounded,
                    size: 20,
                    color: AppColors.primary,
                  ),
                  onPressed: widget.onFilterTap,
                ),
                const SizedBox(width: 4),
              ],
            ],
          ),

          // Mengabaikan border internal agar menggunakan border dari Container
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
        ),
      ),
    );
  }
}
