import 'dart:ui';
import 'package:flutter/material.dart';

class MyAlertDialog extends StatelessWidget {

  String title;
  String content;

  MyAlertDialog(this.title, this.content, {super.key});
  TextStyle textStyle = const TextStyle (color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child:  AlertDialog(
          title:  Text(title,style: textStyle,),
          content:  Text(content, style: textStyle,),
          actions: <Widget>[
            TextButton(
              child: const Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ));
  }
}

