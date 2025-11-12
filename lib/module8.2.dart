
abstract class PaymentMethod {
  String get name;
  String get icon;

  void processPayment(double amount);

  void showReceipt(double amount) {
    print('--- Nota Pembayaran ---');
    print('Metode   : $name $icon');
    print('Jumlah   : \$${amount.toStringAsFixed(2)}');
    print('Waktu    : ${DateTime.now().toIso8601String()}');
    print('Terima kasih!');
  }
}
abstract class Refundable {
  bool canRefund();
  void processRefund(double amount);
}


class CreditCard extends PaymentMethod implements Refundable {
  final String cardNumber;
  final String cardHolder;
  final List<double> transactions = <double>[];

  CreditCard({
    required this.cardNumber,
    required this.cardHolder,
  });

  @override
  String get name => 'Kartu Kredit';

  @override
  String get icon => '💳';

  @override
  void processPayment(double amount) {
    transactions.add(amount);
    print('$icon Mendebet \$${amount.toStringAsFixed(2)}');
    showReceipt(amount);
  }

  @override
  bool canRefund() {
    return transactions.any((t) => t > 0);
  }

  @override
  void processRefund(double amount) {
    if (!canRefund()) {
      print('❌ Tidak ada transaksi untuk direfund');
      return;
    }

    
    if (amount <= 0) {
      print('❌ Jumlah refund harus lebih dari 0');
      return;
    }

    final totalCharged = transactions.where((t) => t > 0).fold(0.0, (a, b) => a + b);
    final totalRefunds = transactions.where((t) => t < 0).fold(0.0, (a, b) => a + b).abs();
    final refundableLeft = totalCharged - totalRefunds;

    if (amount > refundableLeft) {
      print('❌ Jumlah refund melebihi saldo yang dapat direfund (tersisa \$${refundableLeft.toStringAsFixed(2)})');
      return;
    }

    print('🔄 Memproses refund \$${amount.toStringAsFixed(2)}');
    print('   Refund akan muncul dalam 3-5 hari kerja');
    transactions.add(-amount); 
  }
}


class Cash extends PaymentMethod {
  @override
  String get name => 'Tunai';

  @override
  String get icon => '💵';

  @override
  void processPayment(double amount) {
    print('$icon Pembayaran tunai: \$${amount.toStringAsFixed(2)}');
    showReceipt(amount);
  }
}

void main() {
  final card = CreditCard(
    cardNumber: '4532123456789012',
    cardHolder: 'John Doe',
  );
  final cash = Cash();

  card.processPayment(100.0);
  card.processRefund(50.0);

  cash.processPayment(50.0);

  if (cash is Refundable) {
  (cash as Refundable).processRefund(25.0);  
} else {
  print('❌ Pembayaran tunai tidak dapat direfund');
}

}
