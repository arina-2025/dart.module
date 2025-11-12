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
    print('   Jumlah    : Rp ${amount.toStringAsFixed(2)}');
    print('   Tanggal   : $formattedDate');
  }
}

class TravelExpense extends Expense {
  final String destination;
  final int tripDuration;

  TravelExpense({
    required String description,
    required double amount,
    required this.destination,
    required this.tripDuration,
    DateTime? date,
  }) : super(
         description: description,
         amount: amount,
         category: 'Perjalanan',
         date: date ?? DateTime.now(),
       );

  double getDailyCost() {
    // Jika durasi 0 atau negatif, kembalikan total (atau bisa juga 0 tergantung kebutuhan)
    if (tripDuration <= 0) return amount;
    return amount / tripDuration;
  }

  bool isInternational() {
    // daftar negara contoh (bisa diperluas)
    final intlCountries = ['jepang', 'singapura', 'malaysia', 'korea', 'thailand', 'australia', 'china'];
    final lower = destination.toLowerCase();
    return intlCountries.any((c) => lower.contains(c));
  }

  @override
  void printDetails() {
    print('✈️ PENGELUARAN PERJALANAN');
    super.printDetails();
    print('   Destinasi    : $destination');
    print('   Durasi       : $tripDuration hari');
    print('   Biaya harian : Rp ${getDailyCost().toStringAsFixed(2)}');
    print('   Internasional: ${isInternational() ? "Ya 🌍" : "Tidak 🏠"}');
  }
}

void main() {
  var trip = TravelExpense(
    description: 'Liburan Tokyo',
    amount: 25000000.0,
    destination: 'Tokyo, Jepang',
    tripDuration: 7,
  );

  trip.printDetails();

  // Coba kasus edge
  var oneDay = TravelExpense(
    description: 'Trip singkat',
    amount: 500000.0,
    destination: 'Bandung, Indonesia',
    tripDuration: 0, // durasi 0 -> getDailyCost() tidak error
  );
  oneDay.printDetails();
}
