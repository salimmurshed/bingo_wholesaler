import 'package:flutter/material.dart';

extension WidgetTest on Widget {
  Widget tw({Color color = Colors.red}) {
    return Container(
      color: color,
      child: this,
    );
  }
}
