// contoh lengkap: PaymentMethod, Expense, Cryptocurrency

abstract class PaymentMethod {
  String get name;
  String get icon;

  /// Kembalikan true kalau metode pembayaran valid / siap dipakai
  bool validate();

  /// Proses pembayaran sejumlah [amount]
  void processPayment(double amount);
}

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

  /// Bayar expense dengan metode pembayaran yang diberikan
  void payWith(PaymentMethod method) {
    print('--- Membayar: $description ---');
    print('Metode: ${method.name} ${method.icon}');
    if (!method.validate()) {
      print('❌ Metode pembayaran tidak valid. Pembayaran dibatalkan.');
      return;
    }

    // panggil proses metode pembayaran
    method.processPayment(amount);

    // tampilkan nota / receipt
    showReceipt(method);
  }

  void showReceipt(PaymentMethod method) {
    print('✅ Pembayaran selesai.');
    print('Rincian:');
    print('  Deskripsi : $description');
    print('  Kategori  : $category');
    print('  Jumlah    : \$${amount.toStringAsFixed(2)}');
    print('  Metode    : ${method.name} ${method.icon}');
    print('  Tanggal   : ${date.toIso8601String()}');
    print('------------------------------');
  }
}

class Cryptocurrency extends PaymentMethod {
  final String walletAddress;
  final String coinType;

  Cryptocurrency({
    required this.walletAddress,
    required this.coinType,
  });

  @override
  String get name => 'Dompet $coinType';

  @override
  String get icon => '₿';

  @override
  bool validate() {
    // contoh validasi sederhana: tidak kosong dan minimal panjang 20
    return walletAddress.isNotEmpty && walletAddress.length > 20;
  }

  @override
  void processPayment(double amount) {
    if (!validate()) {
      print('❌ Alamat wallet tidak valid');
      return;
    }

    print('$icon Memproses pembayaran $coinType sebesar \$${amount.toStringAsFixed(2)}...');
    // tampilkan potongan alamat (aman karena sudah tervalidasi length)
    final start = walletAddress.substring(0, 6);
    final end = walletAddress.substring(walletAddress.length - 4);
    print('Wallet: $start...$end');
    print('⏳ Menunggu konfirmasi blockchain...');
    // simulasi delay singkat (tidak async di contoh ini)
    print('🔔 Konfirmasi diterima.');
    // Note: jangan panggil showReceipt di sini — biarkan pemilik expense yang menampilkannya
  }
}

void main() {
  var btc = Cryptocurrency(
    walletAddress: '1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa',
    coinType: 'Bitcoin',
  );

  // <-- perbaikan: gunakan 'description' (bukan 'descriptio')
  var expense = Expense(
    description: 'Pembelian online',
    amount: 250.0,
    category: 'Belanja',
  );

  expense.payWith(btc);
}
