import 'package:cids_cgi/cids_cgi.dart';
import 'package:flutter/material.dart';

class TextFieldContainer extends StatefulWidget {
  final Widget? child;
  const TextFieldContainer({
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  State<TextFieldContainer> createState() => _TextFieldContainerState();
}

class _TextFieldContainerState extends State<TextFieldContainer> {
  bool rh = false;
  final _handler = SharedPreferencesHandler();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero).then((_) async {
      this.rh = (await _handler.get("rh")) == "true";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? rh
                ? Colors.orange[50]
                : Colors.blue[50]
            : rh
                ? Colors.orange[200]
                : Colors.blue[200],
        borderRadius: BorderRadius.circular(29),
      ),
      child: widget.child,
    );
  }
}
