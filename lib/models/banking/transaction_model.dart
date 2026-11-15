enum TransactionType { income, expense, transfer }

class BankTransaction {
  final String id;
  final String title;
  final String subtitle;
  final double amount;
  final DateTime date;
  final TransactionType type;
  final String category;

  const BankTransaction({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.date,
    required this.type,
    required this.category,
  });

  bool get isCredit => type == TransactionType.income;
}
