import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../models/note.dart';
import '../../services/note_service.dart';
import '../../widgets/empty_notes.dart';
import '../../widgets/note_card.dart';
import '../../widgets/search_bar.dart';
import '../add_note/add_note_page.dart';
import '../edit_note/edit_note_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NoteService _noteService = NoteService();
  final TextEditingController _searchController = TextEditingController();

  List<Note> _notes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    setState(() => _isLoading = true);
    final notes = await _noteService.getAllNotes();

    if (!mounted) return;

    setState(() {
      _notes = notes;
      _isLoading = false;
    });
  }

  Future<void> _searchNotes(String keyword) async {
    if (keyword.trim().isEmpty) {
      _loadNotes();
      return;
    }

    final result = await _noteService.searchNotes(keyword);

    setState(() {
      _notes = result;
    });
  }

  Future<void> _goToAddPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddNotePage()),
    );

    if (result == true) {
      await _loadNotes();
    }
  }

  Future<void> _goToEditPage(Note note) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => EditNotePage(note: note)),
    );

    _loadNotes();
  }

  Future<void> _deleteNote(Note note) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: AppColors.surface,
        title: const Text(AppStrings.deleteTitle),
        content: const Text(AppStrings.deleteMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(AppStrings.cancelButton),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text(AppStrings.deleteButton),
          ),
        ],
      ),
    );

    if (confirm == true && note.id != null) {
      await _noteService.deleteNote(note.id!);
      _loadNotes();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Deteksi Responsif Kolom Grid
            int crossAxisCount = 2;
            if (constraints.maxWidth > 900) {
              crossAxisCount = 4; // Tablet Besar / Desktop
            } else if (constraints.maxWidth > 600) {
              crossAxisCount = 3; // Foldable / Tablet Kecil
            }

            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // Header Area Bento Workspace
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Top Bar Header & Stat Badge
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  AppStrings.splashTitle,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  AppStrings.homeTitle,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                              ],
                            ),
                            // Counter Badge Module
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primaryLight,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.sticky_note_2_rounded,
                                    size: 16,
                                    color: AppColors.primary,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    '${_notes.length} Catatan',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Search Bar Widget
                        SearchBarWidget(
                          controller: _searchController,
                          onChanged: _searchNotes,
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),

                // Grid Bento Notes atau Empty State
                if (_isLoading)
                  const SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    ),
                  )
                else if (_notes.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: EmptyNotes(onCreateNotePressed: _goToAddPage),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        mainAxisExtent: 270,
                      ),
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final note = _notes[index];
                        // Catatan pertama menjadi Featured Hero Card
                        final isFeatured =
                            index == 0 && _searchController.text.isEmpty;

                        return NoteCard(
                          note: note,
                          isFeatured: isFeatured,
                          onTap: () => _goToEditPage(note),
                          onDelete: () => _deleteNote(note),
                        );
                      }, childCount: _notes.length),
                    ),
                  ),

                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 80,
                  ), // Padding ruang FloatingActionButton
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToAddPage,
        elevation: 4,
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: const Text(
          'Catatan Baru',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
