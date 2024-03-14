import 'package:flutter/material.dart';

class LogoText extends StatelessWidget {
  const LogoText({this.titleColor, super.key});

  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        'My',
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontFamily: 'Oooh Baby',
              color: titleColor ?? Theme.of(context).primaryColorDark,
            ),
      ),
      Text(
        'Ogc',
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontFamily: 'Ribeye',
            color: titleColor ?? Theme.of(context).primaryColorDark,
            fontWeight: FontWeight.bold),
      ),
    ]);
  }
}
