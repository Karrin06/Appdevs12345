import 'package:flutter/material.dart';
import 'package:my_app_activity/pages/homeScreen.dart';
import 'package:my_app_activity/pages/profileScreen.dart';
import 'package:my_app_activity/pages/settingsScreen.dart';
import 'package:my_app_activity/pages/messagesScreen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  bool _showWelcome = true;
  bool _fadingOut = false;

  late AnimationController _staggerController;
  late List<Animation<double>> _iconScaleAnimations;

  Color _containerColor = const Color(0xFFEDE7F6);
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
    _staggerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
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
      _showWelcome = false;
      _containerColor = const Color(0xFFEDE7F6);
      _containerElevation = 4.0 + index.toDouble();
    });
  }

  void _dismissWelcome() {
    setState(() {
      _fadingOut = true;
    });
    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {
        _showWelcome = false;
        _fadingOut = false;
      });
      _staggerController.forward();
    });
  }

  Route _buildPageRoute(Widget screen) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final slideTween = Tween(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.easeInOut));
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
          ? null
          : AppBar(
              title: Text(
                ['Home', 'Profile', 'Settings', 'Messages'][_selectedIndex],
              ),
            ),
      drawer: _showWelcome
          ? null
          : Drawer(
              child: Container(
                color: const Color(0xFFF3E5FF),
                child: ListView(
                  children: [
                    DrawerHeader(
                      decoration: const BoxDecoration(color: Color(0xFF4A148C)),
                      child: Center(
                        child: Text(
                          'Menu',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    for (int i = 0; i < 4; i++)
                      ListTile(
                        leading: Icon(
                          [
                            Icons.home,
                            Icons.person,
                            Icons.settings,
                            Icons.message,
                          ][i],
                          color: const Color(0xFF4A148C),
                        ),
                        title: Text(
                          ['Home', 'Profile', 'Settings', 'Messages'][i],
                          style: const TextStyle(color: Color(0xFF4A148C)),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          _onItemTapped(i);
                        },
                      ),
                  ],
                ),
              ),
            ),
      body: _showWelcome
          ? GestureDetector(
              onTap: _fadingOut ? null : _dismissWelcome,
              child: AnimatedOpacity(
                opacity: _fadingOut ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOut,
                child: SizedBox.expand(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset('assets/background.jpg', fit: BoxFit.cover),
                      Container(color: Colors.black.withOpacity(0.2)),
                      Center(
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
                                shadows: const [
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
              ),
            )
          : Material(
              color: Colors.transparent,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                switchInCurve: Curves.easeIn,
                switchOutCurve: Curves.easeOut,
                child: KeyedSubtree(
                  key: ValueKey<int>(_selectedIndex),
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
                    child: Material(
                      color: Colors.transparent,
                      child: _screens[_selectedIndex],
                    ),
                  ),
                ),
              ),
            ),
      bottomNavigationBar: _showWelcome
          ? null
          : BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              backgroundColor: const Color(0xFF4A148C),
              selectedItemColor: const Color(0xFFCE93D8),
              unselectedItemColor: const Color(0xFF9C4DCC),
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
