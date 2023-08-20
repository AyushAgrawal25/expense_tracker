import 'package:expense_tracker/UserInterface/Widgets/Container/neu_container.dart';
import 'package:flutter/material.dart';

class CategoryBadge extends StatelessWidget {
  const CategoryBadge(
      {super.key, required this.categoryIcon, required this.categoryName});

  final Icon categoryIcon;
  final Widget categoryName;

  @override
  Widget build(BuildContext context) {
    return NeuContainer(
      depth: 25,
      spread: 1,
      radius: 15,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            categoryName,
            const SizedBox(
              height: 5,
            ),
            categoryIcon,
          ],
        ),
      ),
    );
  }
}
