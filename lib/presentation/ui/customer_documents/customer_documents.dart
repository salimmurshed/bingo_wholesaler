import 'package:bingo/const/app_colors.dart';
import 'package:bingo/presentation/widgets/buttons/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomerDocuments extends StatelessWidget {
  const CustomerDocuments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.whiteColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(),
          Center(
            child: Text(AppLocalizations.of(context)!.noDocumentHere),
          ),
          FittedBox(
            child: SubmitButton(
              color: AppColors.redColor,
              onPressed: () {
                Navigator.pop(context);
              },
              text: AppLocalizations.of(context)!.goBack,
            ),
          )
        ],
      ),
    );
  }
}
