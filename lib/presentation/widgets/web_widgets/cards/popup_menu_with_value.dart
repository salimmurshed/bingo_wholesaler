import 'package:flutter/material.dart';

import '../../../../const/app_colors.dart';

class PopupMenuWithValue<T> extends StatelessWidget {
  const PopupMenuWithValue(
      {super.key,
      required this.text,
      required this.color,
      required this.items,
      required this.onTap});
  final String text;
  final Color color;
  final List items;
  final Function(T)? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: FittedBox(
        child: Material(
          color: Colors.white,
          child: PopupMenuButton<T>(
            tooltip: text,
            onSelected: (T value) {
              onTap!(value);
            },
            splashRadius: 20.0,
            offset: const Offset(0, 40),
            itemBuilder: (BuildContext context) {
              return items
                  .asMap()
                  .map((index, e) => MapEntry(
                      index,
                      PopupMenuItem<T>(
                        height: 30,
                        //PopupMenuWithValue(
                        value: e['v'],
                        child: Text(
                          e['t'],
                          style: const TextStyle(
                              fontSize: 12, color: AppColors.ashColor),
                        ),
                      )))
                  .values
                  .toList();
            },
            elevation: 8.0,
            child: Card(
              color: color,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
                child: Row(
                  children: [
                    Text(
                      text,
                      style: const TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 12,
                      ),
                    ),
                    const Icon(Icons.keyboard_arrow_down_sharp,
                        color: AppColors.whiteColor)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
