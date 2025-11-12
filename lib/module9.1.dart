// ===== CLASS CATEGORY MANAGER =====
class CategoryManager {
  // Daftar kategori awal (default)
  final List<String> _categories = ['Makanan', 'Transportasi', 'Tagihan'];

  // Menambahkan kategori baru (hindari duplikat)
  void addCategory(String category) {
    if (category.trim().isEmpty) {
      print('❌ Nama kategori tidak boleh kosong');
      return;
    }
    if (_categories.contains(category)) {
      print('⚠️ Kategori "$category" sudah ada');
    } else {
      _categories.add(category);
      print('✅ Kategori "$category" berhasil ditambahkan');
    }
  }

  // Menghapus kategori jika ada
  void removeCategory(String category) {
    if (_categories.remove(category)) {
      print('🗑️ Kategori "$category" dihapus');
    } else {
      print('❌ Kategori "$category" tidak ditemukan');
    }
  }

  // Getter untuk semua kategori (read-only)
  List<String> get allCategories => List.unmodifiable(_categories);

  // Menampilkan daftar kategori ke layar
  void printCategories() {
    print('📂 Daftar Kategori (${_categories.length} total):');
    for (var c in _categories) {
      print(' - $c');
    }
  }
}

// ===== MAIN FUNCTION =====
void main() {
  var manager = CategoryManager();

  manager.printCategories();

  print('\n--- Tambah Kategori ---');
  manager.addCategory('Hiburan');
  manager.addCategory('Pendidikan');
  manager.addCategory('Makanan'); // duplikat

  print('\n--- Hapus Kategori ---');
  manager.removeCategory('Tagihan');
  manager.removeCategory('Olahraga'); // tidak ada

  print('\n--- Daftar Akhir ---');
  manager.printCategories();
}