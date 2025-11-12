class Expense {
  final String description;
  final double amount;
  final String category;
  final DateTime date;

  Expense({
    required this.description,
    required this.amount,
    required this.category,
    DateTime? date,
  }) : this.date = date ?? DateTime.now();

  String _fmt(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  void printDetails() {
    print('📌 PENGELUARAN');
    print('  Deskripsi : $description');
    print('  Kategori  : $category');
    print('  Jumlah    : Rp ${amount.toStringAsFixed(2)}');
    print('  Tanggal   : ${_fmt(date)}');
  }
}

class RecurringExpense extends Expense {
  final String frequency; // contoh: 'bulanan', 'mingguan'

  RecurringExpense({
    required String description,
    required double amount,
    required String category,
    required this.frequency,
    DateTime? date,
  }) : super(
         description: description,
         amount: amount,
         category: category,
         date: date,
       );

  double yearlyTotal() {
    if (frequency.toLowerCase() == 'bulanan') {
      return amount * 12;
    }
    // fallback: anggap amount per bulan
    return amount * 12;
  }
}

class SubscriptionExpense extends RecurringExpense {
  final String provider;
  final String plan;
  final DateTime startDate;
  final DateTime? endDate;

  SubscriptionExpense({
    required String description,
    required double amount,
    required this.provider,
    required this.plan,
    required this.startDate,
    this.endDate,
  }) : super(
         description: description,
         amount: amount,
         category: 'Langganan',
         frequency: 'bulanan',
         date: startDate, // set tanggal dasar sebagai startDate
       );

  bool isActive() {
    final now = DateTime.now();
    if (now.isBefore(startDate)) return false; // belum mulai
    if (endDate == null) return true; // berkelanjutan
    return !now.isAfter(endDate!); // aktif jika sekarang <= endDate
  }

  /// Hitung sisa bulan dari 'from' (sekarang atau startDate jika belum mulai) hingga endDate.
  /// Jika endDate==null -> -1 (tak terbatas).
  int getRemainingMonths() {
    if (endDate == null) return -1;
    final now = DateTime.now();
    if (now.isAfter(endDate!)) return 0;

    final from = now.isBefore(startDate) ? startDate : now;

    int months = (endDate!.year - from.year) * 12 + (endDate!.month - from.month);
    // jika endDate.day >= from.day, tambahkan 1 untuk inklusif bulan terakhir
    if (endDate!.day >= from.day) months += 1;
    if (months < 0) months = 0;
    return months;
  }

  /// Hitung total biaya antara startDate dan endDate (bulan penuh, inklusif).
  /// Jika endDate==null, kembalikan proyeksi tahunan (yearlyTotal).
  double getTotalCost() {
    if (endDate == null) return yearlyTotal();

    int months = (endDate!.year - startDate.year) * 12 + (endDate!.month - startDate.month);
    if (endDate!.day >= startDate.day) months += 1;
    if (months < 0) months = 0;
    return amount * months;
  }

  @override
  void printDetails() {
    String _fmt(DateTime d) =>
        '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

    print('📱 LANGGANAN');
    print('$description ($provider - $plan)');
    print('Biaya: Rp ${amount.toStringAsFixed(2)}/bulan');
    print('Mulai: ${_fmt(startDate)}');

    if (endDate != null) {
      print('Berakhir: ${_fmt(endDate!)}');
      final rem = getRemainingMonths();
      print('Sisa: ${rem == -1 ? "Tak terbatas" : "$rem bulan"}');
    } else {
      print('Berakhir: Tidak pernah (berkelanjutan)');
      print('Sisa: Tak terbatas');
    }

    print('Status: ${isActive() ? "Aktif ✅" : (DateTime.now().isBefore(startDate) ? "Belum mulai ⏳" : "Expired ❌")}');
    print('Total biaya: Rp ${getTotalCost().toStringAsFixed(2)}');
  }
}

void main() {
  var netflix = SubscriptionExpense(
    description: 'Netflix Premium',
    amount: 186000,
    provider: 'Netflix',
    plan: 'Premium 4K',
    startDate: DateTime(2024, 1, 1),
    endDate: null, // berkelanjutan
  );

  var trial = SubscriptionExpense(
    description: 'Adobe Creative Cloud',
    amount: 800000,
    provider: 'Adobe',
    plan: 'Semua Apps',
    startDate: DateTime(2025, 9, 1),
    endDate: DateTime(2025, 12, 31),
  );

  netflix.printDetails();
  print('');
  trial.printDetails();
}
