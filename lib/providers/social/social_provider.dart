import '../../models/social/social_post_model.dart';

class SocialProvider {
  SocialProvider._();
  static final SocialProvider instance = SocialProvider._();

  final List<SocialPost> posts = [
    SocialPost(id: 'p1', userName: 'Ayesha Khan', handle: '@ayesha.creates', avatar: 'AK', timeAgo: '12 min ago', caption: 'A little reminder to enjoy the small moments and keep creating ✨', image: 'assets/images/social_media.jpg', likes: 248, comments: 32),
    SocialPost(id: 'p2', userName: 'Ali Raza', handle: '@ali.explores', avatar: 'AR', timeAgo: '1 hour ago', caption: 'Weekend views are always worth sharing. Where should I travel next? 🌄', image: 'assets/images/booking/booking_hero.jpg', likes: 186, comments: 19),
    SocialPost(id: 'p3', userName: 'Design Hub', handle: '@designhub', avatar: 'DH', timeAgo: '3 hours ago', caption: 'Fresh ideas, thoughtful design, and a community that inspires. 💜', image: 'assets/images/social_media/social_feed_hero.png', likes: 512, comments: 64),
  ];

  final List<String> stories = ['Your Story', 'Ayesha', 'Ali Raza', 'Zainab', 'Hamza', 'Design Hub'];
  final List<String> conversations = ['Ayesha Khan', 'Ali Raza', 'Zainab Noor', 'Design Hub'];
  void toggleLike(SocialPost post) { post.isLiked = !post.isLiked; }
}
