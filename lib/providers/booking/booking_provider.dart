import '../../models/booking/booking_model.dart';

class BookingProvider {
  BookingProvider._();
  static final BookingProvider instance = BookingProvider._();
  final List<BookingItem> destinations = const [
    BookingItem(id: 'b1', title: 'Pearl Continental', location: 'Lahore, Pakistan', category: 'Hotels', date: 'Flexible dates', image: 'assets/images/booking/booking_hero.jpg', price: 'PKR 18,500', description: 'A comfortable city stay with dining, leisure and modern facilities.', rating: 4.8),
    BookingItem(id: 'b2', title: 'Hunza Valley Escape', location: 'Hunza, Pakistan', category: 'Tours', date: '3 days / 2 nights', image: 'assets/images/booking/booking_hero.jpg', price: 'PKR 32,000', description: 'Explore mountain views, local culture and scenic landscapes.', rating: 4.9),
    BookingItem(id: 'b3', title: 'Islamabad to Karachi', location: 'Pakistan', category: 'Flights', date: 'Daily departures', image: 'assets/images/booking/booking_hero.jpg', price: 'From PKR 24,000', description: 'Compare convenient flight options for your next journey.', rating: 4.6),
    BookingItem(id: 'b4', title: 'Northern Explorer', location: 'Gilgit-Baltistan, Pakistan', category: 'Tours', date: '5 days / 4 nights', image: 'assets/images/booking/booking_hero.jpg', price: 'PKR 45,000', description: 'A guided trip through some of the region’s most memorable scenery.', rating: 4.9),
  ];
  final List<BookingItem> myBookings = [];
  void addBooking(BookingItem item) { myBookings.insert(0, item); }
}
