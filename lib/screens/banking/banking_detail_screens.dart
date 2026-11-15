import 'package:flutter/material.dart';
import '../../models/banking/transaction_model.dart';
import '../../providers/banking_provider.dart';
import '../../themes/app_colors.dart';
import '../../widgets/banking/banking_components.dart';

class AccountOverviewScreen extends StatelessWidget {
  const AccountOverviewScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final bank = BankingProvider.instance;
    return AnimatedBuilder(animation: bank, builder: (_, __) => ListView(padding: const EdgeInsets.all(18), children: [
      const Text('Account overview', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
      const SizedBox(height: 16),
      BankingBalanceCard(balance: bank.balance, onTransfer: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MoneyTransferScreen())), onWallet: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DigitalWalletScreen()))),
      const SizedBox(height: 18),
      _info('Account name', 'Demo Customer'),
      _info('Account type', 'Personal Current Account'),
      _info('Account number', '**** **** 2034'),
      _info('Branch', 'DesignMaster Digital Branch'),
      _info('Account status', 'Active'),
      const SizedBox(height: 12),
      const Text('This is fictional demonstration information, not a real bank account.', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
    ]));
  }
  Widget _info(String label, String value) => Container(margin: const EdgeInsets.only(bottom: 10), padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.border)), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(label, style: const TextStyle(color: AppColors.textSecondary)), Flexible(child: Text(value, textAlign: TextAlign.end, style: const TextStyle(fontWeight: FontWeight.w600)))]));
}

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});
  @override
  State<TransactionHistoryScreen> createState() => _TransactionHistoryScreenState();
}
class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  String filter = 'All';
  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: BankingProvider.instance,
    builder: (_, __) {
      final all = BankingProvider.instance.transactions;
      final items = all.where((t) => filter == 'All' || (filter == 'Income' ? t.isCredit : !t.isCredit)).toList();
      return Scaffold(appBar: AppBar(title: const Text('Transaction history')), body: ListView(padding: const EdgeInsets.all(18), children: [
        Wrap(spacing: 8, children: ['All', 'Income', 'Expenses'].map((v) => ChoiceChip(label: Text(v), selected: filter == v, onSelected: (_) => setState(() => filter = v))).toList()),
        const SizedBox(height: 12),
        if (items.isEmpty) const Padding(padding: EdgeInsets.all(30), child: Center(child: Text('No transactions found.'))),
        ...items.map((t) => TransactionTile(transaction: t)),
      ]));
    },
  );
}

class DigitalWalletScreen extends StatelessWidget {
  const DigitalWalletScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final bank = BankingProvider.instance;
    return Scaffold(appBar: AppBar(title: const Text('Digital wallet')), body: AnimatedBuilder(animation: bank, builder: (_, __) => ListView(padding: const EdgeInsets.all(18), children: [
      Container(padding: const EdgeInsets.all(22), decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF087F8C), Color(0xFF25B5A4)]), borderRadius: BorderRadius.circular(22)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Icon(Icons.account_balance_wallet, color: Colors.white, size: 30), const SizedBox(height: 18),
        const Text('Wallet balance', style: TextStyle(color: Colors.white70)), const SizedBox(height: 6),
        Text(money(bank.walletBalance), style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
      ])),
      const SizedBox(height: 14),
      ClipRRect(borderRadius: BorderRadius.circular(16), child: Image.asset('assets/images/banking/wallet_illustration.png', height: 120, width: double.infinity, fit: BoxFit.cover)),
      const SizedBox(height: 20),
      FilledButton.icon(onPressed: () => _showTopUp(context), icon: const Icon(Icons.add), label: const Text('Add demo funds')),
      const SizedBox(height: 20),
      const BankingSectionTitle('Wallet information'),
      const ListTile(leading: Icon(Icons.verified_user_outlined), title: Text('Demo wallet'), subtitle: Text('No real payment account is connected')),
      const ListTile(leading: Icon(Icons.lock_outline), title: Text('Protected demo environment'), subtitle: Text('Do not enter real banking or card details')),
    ])));
  }
  void _showTopUp(BuildContext context) {
    final controller = TextEditingController(text: '1000');
    showDialog(context: context, builder: (dialogContext) => AlertDialog(
      title: const Text('Add demo funds'),
      content: TextField(controller: controller, keyboardType: const TextInputType.numberWithOptions(decimal: true), decoration: const InputDecoration(labelText: 'Amount (Rs)', border: OutlineInputBorder())),
      actions: [
        TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Cancel')),
        FilledButton(onPressed: () {
          final amount = double.tryParse(controller.text.trim());
          if (amount == null || amount <= 0) return;
          BankingProvider.instance.addDemoFunds(amount);
          Navigator.pop(dialogContext);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Demo wallet updated.')));
        }, child: const Text('Add funds')),
      ],
    ));
  }
}

class MoneyTransferScreen extends StatefulWidget {
  const MoneyTransferScreen({super.key});
  @override
  State<MoneyTransferScreen> createState() => _MoneyTransferScreenState();
}
class _MoneyTransferScreenState extends State<MoneyTransferScreen> {
  final name = TextEditingController();
  final account = TextEditingController();
  final amount = TextEditingController();
  bool _confirmed = false;
  @override
  void dispose() { name.dispose(); account.dispose(); amount.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Money transfer')),
    body: ListView(padding: const EdgeInsets.all(18), children: [
      Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: AppColors.primary.withOpacity(.08), borderRadius: BorderRadius.circular(14)), child: const Row(children: [Icon(Icons.info_outline, color: AppColors.primary), SizedBox(width: 10), Expanded(child: Text('Demo only: this form does not send real money or contact a bank.', style: TextStyle(fontSize: 12)))])),
      const SizedBox(height: 14),
      ClipRRect(borderRadius: BorderRadius.circular(16), child: Image.asset('assets/images/banking/transfer_illustration.png', height: 135, width: double.infinity, fit: BoxFit.cover)),
      const SizedBox(height: 20),
      _field('Recipient name', name, Icons.person_outline),
      _field('Demo account reference', account, Icons.account_balance_outlined),
      _field('Amount (Rs)', amount, Icons.payments_outlined, numeric: true),
      const SizedBox(height: 8),
      CheckboxListTile(contentPadding: EdgeInsets.zero, value: _confirmed, onChanged: (v) => setState(() => _confirmed = v ?? false), title: const Text('I understand this is a simulated transfer', style: TextStyle(fontSize: 12))),
      const SizedBox(height: 12),
      SizedBox(height: 52, child: FilledButton(onPressed: _submit, child: const Text('Review and transfer'))),
    ]),
  );
  Widget _field(String label, TextEditingController controller, IconData icon, {bool numeric = false}) => Padding(padding: const EdgeInsets.only(bottom: 15), child: TextField(controller: controller, keyboardType: numeric ? const TextInputType.numberWithOptions(decimal: true) : TextInputType.text, decoration: InputDecoration(labelText: label, prefixIcon: Icon(icon), border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)))));
  void _submit() {
    final value = double.tryParse(amount.text.trim());
    if (!_confirmed || value == null || value <= 0 || name.text.trim().isEmpty || account.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Complete all fields and confirm the demo notice.')));
      return;
    }
    final success = BankingProvider.instance.transfer(recipient: name.text.trim(), account: account.text.trim(), amount: value);
    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Transfer amount exceeds the demo balance.')));
      return;
    }
    showDialog(context: context, barrierDismissible: false, builder: (d) => AlertDialog(
      icon: const Icon(Icons.check_circle, color: Colors.green, size: 45),
      title: const Text('Demo transfer complete'),
      content: Text('${money(value)} has been simulated for ${name.text.trim()}. No real money was moved.'),
      actions: [FilledButton(onPressed: () { Navigator.pop(d); Navigator.pop(context); }, child: const Text('Done'))],
    ));
  }
}

class BankCardsScreen extends StatelessWidget {
  const BankCardsScreen({super.key});
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(18), children: [
    ClipRRect(borderRadius: BorderRadius.circular(20), child: Image.asset('assets/images/banking/bank_card_blue.png', height: 175, width: double.infinity, fit: BoxFit.cover)),
    const SizedBox(height: 16),
    const BankingCardPreview(),
    const SizedBox(height: 18),
    const Text('Virtual demo card', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    const SizedBox(height: 8),
    const Text('Only masked sample card information is shown. This is not a usable payment card.', style: TextStyle(color: AppColors.textSecondary)),
    const SizedBox(height: 15),
    const ListTile(leading: Icon(Icons.lock_outline), title: Text('Card controls'), subtitle: Text('Freeze/unfreeze controls are visual demo options')),
    const ListTile(leading: Icon(Icons.contactless), title: Text('Contactless payments'), subtitle: Text('Sample interface only')),
  ]);
}

class FinancialActivityScreen extends StatelessWidget {
  const FinancialActivityScreen({super.key});
  @override
  Widget build(BuildContext context) => AnimatedBuilder(animation: BankingProvider.instance, builder: (_, __) {
    final bank = BankingProvider.instance;
    final total = bank.totalIncome + bank.totalExpense;
    final incomeRatio = total == 0 ? 0.0 : bank.totalIncome / total;
    return ListView(padding: const EdgeInsets.all(18), children: [
      const Text('Your activity summary', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
      const SizedBox(height: 12),
      ClipRRect(borderRadius: BorderRadius.circular(16), child: Image.asset('assets/images/banking/financial_analytics.png', height: 130, width: double.infinity, fit: BoxFit.cover)),
      const SizedBox(height: 16),
      _metric('Recorded income', bank.totalIncome, AppColors.green, Icons.trending_up),
      _metric('Recorded expenses', bank.totalExpense, Colors.deepOrange, Icons.trending_down),
      const SizedBox(height: 18),
      const Text('Income / expense comparison', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 12),
      ClipRRect(borderRadius: BorderRadius.circular(10), child: Row(children: [
        Expanded(flex: (incomeRatio * 1000).round().clamp(1, 1000).toInt(), child: Container(height: 15, color: AppColors.green)),
        Expanded(flex: ((1 - incomeRatio) * 1000).round().clamp(1, 1000).toInt(), child: Container(height: 15, color: Colors.deepOrange)),
      ])),
      const SizedBox(height: 8),
      const Text('Green: income     Orange: expenses', style: TextStyle(color: AppColors.textSecondary, fontSize: 11)),
      const SizedBox(height: 22),
      const BankingSectionTitle('Latest activity'),
      ...bank.transactions.map((t) => TransactionTile(transaction: t)),
    ]);
  });
  Widget _metric(String label, double value, Color color, IconData icon) => Container(margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(17), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)), child: Row(children: [CircleAvatar(backgroundColor: color.withOpacity(.12), child: Icon(icon, color: color)), const SizedBox(width: 12), Expanded(child: Text(label, style: const TextStyle(color: AppColors.textSecondary))), Text(money(value), style: TextStyle(color: color, fontWeight: FontWeight.bold))]));
}

class BankingSettingsScreen extends StatefulWidget {
  const BankingSettingsScreen({super.key});
  @override
  State<BankingSettingsScreen> createState() => _BankingSettingsScreenState();
}
class _BankingSettingsScreenState extends State<BankingSettingsScreen> {
  bool notifications = true;
  bool biometric = false;
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(18), children: [
    const Text('Account settings', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
    const SizedBox(height: 15),
    const CircleAvatar(radius: 34, child: Icon(Icons.person, size: 35)),
    const SizedBox(height: 8),
    const Center(child: Text('Demo Customer', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17))),
    const Center(child: Text('demo@designmaster.app', style: TextStyle(color: AppColors.textSecondary))),
    const SizedBox(height: 18),
    SwitchListTile(value: notifications, onChanged: (v) => setState(() => notifications = v), secondary: const Icon(Icons.notifications_outlined), title: const Text('Notifications')),
    SwitchListTile(value: biometric, onChanged: (v) => setState(() => biometric = v), secondary: const Icon(Icons.fingerprint), title: const Text('Biometric sign-in (demo)')),
    const ListTile(leading: Icon(Icons.language), title: Text('Language'), subtitle: Text('English')),
    const ListTile(leading: Icon(Icons.help_outline), title: Text('Help and support')),
    const ListTile(leading: Icon(Icons.privacy_tip_outlined), title: Text('Privacy information')),
    const SizedBox(height: 12),
    const Text('Demo settings only. No login, authentication or bank connection is configured.', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
  ]);
}

class BankingNotificationsScreen extends StatelessWidget {
  const BankingNotificationsScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Notifications')), body: const Center(child: Padding(padding: EdgeInsets.all(24), child: Column(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.notifications_none, size: 55, color: AppColors.textSecondary), SizedBox(height: 12), Text('You are all caught up', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), SizedBox(height: 5), Text('Demo banking alerts will appear here.', style: TextStyle(color: AppColors.textSecondary))]))));
}
