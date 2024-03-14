import 'package:flutter/material.dart';

class ElevatedFormButton extends StatelessWidget {
  const ElevatedFormButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isSaveButton = true,
  });

  final String text;
  final Function() onPressed;
  final bool isSaveButton;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
          border: isSaveButton ? null : Border.all(color: theme.primaryColor),
          borderRadius: BorderRadius.circular(4)),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isSaveButton ? theme.primaryColor : Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            text,
            style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: isSaveButton ? Colors.white : theme.primaryColor),
          ),
        ),
      ),
    );
  }
}