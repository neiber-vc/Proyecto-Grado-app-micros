import 'package:flutter/material.dart';
import 'package:app_micro_flutter/src/utils/colors.dart' as utils;

class ButtonApp extends StatelessWidget {
  Color color;
  String text;
  Color textColor;
  IconData icon;
  Function onPressed;

  ButtonApp(
      {this.color = Colors.black,
      this.textColor = Colors.white,
      this.icon = Icons.arrow_forward_ios,
      this.onPressed,
      @required this.text});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        onPressed();
      },
      color: color,
      textColor: textColor,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 50.0,
              alignment: Alignment.center,
              child: Text(
                text,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: 50.0,
              child: CircleAvatar(
                radius: 15.0,
                child: Icon(
                  icon,
                  color: utils.Colors.busColor,
                ),
                backgroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
    );
  }
}
