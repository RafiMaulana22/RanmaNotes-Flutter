import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../models/note.dart';
import '../../services/note_service.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class EditNotePage extends StatefulWidget {
  final Note note;

  const EditNotePage({super.key, required this.note});

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  final NoteService _noteService = NoteService();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _titleController.text = widget.note.title;
    _contentController.text = widget.note.content;
  }

  Future<void> _updateNote() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final updatedNote = widget.note.copyWith(
        title: _titleController.text.trim(),
        content: _contentController.text.trim(),
      );

      await _noteService.updateNote(updatedNote);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(AppStrings.noteUpdated),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );

      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal memperbarui catatan: $e'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _deleteNote() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          backgroundColor: AppColors.surface,
          title: const Text(AppStrings.deleteTitle),
          content: const Text(AppStrings.deleteMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text(AppStrings.cancelButton),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(AppStrings.deleteButton),
            ),
          ],
        );
      },
    );

    if (confirm != true || widget.note.id == null) return;

    await _noteService.deleteNote(widget.note.id!);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(AppStrings.noteDeleted),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );

    Navigator.pop(context, true);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(AppStrings.editNoteTitle),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.textPrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.delete_outline_rounded,
              color: AppColors.error,
            ),
            tooltip: AppStrings.deleteButton,
            onPressed: _deleteNote,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              physics: const BouncingScrollPhysics(),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 700),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Sub-header Info Metadata Catatan
                      Padding(
                        padding: const EdgeInsets.only(left: 4, bottom: 16),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primaryLight,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.schedule_rounded,
                                    size: 14,
                                    color: AppColors.primary,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Dibuat: ${widget.note.createdAt}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Modul Bento Form Card
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(color: AppColors.border, width: 1),
                          boxShadow: AppColors.bentoShadow,
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextField(
                                controller: _titleController,
                                labelText: AppStrings.titleLabel,
                                hintText: AppStrings.titleHint,
                                prefixIcon: Icons.title_rounded,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return AppStrings.titleRequired;
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: 20),

                              CustomTextField(
                                controller: _contentController,
                                labelText: AppStrings.contentLabel,
                                hintText: AppStrings.contentHint,
                                prefixIcon: Icons.notes_rounded,
                                maxLines: 8,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return AppStrings.contentRequired;
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: 28),

                              CustomButton(
                                text: AppStrings.editNoteButton,
                                icon: Icons.check_rounded,
                                isLoading: _isLoading,
                                onPressed: _updateNote,
                              ),

                              const SizedBox(height: 12),

                              CustomButton(
                                text: AppStrings.deleteButton,
                                icon: Icons.delete_forever_rounded,
                                variant: ButtonVariant.outlined,
                                backgroundColor: AppColors.errorContainer,
                                foregroundColor: AppColors.error,
                                onPressed: _deleteNote,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
