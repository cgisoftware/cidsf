import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget? child;
  const TextFieldContainer({
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light ? Colors.blue[50] : Colors.blue[200],
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}
