import 'package:flutter/material.dart';

class TrainingCardItem extends StatelessWidget {
  const TrainingCardItem({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: double.infinity,
        height: 80,
        child: Center(
            child: Text(
          label.toUpperCase(),
          style: TextStyle(color: Theme.of(context).primaryColor),
        )),
      ),
    );
  }
}
