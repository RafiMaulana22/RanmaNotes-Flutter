import 'package:sqflite/sqflite.dart';

import '../core/constants/app_strings.dart';
import '../core/helpers/database_helper.dart';
import '../models/note.dart';

class NoteService {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  /// Get database instance
  Future<Database> get _database async {
    return await _databaseHelper.database;
  }

  /// Create Note
  Future<int> insertNote(Note note) async {
    final db = await _database;

    return await db.insert(
      AppStrings.notesTable,
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Read All Notes
  Future<List<Note>> getAllNotes() async {
    final db = await _database;

    final List<Map<String, dynamic>> maps = await db.query(
      AppStrings.notesTable,
      orderBy: 'id DESC',
    );

    return maps.map((map) => Note.fromMap(map)).toList();
  }

  /// Read Note By ID
  Future<Note?> getNoteById(int id) async {
    final db = await _database;

    final maps = await db.query(
      AppStrings.notesTable,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Note.fromMap(maps.first);
    }

    return null;
  }

  /// Update Note
  Future<int> updateNote(Note note) async {
    final db = await _database;

    return await db.update(
      AppStrings.notesTable,
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  /// Delete Note
  Future<int> deleteNote(int id) async {
    final db = await _database;

    return await db.delete(
      AppStrings.notesTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Search Notes
  Future<List<Note>> searchNotes(String keyword) async {
    final db = await _database;

    final maps = await db.query(
      AppStrings.notesTable,
      where: 'title LIKE ? OR content LIKE ?',
      whereArgs: [
        '%$keyword%',
        '%$keyword%',
      ],
      orderBy: 'id DESC',
    );

    return maps.map((map) => Note.fromMap(map)).toList();
  }
}
