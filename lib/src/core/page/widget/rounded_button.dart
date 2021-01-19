import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  final bool loading;
  const RoundedButton(
      {Key key,
      this.text,
      this.press,
      this.color = Colors.blueAccent,
      this.textColor = Colors.white,
      this.loading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      height: 60,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          color: color,
          onPressed: press,
          child: loading
              ? Container(
                  width: 20,
                  child: CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.white)))
              : Text(
                  text,
                  style: TextStyle(color: textColor),
                ),
        ),
      ),
    );
  }
}
