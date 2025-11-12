class Expense {
  String description;
  double amount;
  String category;
  DateTime date;

  Expense({
    required this.description,
    required this.amount,
    required this.category,
    required this.date,
  });

  int getWeekNumber() {
    // Hitung day of year secara manual
    final beginningOfYear = DateTime(date.year, 1, 1);
    final dayOfYear = date.difference(beginningOfYear).inDays + 1;

    // Rumus ISO-like week number (umum dipakai)
    return ((dayOfYear - date.weekday + 10) / 7).floor();
  }

  int getQuarter() {
    return ((date.month - 1) / 3).floor() + 1;
  }

  bool isWeekend() {
    return date.weekday == DateTime.saturday ||
           date.weekday == DateTime.sunday;
  }
}

void main() {
  var expense = Expense(
    description: 'Brunch akhir pekan',
    amount: 45.00,
    category: 'Makanan',
    date: DateTime(2025, 10, 11), // Sabtu
  );

  print('Kuartal: ${expense.getQuarter()}');               // => Kuartal: 4
  print('Akhir pekan? ${expense.isWeekend()}');           // => Akhir pekan? true
  print('Minggu ke: ${expense.getWeekNumber()}');         // contoh: Minggu ke: 41 (tergantung aturan)
}
