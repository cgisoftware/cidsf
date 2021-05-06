import 'package:cids_cgi/src/core/page/widget/text_field_container.dart';
import 'package:flutter/material.dart';

class RoundedInputField extends StatelessWidget {
  final String? hintText;
  final IconData icon;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final FocusNode? focus;
  final String? validatorText;
  final bool? readOnly;
  const RoundedInputField(
      {Key? key,
      this.hintText,
      this.icon = Icons.person,
      this.onChanged,
      this.controller,
      this.focus,
      this.readOnly,
      this.validatorText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        style: TextStyle(color: Colors.black),
        validator: (value) {
          if(value!.isEmpty){
            return validatorText;
          }
        },
        controller: controller,
        onChanged: onChanged,
        focusNode: focus,
        cursorColor: Colors.blue,
        readOnly: readOnly!,
        decoration: InputDecoration(
          hintStyle: TextStyle(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.blue
                : Colors.black,
          ),
          icon: Icon(
            icon,
            color: Colors.blue,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
