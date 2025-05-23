import 'package:bingo/const/all_const.dart';
import 'package:flutter/material.dart';

import '../cards/loader/loader.dart';

class BigLoader extends StatelessWidget {
  const BigLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 100.0.wp,
        child: Center(
            child: SizedBox(
                width: 30.0.wp,
                height: 30.0.hp,
                child: const FittedBox(child: LoaderWidget()))));
  }
}
