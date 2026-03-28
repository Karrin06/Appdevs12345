import 'package:flutter/material.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        ListTile(
          leading: CircleAvatar(backgroundImage: AssetImage('assets/msg1.jpg')),
          title: Text('Alice', style: TextStyle(color: Colors.purple[800])),
          subtitle: Text(
            'Hey! How are you?',
            style: TextStyle(color: Colors.purple[600]),
          ),
        ),
        ListTile(
          leading: CircleAvatar(backgroundImage: AssetImage('assets/msg2.jpg')),
          title: Text('Bob', style: TextStyle(color: Colors.purple[800])),
          subtitle: Text(
            'Meeting at 5?',
            style: TextStyle(color: Colors.purple[600]),
          ),
        ),
        ListTile(
          leading: CircleAvatar(backgroundImage: AssetImage('assets/msg3.jpg')),
          title: Text('Charlie', style: TextStyle(color: Colors.purple[800])),
          subtitle: Text(
            'Check this out!',
            style: TextStyle(color: Colors.purple[600]),
          ),
        ),
      ],
    );
  }
}
