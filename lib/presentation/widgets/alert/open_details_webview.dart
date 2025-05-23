import '/const/all_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_html/flutter_html.dart';
import '../buttons/submit_button.dart';
// import 'package:html/parser.dart' as htmlparser;

class OpenDetailsWebView extends StatelessWidget {
  const OpenDetailsWebView({Key? key, required this.id, required this.des})
      : super(key: key);
  final String id;
  final String des;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.whiteColor,
      title: Text(id),
      content: SizedBox(
        width: 80.0.wp,
        child: Html(
          data: des,
        ),
      ),
      actions: [
        Center(
          child: SubmitButton(
            width: 150.0,
            text: AppLocalizations.of(context)!.accept,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        )
      ],
    );
  }
}
