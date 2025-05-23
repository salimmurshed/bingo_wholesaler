import 'package:universal_html/html.dart' as html;
import 'package:bingo/const/all_const.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import '../../../../../const/app_colors.dart';
import '../../../../../data_models/models/retailer_creditline_request_details_model/retailer_creditline_request_details_model.dart';

class QuestionAnswerCreditline extends StatelessWidget {
  const QuestionAnswerCreditline(
      {this.question, this.answer, this.docList, Key? key})
      : super(key: key);
  final String? question;
  final String? answer;
  final List<SupportedDocuments>? docList;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.whiteColor,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Show Question Answer With Attachment',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
          ),
          SizedBox(
            width: 60.0.wp,
            child: const Divider(
              color: AppColors.blackColor,
            ),
          ),
          const Text(
            'Question',
            style: TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(question!),
          const Text(
            'Answer',
            style: TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(answer!),
          const Text(
            'Supported Document',
            style: TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(
            width: 60.0.wp,
            child: Wrap(
              runSpacing: 20,
              spacing: 20,
              children: [
                for (int i = 0; i < docList!.length; i++)
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: ImageNetwork(
                      onTap: () {
                        html.window
                            .open(docList![i].retailerDocument!, 'new tab');
                      },
                      image: docList![i].retailerDocument!,
                      height: 100,
                      width: 100,
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
