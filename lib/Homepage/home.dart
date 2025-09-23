import 'package:flutter/material.dart';
import '../widgets/app_scaffold.dart';
import 'list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      currentIndex: _currentIndex,
      onTabSelected: (i) {
        setState(() {
          _currentIndex = i;
        });
      },
      body: IndexedStack(
        index: _currentIndex,
        children: [
          // Home content
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.blur_on,
                  size: 100,
                  color: Colors.deepPurple,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Welcome to Blur App',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Back'),
                ),
              ],
            ),
          ),
          // List page content
          const ListPage(),
        ],
      ),
    );
  }
}
