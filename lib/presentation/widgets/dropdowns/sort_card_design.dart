import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../const/app_colors.dart';

class SortCardDesing<T> extends StatelessWidget {
  const SortCardDesing(
      {super.key,
      required this.items,
      this.sortedItem = "",
      this.height = 60.0});

  final String sortedItem;
  final List<DropdownMenuItem<String>> items;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: SizedBox(
        height: height,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)!.sortBy),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  width: 100.0,
                  height: 30.0,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      dropdownColor: AppColors.whiteColor,
                      hint: Center(
                          child: Text(
                        sortedItem,
                        style: const TextStyle(fontSize: 14),
                      )),
                      onChanged: (a) {},
                      items: items.map((e) => e).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
