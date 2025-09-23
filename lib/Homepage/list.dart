import 'package:flutter/material.dart';

class ListPage extends StatelessWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = List.generate(20, (i) => 'Item ${i + 1}');
    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(child: Text('${index + 1}')),
          title: Text(items[index]),
          subtitle: const Text('Tap to open'),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Tapped ${items[index]}')));
          },
        );
      },
      separatorBuilder: (_, __) => const Divider(),
      itemCount: items.length,
    );
  }
}
