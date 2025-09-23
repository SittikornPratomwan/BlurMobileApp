import 'package:flutter/material.dart';
import '../Drawer/drawer.dart';

typedef TabSelectedCallback = void Function(int index);

class AppScaffold extends StatelessWidget {
  final Widget body;
  final int currentIndex;
  final TabSelectedCallback onTabSelected;
  final VoidCallback? onFabPressed;
  final IconData? fabIcon;
  final Color? fabColor;
  final double? fabOffsetY;
  // notifications removed

  const AppScaffold({
    Key? key,
    required this.body,
    required this.currentIndex,
    required this.onTabSelected,
    this.onFabPressed,
    this.fabIcon,
    this.fabColor,
    this.fabOffsetY,
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
      floatingActionButton: onFabPressed != null
          ? Transform.translate(
              offset: Offset(0, fabOffsetY ?? 8.0),
              child: FloatingActionButton(
                onPressed: onFabPressed,
                backgroundColor: fabColor ?? Theme.of(context).colorScheme.secondary,
                child: Icon(fabIcon ?? Icons.add),
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6,
        child: SizedBox(
          height: 56,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // left tab
              Expanded(
                child: InkWell(
                  onTap: () => onTabSelected(0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.home, size: 22, color: currentIndex == 0 ? Theme.of(context).primaryColor : Colors.grey[600]),
                      const SizedBox(height: 2),
                      Text('Home', style: TextStyle(fontSize: 12, color: currentIndex == 0 ? Theme.of(context).primaryColor : Colors.grey[600])),
                    ],
                  ),
                ),
              ),

              // center spacer for notch
              const SizedBox(width: 56),

              // right tab
              Expanded(
                child: InkWell(
                  onTap: () => onTabSelected(1),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.list, size: 22, color: currentIndex == 1 ? Theme.of(context).primaryColor : Colors.grey[600]),
                      const SizedBox(height: 2),
                      Text('List', style: TextStyle(fontSize: 12, color: currentIndex == 1 ? Theme.of(context).primaryColor : Colors.grey[600])),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
