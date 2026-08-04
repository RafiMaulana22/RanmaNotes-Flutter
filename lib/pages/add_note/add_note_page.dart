import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../models/note.dart';
import '../../services/note_service.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  final NoteService _noteService = NoteService();

  bool _isLoading = false;

  Future<void> _saveNote() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      final note = Note(
        title: _titleController.text.trim(),
        content: _contentController.text.trim(),
        createdAt: DateTime.now().toIso8601String(),
      );

      await _noteService.insertNote(note);

      if (!mounted) return;

      // SnackBar Feedback Modern
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(AppStrings.noteAdded),
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
          content: Text('Gagal menyimpan catatan: $e'),
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
        title: const Text(AppStrings.addNoteTitle),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.textPrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
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
                      // Sub-header Keterangan Bento
                      Padding(
                        padding: const EdgeInsets.only(left: 4, bottom: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Ruang Ide Baru',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Tuliskan ide dan catatan Anda ke dalam Bento Grid',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.textSecondary,
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
                                text: AppStrings.addNoteButton,
                                icon: Icons.save_rounded,
                                isLoading: _isLoading,
                                onPressed: _saveNote,
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
