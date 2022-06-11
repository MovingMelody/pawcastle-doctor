import 'package:flutter/material.dart';

class CreationAwareItem extends StatefulWidget {
  const CreationAwareItem({Key? key, required this.child, this.onReady})
      : super(key: key);

  final Widget child;
  final VoidCallback? onReady;

  @override
  _CreationAwareItemState createState() => _CreationAwareItemState();
}

class _CreationAwareItemState extends State<CreationAwareItem> {
  @override
  void initState() {
    widget.onReady?.call();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
