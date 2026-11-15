import 'package:flutter/material.dart';
import '../../providers/banking_provider.dart';
import '../../themes/app_colors.dart';
import '../../widgets/banking/banking_components.dart';
import 'banking_detail_screens.dart';

class BankingHomeScreen extends StatefulWidget {
  const BankingHomeScreen({super.key});
  @override
  State<BankingHomeScreen> createState() => _BankingHomeScreenState();
}

class _BankingHomeScreenState extends State<BankingHomeScreen> {
  int _index = 0;
  final bank = BankingProvider.instance;

  void _open(Widget page) => Navigator.push(context, MaterialPageRoute(builder: (_) => page));

  @override
  Widget build(BuildContext context) {
    final pages = [
      _dashboard(),
      const AccountOverviewScreen(),
      const FinancialActivityScreen(),
      const BankCardsScreen(),
      const BankingSettingsScreen(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('DesignMaster Bank', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [IconButton(tooltip: 'Notifications', onPressed: () => _open(const BankingNotificationsScreen()), icon: const Icon(Icons.notifications_none)), const SizedBox(width: 5)],
      ),
      body: IndexedStack(index: _index, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (value) => setState(() => _index = value),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.account_balance_outlined), selectedIcon: Icon(Icons.account_balance), label: 'Accounts'),
          NavigationDestination(icon: Icon(Icons.receipt_long_outlined), selectedIcon: Icon(Icons.receipt_long), label: 'Activity'),
          NavigationDestination(icon: Icon(Icons.credit_card_outlined), selectedIcon: Icon(Icons.credit_card), label: 'Cards'),
          NavigationDestination(icon: Icon(Icons.settings_outlined), selectedIcon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }

  Widget _dashboard() => AnimatedBuilder(
    animation: bank,
    builder: (context, _) => SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Good day, Demo Customer 👋', style: TextStyle(fontSize: 15, color: AppColors.textSecondary)),
        const SizedBox(height: 5),
        const Text('Your finances at a glance', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
        const SizedBox(height: 14),
        ClipRRect(borderRadius: BorderRadius.circular(18), child: Image.asset('assets/images/banking/banking_dashboard.png', height: 145, width: double.infinity, fit: BoxFit.cover)),
        const SizedBox(height: 18),
        BankingBalanceCard(balance: bank.balance, onTransfer: () => _open(const MoneyTransferScreen()), onWallet: () => _open(const DigitalWalletScreen())),
        const SizedBox(height: 24),
        const BankingSectionTitle('Quick services'),
        const SizedBox(height: 12),
        Row(children: [
          _quick(Icons.swap_horiz, 'Transfer', () => _open(const MoneyTransferScreen())),
          _quick(Icons.account_balance_wallet_outlined, 'Wallet', () => _open(const DigitalWalletScreen())),
          _quick(Icons.history, 'History', () => _open(const TransactionHistoryScreen())),
          _quick(Icons.credit_card, 'Cards', () => setState(() => _index = 3)),
        ]),
        const SizedBox(height: 24),
        BankingSectionTitle('Recent transactions', action: 'See all', onAction: () => _open(const TransactionHistoryScreen())),
        const SizedBox(height: 5),
        ...bank.transactions.take(4).map((t) => TransactionTile(transaction: t)),
        const SizedBox(height: 18),
        const BankingSectionTitle('Monthly overview'),
        const SizedBox(height: 12),
        _monthlySummary(bank.totalIncome, bank.totalExpense),
      ]),
    ),
  );

  Widget _quick(IconData icon, String label, VoidCallback onTap) => Expanded(
    child: InkWell(onTap: onTap, borderRadius: BorderRadius.circular(15), child: Column(children: [
      Container(width: 54, height: 54, decoration: BoxDecoration(color: AppColors.primary.withOpacity(.09), borderRadius: BorderRadius.circular(17)), child: Icon(icon, color: AppColors.primary)),
      const SizedBox(height: 7), Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
    ])),
  );

  Widget _monthlySummary(double income, double expense) => Container(
    padding: const EdgeInsets.all(17), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: AppColors.border)),
    child: Column(children: [
      _summaryLine('Income recorded', income, AppColors.green),
      const SizedBox(height: 13),
      _summaryLine('Expenses recorded', expense, Colors.deepOrange),
      const SizedBox(height: 14),
      ClipRRect(borderRadius: BorderRadius.circular(8), child: LinearProgressIndicator(value: income + expense == 0 ? 0 : income / (income + expense), minHeight: 9, backgroundColor: Colors.deepOrange.withOpacity(.15), color: AppColors.green)),
      const SizedBox(height: 8),
      const Text('Based on the sample transactions in this demo', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
    ]),
  );

  Widget _summaryLine(String label, double amount, Color color) => Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(label, style: const TextStyle(color: AppColors.textSecondary)), Text(money(amount), style: TextStyle(color: color, fontWeight: FontWeight.bold))]);
}
