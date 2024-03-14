import 'package:flutter/material.dart';

class SessionItemCard extends StatelessWidget {
  const SessionItemCard({required this.title, required this.value, super.key});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 2, color: theme.primaryColorDark),
          borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        width: (MediaQuery.of(context).size.width / 2) - 20,
        height: 90,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 50),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  title.toUpperCase(),
                  style: TextStyle(
                    color: theme.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    value,
                    style: TextStyle(
                      color: theme.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
