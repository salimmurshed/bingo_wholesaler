import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../const/app_colors.dart';
import '../../../data_models/models/failure.dart';

class ErrorAlert extends StatelessWidget {
  final Failure error;
  const ErrorAlert(this.error, {super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.whiteColor,
      title: Text(error.code.toString()),
      content: SingleChildScrollView(
        child: Text(error.message),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(AppLocalizations.of(context)!.approve),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
