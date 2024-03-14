import 'package:flutter/material.dart';

class TrainingElevatedButton extends StatelessWidget {
  const TrainingElevatedButton(
      {super.key, required this.label, this.isActived = false, this.onPressed});

  final String label;
  final bool isActived;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            fixedSize: const Size(140, 50),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor:
                isActived ? Theme.of(context).primaryColor : Colors.white),
        onPressed: onPressed,
        child: Text(label.toUpperCase(),
            style: TextStyle(
                fontSize: 18,
                color: isActived ? Colors.white : null,
                fontWeight: FontWeight.bold)));
  }
}
