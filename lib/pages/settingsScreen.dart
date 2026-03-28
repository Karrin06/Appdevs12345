import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        ListTile(
          leading: Icon(Icons.lock, color: Colors.purple[800]),
          title: Text('Privacy', style: TextStyle(color: Colors.purple[800])),
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.purple[600]),
        ),
        Divider(color: Colors.purple[200]),
        ListTile(
          leading: Icon(Icons.notifications, color: Colors.purple[800]),
          title: Text(
            'Notifications',
            style: TextStyle(color: Colors.purple[800]),
          ),
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.purple[600]),
        ),
        Divider(color: Colors.purple[200]),
        ListTile(
          leading: Icon(Icons.palette, color: Colors.purple[800]),
          title: Text('Theme', style: TextStyle(color: Colors.purple[800])),
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.purple[600]),
        ),
      ],
    );
  }
}
