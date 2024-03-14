import 'package:flutter/material.dart';

class TrainingCampoItem extends StatelessWidget {
  const TrainingCampoItem({
    super.key,
    required this.label,
    required this.value,
    this.isBigFont = false,
  });

  final String label;
  final String value;
  final bool isBigFont;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: isBigFont ? 90 : 50,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            label.toUpperCase(),
            style: TextStyle(color: Theme.of(context).primaryColor, fontSize: isBigFont ? 24 : 18),
          ),
          Text(
            value,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: isBigFont ? 24 : 20,
                color: Theme.of(context).primaryColorDark),
          ),
        ]),
      ),
    );
  }
}
