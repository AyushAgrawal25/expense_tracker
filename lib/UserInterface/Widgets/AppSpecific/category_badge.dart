import 'package:expense_tracker/UserInterface/Theme/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:clay_containers/clay_containers.dart';

class CategoryBadge extends StatelessWidget {
  const CategoryBadge(
      {super.key, required this.categoryIcon, required this.categoryName});

  final Icon categoryIcon;
  final Widget categoryName;

  @override
  Widget build(BuildContext context) {
    return ClayContainer(
      color: AppTheme.themeColor,
      depth: 25,
      spread: 1,
      borderRadius: 15,
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
