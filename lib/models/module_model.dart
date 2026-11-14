
class ModuleModel {
  final String id;
  final String title;
  final String subtitle;
  final String imagePath;
  final String description;
  final List<String> features;

  const ModuleModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.description,
    required this.features,
  });
}

const List<ModuleModel> appModules = [
  ModuleModel(
    id: 'ecommerce',
    title: 'E-Commerce',
    subtitle: 'Shopping UI',
    imagePath: 'assets/images/ecommerce.jpg',
    description:
        'Explore modern online shopping application designs.',
    features: [
      'Product listing',
      'Product details',
      'Shopping cart',
      'Wishlist interface',
      'Checkout design',
      'Order tracking',
    ],
  ),
  ModuleModel(
    id: 'banking',
    title: 'Banking',
    subtitle: 'Finance UI',
    imagePath: 'assets/images/banking.jpg',
    description:
        'Explore modern banking and financial application designs.',
    features: [
      'Bank dashboard',
      'Account overview',
      'Transaction history',
      'Cards interface',
      'Transfer money UI',
      'Financial charts',
    ],
  ),
  ModuleModel(
    id: 'social',
    title: 'Social Media',
    subtitle: 'Social UI',
    imagePath: 'assets/images/social_media.jpg',
    description:
        'Explore social networking and communication interfaces.',
    features: [
      'Social feed',
      'User profile',
      'Stories interface',
      'Chat interface',
      'Notifications',
      'Search users',
    ],
  ),
  ModuleModel(
    id: 'booking',
    title: 'Booking',
    subtitle: 'Travel UI',
    imagePath: 'assets/images/booking.jpg',
    description:
        'Explore modern travel and booking application designs.',
    features: [
      'Travel destinations',
      'Search bookings',
      'Date selection',
      'Hotel details',
      'Booking summary',
      'Travel history',
    ],
  ),
];
