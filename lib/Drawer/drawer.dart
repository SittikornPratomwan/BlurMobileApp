import 'package:flutter/material.dart';

/// Reusable app drawer moved out of home.dart
class AppDrawer extends StatelessWidget {
  final void Function(int index)? onPageChanged;

  const AppDrawer({Key? key, this.onPageChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple, Colors.deepPurpleAccent],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.white24,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  SizedBox(height: 12),
                  Text('User Name',
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                  SizedBox(height: 4),
                  Text('user@example.com',
                      style: TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.of(context).pop();
                if (onPageChanged != null) onPageChanged!(0);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.of(context).pop();
                if (onPageChanged != null) onPageChanged!(1);
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Open Settings')));
              },
            ),
            const Spacer(), // Push logout to bottom
            Container(
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ListTile(
                leading: const Icon(Icons.logout, color: Colors.white),
                title: const Text('Logout', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacementNamed('/');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
