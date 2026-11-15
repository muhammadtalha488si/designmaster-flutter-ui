import 'package:flutter/foundation.dart';
import '../models/banking/transaction_model.dart';

class BankingProvider extends ChangeNotifier {
  BankingProvider._();
  static final BankingProvider instance = BankingProvider._();

  double _balance = 245000.00;
  double _walletBalance = 18500.00;
  final List<BankTransaction> _transactions = [
    BankTransaction(id: 'TXN-1005', title: 'Monthly Salary', subtitle: 'Company Payroll', amount: 85000, date: DateTime.now().subtract(const Duration(hours: 3)), type: TransactionType.income, category: 'Income'),
    BankTransaction(id: 'TXN-1004', title: 'Grocery Store', subtitle: 'Shopping', amount: 4250, date: DateTime.now().subtract(const Duration(days: 1)), type: TransactionType.expense, category: 'Shopping'),
    BankTransaction(id: 'TXN-1003', title: 'Electricity Bill', subtitle: 'Utility payment', amount: 6800, date: DateTime.now().subtract(const Duration(days: 2)), type: TransactionType.expense, category: 'Bills'),
    BankTransaction(id: 'TXN-1002', title: 'Received from Ali', subtitle: 'Demo transfer', amount: 12000, date: DateTime.now().subtract(const Duration(days: 3)), type: TransactionType.income, category: 'Transfer'),
    BankTransaction(id: 'TXN-1001', title: 'Food Delivery', subtitle: 'Restaurant', amount: 1850, date: DateTime.now().subtract(const Duration(days: 4)), type: TransactionType.expense, category: 'Food'),
  ];

  double get balance => _balance;
  double get walletBalance => _walletBalance;
  List<BankTransaction> get transactions => List.unmodifiable(_transactions);
  double get totalIncome => _transactions.where((t) => t.isCredit).fold(0, (s, t) => s + t.amount);
  double get totalExpense => _transactions.where((t) => !t.isCredit).fold(0, (s, t) => s + t.amount);

  bool transfer({required String recipient, required String account, required double amount}) {
    if (recipient.trim().isEmpty || account.trim().isEmpty || amount <= 0 || amount > _balance) return false;
    _balance -= amount;
    _transactions.insert(0, BankTransaction(
      id: 'TXN-${DateTime.now().millisecondsSinceEpoch}',
      title: 'Transfer to $recipient',
      subtitle: 'Account ending ${account.length > 4 ? account.substring(account.length - 4) : account}',
      amount: amount,
      date: DateTime.now(),
      type: TransactionType.expense,
      category: 'Transfer',
    ));
    notifyListeners();
    return true;
  }

  void addDemoFunds(double amount) {
    if (amount <= 0) return;
    _walletBalance += amount;
    _transactions.insert(0, BankTransaction(
      id: 'TXN-${DateTime.now().millisecondsSinceEpoch}',
      title: 'Wallet top-up',
      subtitle: 'Demo wallet activity',
      amount: amount,
      date: DateTime.now(),
      type: TransactionType.income,
      category: 'Wallet',
    ));
    notifyListeners();
  }
}
