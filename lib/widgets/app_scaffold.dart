import 'package:flutter/material.dart';
import '../Drawer/drawer.dart';

typedef TabSelectedCallback = void Function(int index);

class AppScaffold extends StatelessWidget {
  final Widget body;
  final int currentIndex;
  final TabSelectedCallback onTabSelected;
  // notifications removed

  const AppScaffold({
    Key? key,
    required this.body,
    required this.currentIndex,
    required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (ctx) => IconButton(
            icon: const Icon(Icons.menu),
            tooltip: '', // remove default tooltip
            onPressed: () => Scaffold.of(ctx).openDrawer(),
          ),
        ),
        title: const Text('Blur App Home'),
        centerTitle: true,
      ),
      drawer: const AppDrawer(),
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTabSelected,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
        ],
      ),
    );
  }
}
