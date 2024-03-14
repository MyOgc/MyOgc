import 'package:flutter/material.dart';

// enum SampleItem { itemOne, itemTwo, itemThree }

class LayoutWidget extends StatefulWidget {
  const LayoutWidget(
      {super.key,
      required this.title,
      required this.body,
      this.bottomNavigationBar,
      this.floatingActionButton,
      this.floatingActionButtonLocation});

  final Widget title;
  final Widget body;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  @override
  State<LayoutWidget> createState() => _LayoutWidgetState();
}

class _LayoutWidgetState extends State<LayoutWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.title,
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: widget.bottomNavigationBar,
      body: widget.body,
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation:
          widget.floatingActionButtonLocation,
    );
  }
}
