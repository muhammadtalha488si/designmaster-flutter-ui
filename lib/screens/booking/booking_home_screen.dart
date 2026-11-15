import 'package:flutter/material.dart';
import '../../models/booking/booking_model.dart';
import '../../providers/booking/booking_provider.dart';

class BookingHomeScreen extends StatefulWidget {
  const BookingHomeScreen({super.key});
  @override State<BookingHomeScreen> createState() => _BookingHomeScreenState();
}

class _BookingHomeScreenState extends State<BookingHomeScreen> {
  final provider = BookingProvider.instance;
  final search = TextEditingController();
  String category = 'All';
  int tab = 0;
  final categories = const ['All', 'Hotels', 'Flights', 'Tours', 'Events'];
  @override void dispose() { search.dispose(); super.dispose(); }
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Discover & Book', style: TextStyle(fontWeight: FontWeight.bold)), actions: [IconButton(onPressed: () => _message('Notifications opened'), icon: const Icon(Icons.notifications_none))]),
    body: IndexedStack(index: tab, children: [_home(), _myBookings(), _saved()]),
    bottomNavigationBar: NavigationBar(selectedIndex: tab, onDestinationSelected: (v) => setState(() => tab = v), destinations: const [NavigationDestination(icon: Icon(Icons.explore_outlined), selectedIcon: Icon(Icons.explore), label: 'Explore'), NavigationDestination(icon: Icon(Icons.confirmation_number_outlined), selectedIcon: Icon(Icons.confirmation_number), label: 'Bookings'), NavigationDestination(icon: Icon(Icons.favorite_border), selectedIcon: Icon(Icons.favorite), label: 'Saved')]),
  );

  Widget _home() {
    final query = search.text.toLowerCase();
    final items = provider.destinations.where((e) => (category == 'All' || e.category == category) && ('${e.title} ${e.location}'.toLowerCase().contains(query))).toList();
    return ListView(padding: const EdgeInsets.only(bottom: 20), children: [
      Container(margin: const EdgeInsets.all(16), padding: const EdgeInsets.all(20), decoration: BoxDecoration(borderRadius: BorderRadius.circular(22), gradient: const LinearGradient(colors: [Color(0xFF1C64D1), Color(0xFF6847D9)])), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('Make your next trip memorable', style: TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.bold)), const SizedBox(height: 6), const Text('Find stays, flights and experiences', style: TextStyle(color: Colors.white70)), const SizedBox(height: 16), TextField(controller: search, onChanged: (_) => setState(() {}), style: const TextStyle(color: Colors.black87), decoration: InputDecoration(hintText: 'Where do you want to go?', prefixIcon: const Icon(Icons.search), filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none)))])),
      SizedBox(height: 52, child: ListView(scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 16), children: [for (final c in categories) Padding(padding: const EdgeInsets.only(right: 8), child: ChoiceChip(label: Text(c), selected: category == c, onSelected: (_) => setState(() => category = c)))])),
      Padding(padding: const EdgeInsets.fromLTRB(16, 18, 16, 10), child: Row(children: [const Expanded(child: Text('Popular for you', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))), Text('${items.length} places', style: const TextStyle(color: Colors.grey))])),
      if (items.isEmpty) const Padding(padding: EdgeInsets.all(30), child: Center(child: Text('No matching options. Try another search.'))),
      for (final item in items) _destinationCard(item),
    ]);
  }

  Widget _destinationCard(BookingItem item) => Card(margin: const EdgeInsets.fromLTRB(16, 6, 16, 10), clipBehavior: Clip.antiAlias, child: InkWell(onTap: () => _details(item), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Stack(children: [AspectRatio(aspectRatio: 2.1, child: Image.asset(item.image, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(color: Colors.blueGrey.shade100, child: const Icon(Icons.landscape, size: 45)))), Positioned(top: 10, right: 10, child: CircleAvatar(backgroundColor: Colors.white, child: IconButton(onPressed: () => _message('${item.title} saved'), icon: const Icon(Icons.favorite_border, color: Colors.red))))]),
    Padding(padding: const EdgeInsets.all(14), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [Expanded(child: Text(item.title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold))), const Icon(Icons.star, color: Colors.amber, size: 17), Text(item.rating.toString())]), const SizedBox(height: 5), Row(children: [const Icon(Icons.location_on_outlined, size: 16, color: Colors.grey), Text(item.location, style: const TextStyle(color: Colors.grey))]), const SizedBox(height: 10), Row(children: [Text(item.price, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF635BFF))), const Spacer(), TextButton(onPressed: () => _details(item), child: const Text('View details'))])]))
  ])));

  Widget _myBookings() => provider.myBookings.isEmpty ? const Center(child: Column(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.luggage_outlined, size: 60, color: Colors.grey), SizedBox(height: 12), Text('No bookings yet', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), Text('Your confirmed demo bookings will appear here.')])) : ListView(padding: const EdgeInsets.all(16), children: [for (final item in provider.myBookings) Card(child: ListTile(leading: const CircleAvatar(child: Icon(Icons.confirmation_number_outlined)), title: Text(item.title), subtitle: Text('${item.location} · ${item.price}'), trailing: const Chip(label: Text('Demo'))))]);
  Widget _saved() => const Center(child: Text('Your saved places will appear here.'));

  void _details(BookingItem item) => Navigator.push(context, MaterialPageRoute(builder: (_) => BookingDetailsScreen(item: item, onBook: () { provider.addBooking(item); Navigator.pop(context); setState(() => tab = 1); _message('Demo booking added to My Bookings'); })));
  void _message(String s) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(s)));
}

class BookingDetailsScreen extends StatelessWidget {
  final BookingItem item;
  final VoidCallback onBook;
  const BookingDetailsScreen({super.key, required this.item, required this.onBook});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Booking details')), body: ListView(children: [AspectRatio(aspectRatio: 1.7, child: Image.asset(item.image, fit: BoxFit.cover)), Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(item.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)), const SizedBox(height: 8), Text(item.location, style: const TextStyle(color: Colors.grey)), const SizedBox(height: 12), Row(children: [const Icon(Icons.star, color: Colors.amber), Text(' ${item.rating} rating  ·  ${item.category}')]), const SizedBox(height: 20), const Text('About this experience', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), const SizedBox(height: 8), Text(item.description), const SizedBox(height: 20), _InfoRow(icon: Icons.calendar_month_outlined, label: 'Availability', value: item.date), _InfoRow(icon: Icons.verified_user_outlined, label: 'Booking type', value: 'Instant confirmation (demo)'), const SizedBox(height: 20), Row(children: [Expanded(child: Text(item.price, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF635BFF)))), FilledButton.icon(onPressed: onBook, icon: const Icon(Icons.check), label: const Text('Book now'))])]))]));
}
class _InfoRow extends StatelessWidget { final IconData icon; final String label, value; const _InfoRow({required this.icon, required this.label, required this.value}); @override Widget build(BuildContext context) => ListTile(contentPadding: EdgeInsets.zero, leading: Icon(icon), title: Text(label), subtitle: Text(value)); }
