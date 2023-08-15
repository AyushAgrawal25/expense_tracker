import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpenseTile extends StatefulWidget {
  const ExpenseTile({
    super.key,
    this.height,
    this.textColor,
    required this.backgroundColor,
    required this.type,
    required this.amount,
    required this.title,
    required this.date,
  });

  final double? height;
  final Color? textColor;
  final Color backgroundColor;
  final String type;
  final double amount;
  final String title;
  final DateTime date;

  @override
  State<ExpenseTile> createState() => _ExpenseTileState();
}

class _ExpenseTileState extends State<ExpenseTile> {
  @override
  Widget build(BuildContext context) {
    Color? primaryTextColor =
        (widget.textColor == null) ? Colors.white : widget.textColor;
    const Color secondaryTextColor = Color.fromARGB(255, 118, 118, 118);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        boxShadow: [
          BoxShadow(
              color: Colors.white.withOpacity(0.05).withOpacity(0.03),
              offset: const Offset(-10, -10),
              spreadRadius: 0,
              blurRadius: 10),
          BoxShadow(
              color: Colors.black87.withOpacity(0.3),
              offset: const Offset(10, 10),
              spreadRadius: 0,
              blurRadius: 10),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        height: (widget.height == null) ? 100 : widget.height!,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Icon(
                    Icons.lunch_dining_outlined,
                    color: primaryTextColor,
                    size: 27,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      widget.title,
                      style: TextStyle(color: primaryTextColor, fontSize: 22),
                    ),
                  ),
                  Text(
                    '₹',
                    style: TextStyle(color: primaryTextColor, fontSize: 30),
                  ),
                  Text(
                    widget.amount.toString(),
                    style: TextStyle(color: primaryTextColor, fontSize: 30),
                  ),
                  Icon(
                    (widget.type == 'credit')
                        ? Icons.arrow_upward
                        : Icons.arrow_downward,
                    color: Colors.green[800],
                    size: 30,
                  )
                ],
              ),
            ),
            const Expanded(
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                    'November 7, 2017',
                    style: TextStyle(color: secondaryTextColor),
                  )),
                  Text(
                    '05:51 am',
                    style: TextStyle(color: secondaryTextColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
