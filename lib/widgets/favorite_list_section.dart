import 'package:flutter/material.dart';

class FavoriteListSection<T> extends StatelessWidget {
  final String title;
  final List<T> items;
  final Widget Function(T item) cardBuilder;

  const FavoriteListSection({
    super.key,
    required this.title,
    required this.items,
    required this.cardBuilder,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title, style: Theme.of(context).textTheme.titleMedium),
        ),
        ...items.map(cardBuilder).toList(),
      ],
    );
  }
}
