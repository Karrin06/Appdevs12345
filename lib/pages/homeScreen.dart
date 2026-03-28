import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(16),
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: AssetImage('assets/top_photo.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.purple.withOpacity(0.3), // soft pastel overlay
                  BlendMode.softLight,
                ),
              ),
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.purple[100]?.withOpacity(0.7),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(16),
                  ),
                ),
                padding: EdgeInsets.all(8),
                // ── HERO ANIMATION: landing target for 'Welcome' from MainPage ─
                child: Hero(
                  tag: 'welcomeHero',
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      'Welcome to Home!',
                      style: TextStyle(
                        color: Colors.purple[800],
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Here you can find Catto\'s latest updates and news.',
              style: TextStyle(color: Colors.purple[600], fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
