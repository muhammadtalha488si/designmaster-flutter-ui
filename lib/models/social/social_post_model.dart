class SocialPost {
  final String id;
  final String userName;
  final String handle;
  final String avatar;
  final String timeAgo;
  final String caption;
  final String image;
  final int likes;
  final int comments;
  bool isLiked;

  SocialPost({required this.id, required this.userName, required this.handle,
    required this.avatar, required this.timeAgo, required this.caption,
    required this.image, required this.likes, required this.comments,
    this.isLiked = false});
}
