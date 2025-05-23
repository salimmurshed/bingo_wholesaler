import '/const/all_const.dart';
import '/presentation/ui/drawer/drawer_view_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../const/app_assets.dart';
import '../../../const/app_colors.dart';
import '../slidable/slider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SliderCard extends StatelessWidget {
  const SliderCard(
      {required this.child,
      required this.keyValue,
      required this.group,
      required this.isAddNew,
      Key? key,
      required this.actionFirst,
      required this.actionTwo,
      this.longPull,
      this.isPending = true})
      : super(key: key);
  final Widget child;
  final int keyValue;
  final Object group;
  final bool isAddNew;
  final SlidableActionCallback? actionFirst;
  final SlidableActionCallback? actionTwo;
  final VoidCallback? longPull;
  final bool isPending;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      groupTag: group,
      closeOnScroll: true,
      key: const ValueKey(1),
      startActionPane: ActionPane(
        motion: const BehindMotion(),
        dismissible: DismissiblePane(
            closeOnCancel: true, onDismissed: longPull ?? () {}),
        children: [
          SlidableAction(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0)),
            padding: EdgeInsets.zero,
            onPressed: actionTwo,
            backgroundColor: AppColors.greenColor,
            foregroundColor: Colors.white,
            icon: !isPending ? AppAsset.reopen : AppAsset.executingButton,
            label: !isPending
                ? AppLocalizations.of(context)!.reopen
                : isAddNew
                    ? AppLocalizations.of(context)!.addSales
                    : AppLocalizations.of(context)!.execute,
          ),
          SlidableAction(
            padding: EdgeInsets.zero,
            onPressed: actionFirst,
            backgroundColor: AppColors.lightAshColor,
            foregroundColor: Colors.white,
            icon: AppAsset.routeMoreButton,
            label: AppLocalizations.of(context)!.more,
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        dismissible: DismissiblePane(
            closeOnCancel: true, onDismissed: longPull ?? () {}),
        children: [
          SlidableAction(
            padding: EdgeInsets.zero,
            onPressed: actionFirst,
            backgroundColor: AppColors.lightAshColor,
            foregroundColor: Colors.white,
            icon: AppAsset.routeMoreButton,
            label: AppLocalizations.of(context)!.more,
          ),
          SlidableAction(
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0)),
            padding: EdgeInsets.zero,
            onPressed: actionTwo,
            backgroundColor: AppColors.greenColor,
            foregroundColor: Colors.white,
            icon: !isPending ? AppAsset.reopen : AppAsset.executingButton,
            label: !isPending
                ? AppLocalizations.of(context)!.reopen
                : isAddNew
                    ? AppLocalizations.of(context)!.addSales
                    : AppLocalizations.of(context)!.execute,
          ),
        ],
      ),
      child: child,
    );
  }
}
