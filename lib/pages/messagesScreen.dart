import 'package:flutter/material.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<Map<String, dynamic>> _messages = [
    {
      'name': 'PB',
      'preview': 'HUI MEGAAA',
      'time': '2m ago',
      'unread': 3,
      'online': true,
      'image': 'assets/msg1.jpg',
    },
    {
      'name': 'Mader Ashlot',
      'preview': 'Mana ka assignment? Laag daw',
      'time': '1h ago',
      'unread': 1,
      'online': false,
      'image': 'assets/msg2.jpg',
    },
    {
      'name': 'Karyll Anne',
      'preview': 'Bff asa ka',
      'time': '3h ago',
      'unread': 0,
      'online': true,
      'image': 'assets/msg3.jpg',
    },
    {
      'name': 'PB',
      'preview': 'laag ta na',
      'time': 'Yesterday',
      'unread': 0,
      'online': false,
      'image': 'assets/msg1.jpg',
    },
    {
      'name': 'Mader Ashlot',
      'preview': 'Megaaaaaa',
      'time': 'Mon',
      'unread': 5,
      'online': true,
      'image': 'assets/msg2.jpg',
    },
  ];

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
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isTablet = w >= 600;
    final pad = isTablet ? 28.0 : 16.0;
    const bg = Color(0xFFEDE7F6);
    const cardColor = Color(0xFFF3E5FF);
    const deep = Color(0xFF4A148C);
    const mid = Color(0xFF7B1FA2);
    const chip = Color(0xFFCE93D8);

    final filtered = _messages
        .where(
          (m) =>
              m['name'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
              m['preview'].toLowerCase().contains(_searchQuery.toLowerCase()),
        )
        .toList();

    return Material(
      color: bg,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(pad, pad, pad, pad * 0.5),
                child: TextField(
                  controller: _searchController,
                  onChanged: (v) => setState(() => _searchQuery = v),
                  style: TextStyle(color: deep, fontSize: isTablet ? 18 : 14),
                  decoration: InputDecoration(
                    hintText: 'Search messages...',
                    hintStyle: TextStyle(
                      color: mid.withOpacity(0.6),
                      fontSize: isTablet ? 18 : 14,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: mid,
                      size: isTablet ? 26 : 20,
                    ),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: Icon(
                              Icons.clear,
                              color: mid,
                              size: isTablet ? 22 : 18,
                            ),
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _searchQuery = '');
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: cardColor,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: isTablet ? 18 : 12,
                      horizontal: isTablet ? 20 : 14,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: chip, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: chip, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: deep, width: 1.5),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: pad,
                    vertical: pad * 0.5,
                  ),
                  itemCount: filtered.length,
                  itemBuilder: (context, i) {
                    final msg = filtered[i];
                    final hasUnread = (msg['unread'] as int) > 0;
                    return TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: Duration(milliseconds: 350 + i * 100),
                      curve: Curves.easeOut,
                      builder: (context, value, child) => Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, 20 * (1 - value)),
                          child: child,
                        ),
                      ),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: hasUnread ? deep.withOpacity(0.4) : chip,
                            width: hasUnread ? 1.5 : 1,
                          ),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: isTablet ? 20 : 14,
                            vertical: isTablet ? 10 : 6,
                          ),
                          leading: Stack(
                            children: [
                              CircleAvatar(
                                radius: isTablet ? 30 : 24,
                                backgroundImage: AssetImage(
                                  msg['image'] as String,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width: isTablet ? 14 : 12,
                                  height: isTablet ? 14 : 12,
                                  decoration: BoxDecoration(
                                    color: msg['online'] as bool
                                        ? Colors.green
                                        : Colors.grey,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: cardColor,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                msg['name'] as String,
                                style: TextStyle(
                                  color: deep,
                                  fontSize: isTablet ? 18 : 14,
                                  fontWeight: hasUnread
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                              Text(
                                msg['time'] as String,
                                style: TextStyle(
                                  color: hasUnread ? deep : mid,
                                  fontSize: isTablet ? 13 : 11,
                                  fontWeight: hasUnread
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  msg['preview'] as String,
                                  style: TextStyle(
                                    color: hasUnread
                                        ? mid
                                        : mid.withOpacity(0.7),
                                    fontSize: isTablet ? 15 : 12,
                                    fontWeight: hasUnread
                                        ? FontWeight.w500
                                        : FontWeight.normal,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (hasUnread)
                                Container(
                                  margin: const EdgeInsets.only(left: 8),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: deep,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    '${msg['unread']}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: isTablet ? 13 : 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
