class Expense {
  String description;
  double amount;
  String category;
  DateTime date;

  Expense({
    required this.description,
    required this.amount,
    required this.category,
    DateTime? date,
  }) : this.date = date ?? DateTime.now();

  /// Kembalikan jumlah sebagai string terformat (2 desimal) dengan prefix Rp
  String getFormattedAmount() {
    return 'Rp${amount.toStringAsFixed(2)}';
  }

  /// Bulatkan jumlah (contoh: 15.99 -> 16.0)
  double getAmountRounded() {
    return amount.roundToDouble();
  }

  /// Rata-rata harian selama [days] hari. Jika days <= 0 -> 0
  double getDailyAverage(int days) {
    if (days <= 0) return 0;
    return amount / days;
  }

  /// Proyeksi tahunan (asumsi biaya per bulan)
  double projectedYearly() {
    return amount * 12;
  }
}

void main() {
  var subscription = Expense(
    description: 'Netflix',
    amount: 15.99,
    category: 'Hiburan',
  );

  print('Jumlah: ${subscription.getFormattedAmount()}');
  print('Dibulatkan: ${subscription.getAmountRounded().toStringAsFixed(2)}');
  print('Rata-rata harian (30 hari): ${subscription.getDailyAverage(30).toStringAsFixed(2)}');
  print('Proyeksi tahunan: ${subscription.projectedYearly().toStringAsFixed(2)}');
}
