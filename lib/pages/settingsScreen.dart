import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  bool _darkMode = false;
  bool _notifications = true;
  bool _messageAlerts = true;
  bool _emailUpdates = false;

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

  Widget _buildSectionLabel(String label, double fontSize, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildToggleTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required bool isTablet,
    required Color deep,
    required Color mid,
    required Color chip,
    required Color cardColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: chip, width: 1),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: isTablet ? 24 : 16,
          vertical: isTablet ? 8 : 4,
        ),
        leading: CircleAvatar(
          radius: isTablet ? 24 : 20,
          backgroundColor: chip.withOpacity(0.4),
          child: Icon(icon, color: deep, size: isTablet ? 22 : 18),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: deep,
            fontSize: isTablet ? 18 : 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: mid, fontSize: isTablet ? 14 : 12),
        ),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: deep,
          activeTrackColor: chip,
        ),
      ),
    );
  }

  Widget _buildNavTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isTablet,
    required Color deep,
    required Color mid,
    required Color chip,
    required Color cardColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: chip, width: 1),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: isTablet ? 24 : 16,
          vertical: isTablet ? 8 : 4,
        ),
        leading: CircleAvatar(
          radius: isTablet ? 24 : 20,
          backgroundColor: chip.withOpacity(0.4),
          child: Icon(icon, color: deep, size: isTablet ? 22 : 18),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: deep,
            fontSize: isTablet ? 18 : 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: mid, fontSize: isTablet ? 14 : 12),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: chip,
          size: isTablet ? 18 : 14,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isTablet = w >= 600;
    final pad = isTablet ? 32.0 : 20.0;
    const bg = Color(0xFFEDE7F6);
    const cardColor = Color(0xFFF3E5FF);
    const deep = Color(0xFF4A148C);
    const mid = Color(0xFF7B1FA2);
    const chip = Color(0xFFCE93D8);
    const danger = Color(0xFFB71C1C);
    const dangerLight = Color(0xFFFFEBEE);

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
                SizedBox(height: isTablet ? 40 : 28),
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.5, end: 1.0),
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.elasticOut,
                  builder: (context, value, child) =>
                      Transform.scale(scale: value, child: child),
                  child: CircleAvatar(
                    radius: isTablet ? 60 : 44,
                    backgroundColor: chip.withOpacity(0.4),
                    child: Icon(
                      Icons.settings,
                      size: isTablet ? 64 : 48,
                      color: deep,
                    ),
                  ),
                ),
                SizedBox(height: isTablet ? 16 : 10),
                Text(
                  'Settings',
                  style: TextStyle(
                    color: deep,
                    fontSize: isTablet ? 32 : 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: isTablet ? 6 : 4),
                Text(
                  'Manage your preferences',
                  style: TextStyle(color: mid, fontSize: isTablet ? 16 : 13),
                ),
                SizedBox(height: isTablet ? 36 : 24),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: pad),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(isTablet ? 24 : 16),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: chip, width: 1),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: isTablet ? 36 : 28,
                          backgroundColor: chip,
                          backgroundImage: const AssetImage(
                            'assets/profile_photo.jpg',
                          ),
                        ),
                        SizedBox(width: isTablet ? 20 : 14),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Catto',
                              style: TextStyle(
                                color: deep,
                                fontSize: isTablet ? 22 : 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'cattocutie@email.com',
                              style: TextStyle(
                                color: mid,
                                fontSize: isTablet ? 15 : 12,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: chip.withOpacity(0.35),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                'Free Plan',
                                style: TextStyle(
                                  color: deep,
                                  fontSize: isTablet ? 13 : 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: isTablet ? 28 : 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: pad),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: _buildSectionLabel(
                      'Appearance & Notifications',
                      isTablet ? 18 : 14,
                      mid,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: pad),
                  child: Column(
                    children: [
                      _buildToggleTile(
                        icon: Icons.dark_mode,
                        title: 'Dark Mode',
                        subtitle: 'Switch to dark theme',
                        value: _darkMode,
                        onChanged: (v) => setState(() => _darkMode = v),
                        isTablet: isTablet,
                        deep: deep,
                        mid: mid,
                        chip: chip,
                        cardColor: cardColor,
                      ),
                      _buildToggleTile(
                        icon: Icons.notifications,
                        title: 'Push Notifications',
                        subtitle: 'Receive app notifications',
                        value: _notifications,
                        onChanged: (v) => setState(() => _notifications = v),
                        isTablet: isTablet,
                        deep: deep,
                        mid: mid,
                        chip: chip,
                        cardColor: cardColor,
                      ),
                      _buildToggleTile(
                        icon: Icons.message,
                        title: 'Message Alerts',
                        subtitle: 'Notify on new messages',
                        value: _messageAlerts,
                        onChanged: (v) => setState(() => _messageAlerts = v),
                        isTablet: isTablet,
                        deep: deep,
                        mid: mid,
                        chip: chip,
                        cardColor: cardColor,
                      ),
                      _buildToggleTile(
                        icon: Icons.email,
                        title: 'Email Updates',
                        subtitle: 'Receive weekly digest',
                        value: _emailUpdates,
                        onChanged: (v) => setState(() => _emailUpdates = v),
                        isTablet: isTablet,
                        deep: deep,
                        mid: mid,
                        chip: chip,
                        cardColor: cardColor,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: isTablet ? 24 : 16),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: pad),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: _buildSectionLabel(
                      'Account',
                      isTablet ? 18 : 14,
                      mid,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: pad),
                  child: Column(
                    children: [
                      _buildNavTile(
                        icon: Icons.lock,
                        title: 'Privacy',
                        subtitle: 'Manage your privacy settings',
                        isTablet: isTablet,
                        deep: deep,
                        mid: mid,
                        chip: chip,
                        cardColor: cardColor,
                      ),
                      _buildNavTile(
                        icon: Icons.palette,
                        title: 'Theme',
                        subtitle: 'Customize your app theme',
                        isTablet: isTablet,
                        deep: deep,
                        mid: mid,
                        chip: chip,
                        cardColor: cardColor,
                      ),
                      _buildNavTile(
                        icon: Icons.help,
                        title: 'Help & Support',
                        subtitle: 'Get help or report an issue',
                        isTablet: isTablet,
                        deep: deep,
                        mid: mid,
                        chip: chip,
                        cardColor: cardColor,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: isTablet ? 24 : 16),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: pad),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: _buildSectionLabel(
                      'Danger Zone',
                      isTablet ? 18 : 14,
                      danger,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: pad),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: dangerLight,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: danger.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: isTablet ? 24 : 16,
                            vertical: isTablet ? 8 : 4,
                          ),
                          leading: CircleAvatar(
                            radius: isTablet ? 24 : 20,
                            backgroundColor: danger.withOpacity(0.15),
                            child: Icon(
                              Icons.logout,
                              color: danger,
                              size: isTablet ? 22 : 18,
                            ),
                          ),
                          title: Text(
                            'Log Out',
                            style: TextStyle(
                              color: danger,
                              fontSize: isTablet ? 18 : 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            'Sign out of your account',
                            style: TextStyle(
                              color: danger.withOpacity(0.7),
                              fontSize: isTablet ? 14 : 12,
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: danger.withOpacity(0.5),
                            size: isTablet ? 18 : 14,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: dangerLight,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: danger.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: isTablet ? 24 : 16,
                            vertical: isTablet ? 8 : 4,
                          ),
                          leading: CircleAvatar(
                            radius: isTablet ? 24 : 20,
                            backgroundColor: danger.withOpacity(0.15),
                            child: Icon(
                              Icons.delete_forever,
                              color: danger,
                              size: isTablet ? 22 : 18,
                            ),
                          ),
                          title: Text(
                            'Delete Account',
                            style: TextStyle(
                              color: danger,
                              fontSize: isTablet ? 18 : 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            'Permanently delete your account',
                            style: TextStyle(
                              color: danger.withOpacity(0.7),
                              fontSize: isTablet ? 14 : 12,
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: danger.withOpacity(0.5),
                            size: isTablet ? 18 : 14,
                          ),
                        ),
                      ),
                    ],
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
