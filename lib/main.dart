import 'package:flutter/material.dart';
import 'pages/homeScreen.dart';
import 'pages/profileScreen.dart';
import 'pages/settingsScreen.dart';
import 'pages/messagesScreen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  bool _showWelcome = true; // show welcome at start

  // ── STAGGERED ANIMATION controller ────────────────────────────────────────
  late AnimationController _staggerController;
  late List<Animation<double>> _iconScaleAnimations;

  // ── IMPLICIT ANIMATION: Container color changes per tab ───────────────────
  Color _containerColor = Colors.purple.shade50;
  double _containerElevation = 2.0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const ProfileScreen(),
    const SettingsScreen(),
    const MessagesScreen(),
  ];

  @override
  void initState() {
    super.initState();

    // Staggered animation controller (fires once when welcome is dismissed)
    _staggerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    // 4 staggered scale animations, each offset by 150 ms
    _iconScaleAnimations = List.generate(4, (i) {
      final start = i * 0.15;
      final end = (start + 0.4).clamp(0.0, 1.0);
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _staggerController,
          curve: Interval(start, end, curve: Curves.elasticOut),
        ),
      );
    });
  }

  @override
  void dispose() {
    _staggerController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _showWelcome = false; // hide welcome after first tap

      // ── IMPLICIT ANIMATION: animate Container color per tab ───────────────
      _containerColor = [
        Colors.purple.shade50,
        Colors.blue.shade50,
        Colors.green.shade50,
        Colors.orange.shade50,
      ][index];
      _containerElevation = 4.0 + index.toDouble();
    });
  }

  void _dismissWelcome() {
    setState(() {
      _showWelcome = false;
    });
    // Start staggered animation once welcome is dismissed
    _staggerController.forward();
  }

  // ── ANIMATE PAGE ROUTE TRANSITION ─────────────────────────────────────────
  Route _buildPageRoute(Widget screen) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        final slideTween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));
        final fadeTween = Tween<double>(begin: 0.0, end: 1.0);
        return SlideTransition(
          position: animation.drive(slideTween),
          child: FadeTransition(
            opacity: animation.drive(fadeTween),
            child: child,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 400),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _showWelcome
          ? null // hide app bar on welcome
          : AppBar(
              title: Text(
                ['Home', 'Profile', 'Settings', 'Messages'][_selectedIndex],
              ),
            ),
      drawer: _showWelcome
          ? null // hide drawer on welcome
          : Drawer(
              child: Container(
                color: Colors.purple[50],
                child: ListView(
                  children: [
                    DrawerHeader(
                      decoration: BoxDecoration(color: Colors.purple[200]),
                      child: Center(
                        child: Text(
                          'Menu',
                          style: TextStyle(
                            color: Colors.purple[900],
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    for (int i = 0; i < 4; i++)
                      ListTile(
                        leading: Icon(
                          i == 0
                              ? Icons.home
                              : i == 1
                              ? Icons.person
                              : i == 2
                              ? Icons.settings
                              : Icons.message,
                          color: Colors.purple[800],
                        ),
                        title: Text(
                          i == 0
                              ? 'Home'
                              : i == 1
                              ? 'Profile'
                              : i == 2
                              ? 'Settings'
                              : 'Messages',
                          style: TextStyle(color: Colors.purple[800]),
                        ),
                        onTap: () {
                          Navigator.pop(context); // close drawer
                          // ── PAGE ROUTE TRANSITION from drawer ─────────────
                          Navigator.pushReplacement(
                            context,
                            _buildPageRoute(_screens[i]),
                          );
                          _onItemTapped(i);
                        },
                      ),
                  ],
                ),
              ),
            ),
      body: _showWelcome
          ? GestureDetector(
              onTap: _dismissWelcome, // tap anywhere to continue
              child: SizedBox.expand(
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/background.jpg',
                      fit: BoxFit.cover, // fully saturated
                    ),
                    Container(
                      color: Colors.black.withOpacity(0.2), // optional overlay
                    ),
                    Center(
                      // ── HERO ANIMATION: 'Welcome' tag flies into HomeScreen ─
                      child: Hero(
                        tag: 'welcomeHero',
                        child: Material(
                          color: Colors.transparent,
                          child: Text(
                            'Welcome',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  offset: Offset(2, 2),
                                  blurRadius: 6,
                                  color: Colors.black54,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          // ── FADE WIDGET IN AND OUT (AnimatedSwitcher) ──────────────────────
          : AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              switchInCurve: Curves.easeIn,
              switchOutCurve: Curves.easeOut,
              child: KeyedSubtree(
                key: ValueKey<int>(_selectedIndex),
                // ── IMPLICIT ANIMATION: AnimatedContainer wraps each screen ──
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    color: _containerColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: _containerElevation,
                        spreadRadius: _containerElevation / 2,
                      ),
                    ],
                  ),
                  child: _screens[_selectedIndex],
                ),
              ),
            ),
      bottomNavigationBar: _showWelcome
          ? null
          : BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              backgroundColor: Colors.purple[200],
              selectedItemColor: Colors.purpleAccent[400],
              unselectedItemColor: Colors.purple[800],
              // ── STAGGERED ANIMATION: each icon scales in one by one ────────
              items: List.generate(4, (i) {
                const icons = [
                  Icons.home,
                  Icons.person,
                  Icons.settings,
                  Icons.message,
                ];
                const labels = ['Home', 'Profile', 'Settings', 'Messages'];
                return BottomNavigationBarItem(
                  icon: ScaleTransition(
                    scale: _iconScaleAnimations[i],
                    child: Icon(icons[i]),
                  ),
                  label: labels[i],
                );
              }),
            ),
    );
  }
}
