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

  String _pad(int n) => n.toString().padLeft(2, '0');

  void printDetails() {
    final formattedDate = '${_pad(date.day)}/${_pad(date.month)}/${date.year}';
    print('📌 PENGELUARAN');
    print('   Deskripsi : $description');
    print('   Kategori  : $category');
    print('   Jumlah    : \$${amount.toStringAsFixed(2)}');
    print('   Tanggal   : $formattedDate');
  }
}

class BusinessExpense extends Expense {
  final String client;
  final bool isReimbursable;

  BusinessExpense({
    required String description,
    required double amount,
    required String category,
    required this.client,
    this.isReimbursable = true,
    DateTime? date,
  }) : super(
         description: description,
         amount: amount,
         category: category,
         date: date ?? DateTime.now(),
       );

  @override
  void printDetails() {
    print('💼 PENGELUARAN BISNIS');
    super.printDetails();
    print('   Klien     : $client');
    print('   Reimburse : ${isReimbursable ? "Ya ✅" : "Tidak ❌"}');
  }
}

void main() {
  var expense = BusinessExpense(
    description: 'Makan siang klien',
    amount: 85.0,
    category: 'Makan',
    client: 'PT Acme',
    isReimbursable: true,
    // date: DateTime(2025, 10, 11), // optional
  );

  expense.printDetails();
}
