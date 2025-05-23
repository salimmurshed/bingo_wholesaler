import '../../../const/app_colors.dart';
import '/const/app_extensions/widgets_extensions.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/dialog/mult_select_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

class MultiSelectItemWidget<T> extends StatelessWidget {
  MultiSelectItemWidget(
      {required this.items, required this.data, this.onChange, Key? key});

  final List<MultiSelectItem<T>> items;
  final List<T> data;
  Function(List<T>)? onChange;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500.0,
      child: MultiSelectDialog<T>(
        selectedColor: AppColors.checkBoxSelected,
        title: Text(AppLocalizations.of(context)!.selectText),
        cancelText:
            Text(AppLocalizations.of(context)!.cancelButton.toUpperCamelCase()),
        confirmText: Text(
            AppLocalizations.of(context)!.confirmButton.toUpperCamelCase()),
        items: items,
        initialValue: data,
        onConfirm: (List<T> values) {
          // if (values != null) {
          onChange!(values) ?? () {};

          // } else {
          //   null;
          // }
          // model.addFieList(values);
          // debugPrint(values);
        },
      ),
    );
  }
}
