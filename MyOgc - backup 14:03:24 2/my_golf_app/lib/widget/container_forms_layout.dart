import 'package:flutter/material.dart';

class ContainerFormsLayout extends StatelessWidget {
  const ContainerFormsLayout({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        // decoration: BoxDecoration(border: Border.all()),
        constraints: const BoxConstraints(maxWidth: 300, maxHeight: 1000),
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 10, bottom: 20), child: child),
      ),
    );
  }
}
