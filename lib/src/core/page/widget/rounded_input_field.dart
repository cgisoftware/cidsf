import 'package:cids_cgi/cids_cgi.dart';
import 'package:cids_cgi/src/core/page/widget/text_field_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RoundedInputField extends StatefulWidget {
  final String? hintText;
  final IconData icon;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final FocusNode? focus;
  final String? validatorText;
  final bool? readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  const RoundedInputField(
      {Key? key,
      this.hintText,
      this.icon = Icons.person,
      this.onChanged,
      this.controller,
      this.focus,
      this.readOnly,
      this.validatorText,
      this.inputFormatters,
      this.keyboardType})
      : super(key: key);

  @override
  State<RoundedInputField> createState() => _RoundedInputFieldState();
}

class _RoundedInputFieldState extends State<RoundedInputField> {
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
    return TextFieldContainer(
      child: TextFormField(
        style: TextStyle(color: Colors.black),
        validator: (value) {
          if (value!.isEmpty) {
            return widget.validatorText;
          }

          return null;
        },
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatters,
        controller: widget.controller,
        onChanged: widget.onChanged,
        focusNode: widget.focus,
        cursorColor:  rh ? Color(0xffFFA856) : Colors.blue,
        readOnly: widget.readOnly!,
        decoration: InputDecoration(
          hintStyle: TextStyle(
            color: Theme.of(context).brightness == Brightness.light
                ?  rh ? Color(0xffFFA856) : Colors.blue
                : Colors.black,
          ),
          icon: Icon(
            widget.icon,
            color:  rh ? Color(0xffFFA856) : Colors.blue
          ),
          hintText: widget.hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
