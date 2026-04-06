import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeOut));
    _fadeController.forward();
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
    final pad = isTablet ? 32.0 : 20.0;
    const bg = Color(0xFFEDE7F6);
    const deep = Color(0xFF4A148C);
    const mid = Color(0xFF7B1FA2);
    const chip = Color(0xFFCE93D8);

    final List<String> tags = [
      'Cat lover',
      'Coffee addict',
      'Photography',
      'Art & Design',
      'Nature walks',
    ];

    final List<Map<String, String>> stats = [
      {'label': 'Posts', 'value': '128'},
      {'label': 'Followers', 'value': '3.4k'},
      {'label': 'Following', 'value': '214'},
    ];

    return Material(
      color: bg,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: isTablet ? 48 : 32),
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.6, end: 1.0),
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.elasticOut,
                  builder: (context, value, child) {
                    return Transform.scale(scale: value, child: child);
                  },
                  child: CircleAvatar(
                    radius: isTablet ? 90 : 60,
                    backgroundColor: chip,
                    backgroundImage: const AssetImage(
                      'assets/profile_photo.jpg',
                    ),
                  ),
                ),
                SizedBox(height: isTablet ? 20 : 14),
                Text(
                  'Catto',
                  style: TextStyle(
                    color: deep,
                    fontSize: isTablet ? 34 : 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'cattocutie@email.com',
                  style: TextStyle(color: mid, fontSize: isTablet ? 18 : 14),
                ),
                SizedBox(height: isTablet ? 10 : 6),
                Text(
                  'Cebu City, Philippines',
                  style: TextStyle(color: chip, fontSize: isTablet ? 16 : 13),
                ),
                SizedBox(height: isTablet ? 28 : 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        Icons.edit,
                        size: isTablet ? 22 : 18,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Edit Profile',
                        style: TextStyle(
                          fontSize: isTablet ? 18 : 14,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: deep,
                        elevation: 0,
                        padding: EdgeInsets.symmetric(
                          horizontal: isTablet ? 30 : 20,
                          vertical: isTablet ? 16 : 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                    SizedBox(width: isTablet ? 16 : 10),
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        Icons.share,
                        size: isTablet ? 22 : 18,
                        color: deep,
                      ),
                      label: Text(
                        'Share',
                        style: TextStyle(
                          fontSize: isTablet ? 18 : 14,
                          color: deep,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: deep, width: 1.5),
                        padding: EdgeInsets.symmetric(
                          horizontal: isTablet ? 30 : 20,
                          vertical: isTablet ? 16 : 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: isTablet ? 36 : 24),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: pad),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'About Me',
                      style: TextStyle(
                        color: deep,
                        fontSize: isTablet ? 22 : 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: isTablet ? 12 : 8),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: pad),
                  child: Text(
                    "hawakq ang beat hawakq ang beat hawakq ang beat hawakwak"
                    "who u kau saken hawakq ang beat hawakq ang beat hawakwak "
                    "bro ain't no one gonna stop me now, im on the move, im on the move, "
                    "one paw at a time.",
                    style: TextStyle(
                      color: mid,
                      fontSize: isTablet ? 17 : 14,
                      height: 1.7,
                    ),
                  ),
                ),
                SizedBox(height: isTablet ? 20 : 14),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: pad),
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 8,
                    children: tags.map((tag) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: isTablet ? 16 : 12,
                          vertical: isTablet ? 8 : 6,
                        ),
                        decoration: BoxDecoration(
                          color: chip.withOpacity(0.35),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: chip, width: 1),
                        ),
                        child: Text(
                          tag,
                          style: TextStyle(
                            color: deep,
                            fontSize: isTablet ? 15 : 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: isTablet ? 36 : 24),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: pad),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Stats',
                      style: TextStyle(
                        color: deep,
                        fontSize: isTablet ? 22 : 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: isTablet ? 12 : 8),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: pad),
                  child: Row(
                    children: stats.map((s) {
                      return Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          padding: EdgeInsets.symmetric(
                            vertical: isTablet ? 20 : 14,
                          ),
                          decoration: BoxDecoration(
                            color: chip.withOpacity(0.25),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: chip, width: 1),
                          ),
                          child: Column(
                            children: [
                              Text(
                                s['value']!,
                                style: TextStyle(
                                  color: deep,
                                  fontSize: isTablet ? 24 : 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                s['label']!,
                                style: TextStyle(
                                  color: mid,
                                  fontSize: isTablet ? 14 : 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: isTablet ? 48 : 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
