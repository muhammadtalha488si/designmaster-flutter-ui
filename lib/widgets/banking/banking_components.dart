import 'package:flutter/material.dart';
import '../../models/banking/transaction_model.dart';
import '../../themes/app_colors.dart';

String money(double value) => 'Rs ${value.toStringAsFixed(2)}';

class BankingBalanceCard extends StatelessWidget {
  final double balance;
  final VoidCallback onTransfer;
  final VoidCallback onWallet;
  const BankingBalanceCard({super.key, required this.balance, required this.onTransfer, required this.onWallet});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF172B67), Color(0xFF4265C5)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: const Color(0xFF263F91).withOpacity(.2), blurRadius: 18, offset: const Offset(0, 9))],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Row(children: [Icon(Icons.account_balance, color: Colors.white70), SizedBox(width: 8), Text('DESIGNMASTER BANK', style: TextStyle(color: Colors.white70, letterSpacing: 1.3, fontWeight: FontWeight.w700, fontSize: 11))]),
        const SizedBox(height: 22),
        const Text('Total available balance', style: TextStyle(color: Colors.white70, fontSize: 13)),
        const SizedBox(height: 5),
        Text(money(balance), style: const TextStyle(color: Colors.white, fontSize: 29, fontWeight: FontWeight.bold)),
        const SizedBox(height: 22),
        Row(children: [
          Expanded(child: _cardAction(Icons.north_east, 'Transfer', onTransfer)),
          const SizedBox(width: 12),
          Expanded(child: _cardAction(Icons.account_balance_wallet_outlined, 'Wallet', onWallet)),
        ]),
      ]),
    );
  }

  Widget _cardAction(IconData icon, String label, VoidCallback action) => InkWell(
    onTap: action, borderRadius: BorderRadius.circular(14),
    child: Container(padding: const EdgeInsets.symmetric(vertical: 12), decoration: BoxDecoration(color: Colors.white.withOpacity(.14), borderRadius: BorderRadius.circular(14)),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, color: Colors.white, size: 17), const SizedBox(width: 7), Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600))])),
  );
}

class BankingSectionTitle extends StatelessWidget {
  final String title;
  final String? action;
  final VoidCallback? onAction;
  const BankingSectionTitle(this.title, {super.key, this.action, this.onAction});
  @override
  Widget build(BuildContext context) => Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
    Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
    if (action != null) TextButton(onPressed: onAction, child: Text(action!)),
  ]);
}

class TransactionTile extends StatelessWidget {
  final BankTransaction transaction;
  const TransactionTile({super.key, required this.transaction});
  @override
  Widget build(BuildContext context) {
    final credit = transaction.isCredit;
    final icon = transaction.category == 'Bills' ? Icons.receipt_long : transaction.category == 'Food' ? Icons.restaurant : transaction.category == 'Shopping' ? Icons.shopping_bag_outlined : transaction.category == 'Transfer' ? Icons.swap_horiz : Icons.account_balance_wallet_outlined;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Row(children: [
        Container(width: 45, height: 45, decoration: BoxDecoration(color: (credit ? AppColors.green : AppColors.primary).withOpacity(.10), borderRadius: BorderRadius.circular(14)), child: Icon(icon, color: credit ? AppColors.green : AppColors.primary)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(transaction.title, style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
          const SizedBox(height: 4),
          Text(transaction.subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
        ])),
        Text('${credit ? '+' : '-'}${money(transaction.amount)}', style: TextStyle(fontWeight: FontWeight.bold, color: credit ? AppColors.green : AppColors.textPrimary, fontSize: 12)),
      ]),
    );
  }
}

class BankingCardPreview extends StatelessWidget {
  const BankingCardPreview({super.key});
  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity, padding: const EdgeInsets.all(22),
    decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF20263D), Color(0xFF515B79)]), borderRadius: BorderRadius.circular(22)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('DESIGNMASTER', style: TextStyle(color: Colors.white, letterSpacing: 1.4, fontWeight: FontWeight.bold)), Icon(Icons.contactless, color: Colors.white.withOpacity(.8))]),
      const SizedBox(height: 28),
      const Text('••••  ••••  ••••  4821', style: TextStyle(color: Colors.white, fontSize: 19, letterSpacing: 1.5)),
      const SizedBox(height: 20),
      const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('CARD HOLDER', style: TextStyle(color: Colors.white60, fontSize: 9)), SizedBox(height: 4), Text('DEMO CUSTOMER', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600))]),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('EXPIRES', style: TextStyle(color: Colors.white60, fontSize: 9)), SizedBox(height: 4), Text('08/29', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600))]),
        Text('VISA', style: TextStyle(color: Colors.white, fontSize: 22, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
      ]),
    ]),
  );
}
