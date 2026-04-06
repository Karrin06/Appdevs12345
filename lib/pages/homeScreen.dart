import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List<Map<String, dynamic>> _updates = [
    {
      'title': 'New photos uploaded',
      'subtitle': 'Catto shared 5 new photos from the weekend.',
      'time': '2 hours ago',
      'icon': Icons.photo_camera,
    },
    {
      'title': 'Profile updated',
      'subtitle': 'Catto updated their bio and profile picture.',
      'time': 'Yesterday',
      'icon': Icons.person,
    },
    {
      'title': 'New message from PB',
      'subtitle': 'Naunsa naman ka mega',
      'time': '3 days ago',
      'icon': Icons.message,
    },
    {
      'title': 'Upcoming event',
      'subtitle': 'Meetup this Saturday at 5pm.',
      'time': '1 week ago',
      'icon': Icons.event,
    },
  ];

  final List<Map<String, dynamic>> _stats = [
    {'label': 'Posts', 'value': '128'},
    {'label': 'Followers', 'value': '3.4k'},
    {'label': 'Following', 'value': '214'},
    {'label': 'Likes', 'value': '9.1k'},
  ];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeOut));
    _fadeController.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(const AssetImage('assets/top_photo.jpg'), context);
    precacheImage(const AssetImage('assets/profile_photo.jpg'), context);
    precacheImage(const AssetImage('assets/msg1.jpg'), context);
    precacheImage(const AssetImage('assets/msg2.jpg'), context);
    precacheImage(const AssetImage('assets/msg3.jpg'), context);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isTablet = w >= 600;
    final h = isTablet ? 320.0 : 220.0;
    final pad = isTablet ? 28.0 : 16.0;
    final titleSize = isTablet ? 30.0 : 20.0;
    final bodySize = isTablet ? 18.0 : 14.0;
    final sectionSize = isTablet ? 22.0 : 17.0;
    const bg = Color(0xFFEDE7F6);
    const cardColor = Color(0xFFF3E5FF);
    const deep = Color(0xFF4A148C);
    const mid = Color(0xFF7B1FA2);
    const chip = Color(0xFFCE93D8);

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Container(
          color: bg,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(pad),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: SizedBox(
                      height: h,
                      width: double.infinity,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                            'assets/top_photo.jpg',
                            fit: BoxFit.cover,
                          ),
                          Container(color: deep.withOpacity(0.45)),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.all(pad),
                              color: deep.withOpacity(0.6),
                              child: Hero(
                                tag: 'welcomeHero',
                                child: Material(
                                  color: Colors.transparent,
                                  child: Text(
                                    'Welcome to Home!',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: titleSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: pad),
                  child: Text(
                    "Catto's latest updates and news, all in one place.",
                    style: TextStyle(
                      color: mid,
                      fontSize: bodySize,
                      height: 1.5,
                    ),
                  ),
                ),
                SizedBox(height: pad),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: pad),
                  child: GridView.count(
                    crossAxisCount: 4,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: isTablet ? 1.6 : 1.3,
                    children: _stats.map((s) {
                      return Container(
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: chip, width: 1),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              s['value'],
                              style: TextStyle(
                                color: deep,
                                fontSize: isTablet ? 24 : 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              s['label'],
                              style: TextStyle(
                                color: mid,
                                fontSize: isTablet ? 14 : 11,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: pad),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: pad),
                  child: Text(
                    'Recent Activity',
                    style: TextStyle(
                      color: deep,
                      fontSize: sectionSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: pad * 0.5),
                ..._updates.asMap().entries.map((entry) {
                  final i = entry.key;
                  final update = entry.value;
                  return TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: Duration(milliseconds: 400 + i * 120),
                    curve: Curves.easeOut,
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, 20 * (1 - value)),
                          child: child,
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: pad,
                        vertical: 6,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: chip, width: 1),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: isTablet ? 24 : 16,
                            vertical: isTablet ? 10 : 6,
                          ),
                          leading: CircleAvatar(
                            radius: isTablet ? 26 : 20,
                            backgroundColor: chip,
                            child: Icon(
                              update['icon'] as IconData,
                              color: deep,
                              size: isTablet ? 24 : 18,
                            ),
                          ),
                          title: Text(
                            update['title'],
                            style: TextStyle(
                              color: deep,
                              fontWeight: FontWeight.bold,
                              fontSize: isTablet ? 18 : 14,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 3),
                              Text(
                                update['subtitle'],
                                style: TextStyle(
                                  color: mid,
                                  fontSize: isTablet ? 15 : 12,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                update['time'],
                                style: TextStyle(
                                  color: chip,
                                  fontSize: isTablet ? 13 : 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
                SizedBox(height: pad * 1.5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
