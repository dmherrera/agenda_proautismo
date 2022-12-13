import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String title;
  final Color color;
  const TitleText(this.title, {Key? key, this.color = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(this.title,
        style:
            TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color));
  }
}

class SuperTitle extends StatelessWidget {
  final String title;

  const SuperTitle(
    this.title, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(32),
        child: Text(title,
            style: const TextStyle(
                fontFamily: 'Champagne',
                fontSize: 28,
                fontWeight: FontWeight.bold)));
  }
}

class Subtitle extends StatelessWidget {
  final String title;

  final Color? color;

  const Subtitle(this.title, {Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      this.title,
      style: TextStyle(
          fontFamily: 'Jost',
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: color),
      textAlign: TextAlign.start,
    );
  }
}
