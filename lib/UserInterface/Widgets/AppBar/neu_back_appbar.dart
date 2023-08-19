import 'package:expense_tracker/UserInterface/Theme/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:clay_containers/clay_containers.dart';

class NeuBackBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final Widget? title;
  final List<Widget>? actions;
  final Color? color;

  const NeuBackBar({
    super.key,
    this.height = 80,
    this.title,
    this.actions,
    this.color = AppTheme.textColor,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      color: AppTheme.themeColor,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Material(
              type: MaterialType.transparency,
              child: ClayContainer(
                width: 48,
                height: 48,
                borderRadius: 10,
                depth: 10,
                spread: 5,
                color: AppTheme.themeColor,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              alignment: Alignment.centerLeft,
              child: (title != null) ? title! : null,
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: (actions == null) ? [] : actions!,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
