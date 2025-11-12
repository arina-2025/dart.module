class Budget {
  final String category;
  final double limit;
  double _spent = 0;

  Budget({required this.category, required this.limit});

  // Tambahkan pengeluaran ke kategori ini
  void addExpense(double amount) {
    if (amount <= 0) {
      print('Nominal pengeluaran tidak valid');
      return;
    }

    _spent += amount;
    print(
        'Pengeluaran Rp${amount.toStringAsFixed(2)} ditambahkan ke "$category"');

    // Cek kondisi budget
    if (_spent > limit) {
      print('PERINGATAN: Budget "$category" telah terlampaui!');
    } else if (_spent >= limit * 0.9) {
      print('Hati-hati! Pengeluaran untuk "$category" hampir mencapai limit.');
    }
  }

  double get remaining => limit - _spent;
  double get spent => _spent;

  // Cetak ringkasan budget
  void printSummary() {
    String status = _spent > limit
        ? 'Melebihi limit'
        : _spent >= limit * 0.9
            ? 'Hampir penuh'
            : 'Aman';

    print(
        '$category: Rp${_spent.toStringAsFixed(2)} / Rp${limit.toStringAsFixed(2)} ($status)');
  }
}

// ===== CLASS BUDGET MANAGER =====
class BudgetManager {
  final Map<String, Budget> _budgets = {};

  // Tambah atau update budget
  void setBudget(String category, double limit) {
    if (limit <= 0) {
      print('Limit harus lebih dari 0');
      return;
    }
    _budgets[category] = Budget(category: category, limit: limit);
    print(
        'Budget untuk "$category" diset sebesar Rp${limit.toStringAsFixed(2)}');
  }

  // Tambah pengeluaran pada kategori
  void addExpense(String category, double amount) {
    if (!_budgets.containsKey(category)) {
      print('Belum ada budget untuk kategori "$category"');
      return;
    }
    _budgets[category]!.addExpense(amount);
  }

  // Cetak laporan budget keseluruhan
  void generateReport() {
    print('\n===== LAPORAN BUDGET BULAN INI =====');
    if (_budgets.isEmpty) {
      print('Belum ada budget yang ditetapkan.');
      return;
    }

    double totalLimit = 0;
    double totalSpent = 0;

    _budgets.forEach((key, budget) {
      budget.printSummary();
      totalLimit += budget.limit;
      totalSpent += budget.spent;
    });

    print('------------------------------------');
    print(
        'TOTAL: Rp${totalSpent.toStringAsFixed(2)} / Rp${totalLimit.toStringAsFixed(2)}');
  }
}

// ===== MAIN FUNCTION =====
void main() {
  var manager = BudgetManager();

  // Set budget bulanan
  manager.setBudget('Makanan', 500000);
  manager.setBudget('Transportasi', 300000);
  manager.setBudget('Hiburan', 200000);

  print('\n--- Tambah Pengeluaran ---');
  manager.addExpense('Makanan', 150000);
  manager.addExpense('Makanan', 300000);
  manager.addExpense('Makanan', 80000); // ini akan melebihi limit
  manager.addExpense('Transportasi', 250000);
  manager.addExpense('Hiburan', 180000);

  print('\n--- Laporan Akhir ---');
  manager.generateReport();
}