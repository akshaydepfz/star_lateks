import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(15.0),
        child: Center(
          child: Center(
              child: Text(
            'No Notification found!',
            style: TextStyle(fontSize: 16),
          )),
        ),
      ),
    );
  }
}
