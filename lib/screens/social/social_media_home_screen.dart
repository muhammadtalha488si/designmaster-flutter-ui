
import 'package:flutter/material.dart';
import '../../models/social/social_post_model.dart';
import '../../providers/social/social_provider.dart';

class SocialMediaHomeScreen extends StatefulWidget {
  const SocialMediaHomeScreen({super.key});

  @override
  State<SocialMediaHomeScreen> createState() =>
      _SocialMediaHomeScreenState();
}

class _SocialMediaHomeScreenState
    extends State<SocialMediaHomeScreen> {
  int tab = 0;
  final provider = SocialProvider.instance;

  @override
  Widget build(BuildContext context) {
    final pages = [
      _feed(),
      _discover(),
      _messages(),
      _profile(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Social Hub',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () =>
                _notice('Notifications are all caught up!'),
            icon: const Icon(Icons.notifications_none_rounded),
          ),
          IconButton(
            onPressed: () => setState(() => tab = 2),
            icon: const Icon(Icons.send_outlined),
          ),
        ],
      ),
      body: IndexedStack(
        index: tab,
        children: pages,
      ),
      floatingActionButton: tab == 0
          ? FloatingActionButton(
              onPressed: _createPost,
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        onDestinationSelected: (v) =>
            setState(() => tab = v),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline),
            selectedIcon: Icon(Icons.chat),
            label: 'Messages',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _feed() => ListView(
        padding: const EdgeInsets.only(bottom: 90),
        children: [
          SizedBox(
            height: 112,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                for (int i = 0; i < provider.stories.length; i++)
                  _story(provider.stories[i], i == 0),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Text(
              'Your community',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          for (final post in provider.posts) _postCard(post),
        ],
      );

  Widget _story(String name, bool own) =>
      GestureDetector(
        onTap: () => _notice('$name story opened'),
        child: Container(
          width: 76,
          margin: const EdgeInsets.only(right: 10),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: own
                        ? Colors.grey.shade300
                        : const Color(0xFF7955E8),
                    width: 2,
                  ),
                ),
                child: CircleAvatar(
                  radius: 27,
                  backgroundColor: const Color(0xFFECE7FF),
                  child: own
                      ? const Icon(
                          Icons.add,
                          color: Color(0xFF635BFF),
                        )
                      : Text(
                          name.substring(0, 1),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF635BFF),
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 11),
              ),
            ],
          ),
        ),
      );

  Widget _postCard(SocialPost post) => Card(
        margin: const EdgeInsets.fromLTRB(14, 8, 14, 10),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: const Color(0xFFECE7FF),
                child: Text(
                  post.avatar,
                  style: const TextStyle(
                    color: Color(0xFF635BFF),
                    fontSize: 12,
                  ),
                ),
              ),
              title: Text(
                post.userName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '${post.handle} · ${post.timeAgo}',
                style: const TextStyle(fontSize: 11),
              ),
              trailing: IconButton(
                onPressed: () => _notice('More post options'),
                icon: const Icon(Icons.more_horiz),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(post.caption),
            ),
            const SizedBox(height: 12),
            AspectRatio(
              aspectRatio: 1.65,
              child: Image.asset(
                post.image,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: const Color(0xFFECE7FF),
                  child: const Icon(Icons.image, size: 48),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 4,
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() => provider.toggleLike(post));
                    },
                    icon: Icon(
                      post.isLiked
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: post.isLiked ? Colors.red : null,
                    ),
                  ),
                  Text('${post.likes + (post.isLiked ? 1 : 0)}'),
                  IconButton(
                    onPressed: () => _comments(post),
                    icon: const Icon(Icons.mode_comment_outlined),
                  ),
                  Text('${post.comments}'),
                  const Spacer(),
                  IconButton(
                    onPressed: () => _notice('Post shared'),
                    icon: const Icon(Icons.share_outlined),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _discover() => ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search people, topics and posts',
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Trending communities',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          for (final item in [
            'Photography Club',
            'Flutter Developers',
            'Travel Stories',
            'Creative Minds',
          ])
            Card(
              child: ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.groups_outlined),
                ),
                title: Text(item),
                subtitle: const Text(
                  'A friendly community to explore',
                ),
                trailing: OutlinedButton(
                  onPressed: () => _notice('You joined $item'),
                  child: const Text('Join'),
                ),
              ),
            ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.asset(
              'assets/images/social_media/social_feed_hero.png',
              height: 190,
              fit: BoxFit.cover,
            ),
          ),
        ],
      );

  Widget _messages() => ListView(
        children: [
          for (final name in provider.conversations)
            ListTile(
              leading: CircleAvatar(
                child: Text(name.substring(0, 1)),
              ),
              title: Text(
                name,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: const Text('Tap to open conversation'),
              trailing: const Text(
                'Now',
                style: TextStyle(fontSize: 11),
              ),
              onTap: () => _chat(name),
            ),
        ],
      );

  Widget _profile() => ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 16),
          const Center(
            child: CircleAvatar(
              radius: 45,
              child: Icon(Icons.person, size: 48),
            ),
          ),
          const SizedBox(height: 12),
          const Center(
            child: Text(
              'Your Profile',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Center(child: Text('@designmaster_user')),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              _Stat(value: '24', label: 'Posts'),
              _Stat(value: '1.2K', label: 'Followers'),
              _Stat(value: '380', label: 'Following'),
            ],
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: () => _notice('Edit profile screen'),
            child: const Text('Edit Profile'),
          ),
          const SizedBox(height: 8),
          ListTile(
            leading: const Icon(Icons.bookmark_border),
            title: const Text('Saved posts'),
            onTap: () => _notice('Your saved posts'),
          ),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Privacy & settings'),
            onTap: () => _notice('Settings opened'),
          ),
        ],
      );

  void _createPost() {
    final c = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Create a post'),
        content: TextField(
          controller: c,
          maxLines: 3,
          decoration: const InputDecoration(
            hintText: 'What would you like to share?',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              if (c.text.trim().isNotEmpty) {
                setState(() {
                  provider.posts.insert(
                    0,
                    SocialPost(
                      id: DateTime.now().toString(),
                      userName: 'You',
                      handle: '@you',
                      avatar: 'YO',
                      timeAgo: 'Just now',
                      caption: c.text.trim(),
                      image: 'assets/images/social_media.jpg',
                      likes: 0,
                      comments: 0,
                    ),
                  );
                });
              }
              Navigator.pop(context);
            },
            child: const Text('Post'),
          ),
        ],
      ),
    );
  }

  void _comments(SocialPost p) {
    showModalBottomSheet(
      context: context,
      builder: (_) => SizedBox(
        height: 220,
        child: Center(
          child: Text(
            'Comments for ${p.userName}\nBe the first to comment!',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  void _chat(String name) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => SizedBox(
        height: 300,
        child: Center(
          child: Text(
            'Chat with $name\nMessaging UI preview',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  void _notice(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }
}

class _Stat extends StatelessWidget {
  final String value;
  final String label;

  const _Stat({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
