class AppStrings {
  AppStrings._();

  // App Meta
  static const String appName = 'RanmaNotes';
  static const String appVersion = '1.0.0';

  // Splash & Onboarding
  static const String splashTitle = 'RanmaNotes';
  static const String splashSubtitle = 'Smart Bento Workspace & Personal Notes';

  // Home & Bento Header
  static const String homeTitle = 'Bento Workspace';
  static const String homeSubtitle = 'Kelola ide dan catatan Anda secara visual';
  static const String greetingMorning = 'Selamat Pagi';
  static const String greetingAfternoon = 'Selamat Siang';
  static const String greetingEvening = 'Selamat Malam';
  static const String searchHint = 'Cari catatan, tag, atau ide...';

  // Bento Modules & Card Headers
  static const String bentoFeaturedTitle = 'Catatan Disematkan';
  static const String bentoRecentTitle = 'Terbaru Ditambahkan';
  static const String bentoStatsTitle = 'Ringkasan Ide';
  static const String bentoQuickNoteTitle = 'Catatan Cepat';

  // Layout & View Modes
  static const String viewAsGrid = 'Tampilan Bento Grid';
  static const String viewAsList = 'Tampilan Daftar';
  static const String filterAll = 'Semua';
  static const String filterPinned = 'Disematkan';
  static const String filterFavorites = 'Favorit';

  // Empty State
  static const String emptyTitle = 'Ruang Kerja Masih Kosong';
  static const String emptyMessage =
      'Mulai tuangkan ide Anda. Ketuk tombol + untuk membuat kartu catatan pertama.';

  // Add & Edit Note
  static const String addNoteTitle = 'Buat Catatan';
  static const String addNoteButton = 'Simpan Catatan';
  static const String editNoteTitle = 'Edit Catatan';
  static const String editNoteButton = 'Perbarui Catatan';

  // Form & Inputs
  static const String titleLabel = 'Judul Catatan';
  static const String titleHint = 'Ketik judul ide Anda...';
  static const String contentLabel = 'Isi Catatan';
  static const String contentHint = 'Tuliskan detail atau deskripsi di sini...';
  static const String categoryLabel = 'Kategori';
  static const String categoryHint = 'Pilih atau pilih tag';

  // Note Metadata & Indicators
  static const String pinNote = 'Sematkan ke Bento Grid';
  static const String unpinNote = 'Lepas Sematan';
  static const String totalNotes = 'Total Catatan';
  static const String wordCount = 'Kata';
  static const String lastUpdated = 'Terakhir diubah';

  // Validation
  static const String titleRequired = 'Judul tidak boleh kosong';
  static const String contentRequired = 'Isi catatan tidak boleh kosong';

  // Dialogs & Actions
  static const String deleteTitle = 'Hapus Catatan?';
  static const String deleteMessage =
      'Tindakan ini akan menghapus kartu catatan secara permanen dari ruang kerja Anda.';
  static const String deleteButton = 'Hapus';
  static const String cancelButton = 'Batal';

  // Success & Toast Notifications
  static const String noteAdded = 'Catatan berhasil ditambahkan ke Bento Grid.';
  static const String noteUpdated = 'Perubahan berhasil disimpan.';
  static const String noteDeleted = 'Catatan telah dihapus.';

  // Common Controls
  static const String save = 'Simpan';
  static const String update = 'Perbarui';
  static const String delete = 'Hapus';
  static const String cancel = 'Batal';
  static const String yes = 'Ya';
  static const String no = 'Tidak';

  // Database Constants
  static const String databaseName = 'ranma_notes.db';
  static const String notesTable = 'notes';
}
