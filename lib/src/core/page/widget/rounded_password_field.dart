import 'package:cids_cgi/src/core/page/widget/text_field_container.dart';
import 'package:flutter/material.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  const RoundedPasswordField({Key? key, this.onChanged, this.controller})
      : super(key: key);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        style: TextStyle(color: Colors.black),
        controller: widget.controller,
        obscureText: !_visible,
        onChanged: widget.onChanged,
        cursorColor: Colors.blue,
        decoration: InputDecoration(
          hintStyle: TextStyle(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.blue
                : Colors.black,
          ),
          hintText: "Sua Senha",
          icon: Icon(
            Icons.lock,
            color: Colors.blue,
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              _visible = !_visible;
              setState(() {});
            },
            child: Icon(
              _visible ? Icons.visibility_off : Icons.visibility,
              color: Colors.blue,
            ),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
