import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AppBarText extends StatelessWidget {
  final String text;
  const AppBarText(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: FittedBox(
        child: AutoSizeText(text.toUpperCase()),
      ),
    );
  }
}
