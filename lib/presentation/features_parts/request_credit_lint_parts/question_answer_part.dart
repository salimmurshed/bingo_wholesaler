part of '../../ui/add_credit_line_screen/add_credit_line_view.dart';

class QuestionAnswerPart extends StatelessWidget {
  QuestionAnswerPart(this.model, {Key? key}) : super(key: key);
  AddCreditLineViewModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.questionAnswers,
          style: AppTextStyles.dashboardBodyTitle,
        ),
        const Divider(
          color: AppColors.dividerColor,
        ),
        for (var i = 0;
            i <
                model.retailerCreditLineReqDetails.data!.fieQuestionAnswer!
                    .length;
            i++)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                    model.retailerCreditLineReqDetails.data!
                            .fieQuestionAnswer![i].question ??
                        "",
                    style: AppTextStyles.formTitleTextStyle
                        .copyWith(color: AppColors.blackColor),
                  ),
                  10.0.giveHeight,
                  SizedBox(
                    width: 100.0.wp,
                    child: TextField(
                      keyboardType: TextInputType.multiline,

                      maxLines: null,
                      textCapitalization: TextCapitalization.sentences,
                      scrollPadding: EdgeInsets.zero,
                      style: model.retailerCreditLineReqDetails.data!
                              .fieQuestionAnswer![i].answer!.isNotEmpty
                          ? AppTextStyles.formTitleTextStyleNormal
                          : AppTextStyles.formFieldTextStyle.copyWith(
                              fontWeight: FontWeight.w500,
                              color: model.retailerCreditLineReqDetails.data!
                                      .fieQuestionAnswer![i].answer!.isEmpty
                                  ? AppColors.blackColor
                                  : AppColors.ashColor),
                      enabled: model.retailerCreditLineReqDetails.data!
                          .fieQuestionAnswer![i].answer!.isEmpty,
                      // keyboardType: TextInputType.text,
                      readOnly: model.retailerCreditLineReqDetails.data!
                          .fieQuestionAnswer![i].answer!.isNotEmpty,
                      decoration: model.retailerCreditLineReqDetails.data!
                              .fieQuestionAnswer![i].answer!.isEmpty
                          ? AppInputStyles.ashOutlineBorder.copyWith(
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 12),
                              hintText: "Answer",
                              hintStyle: AppTextStyles.formFieldHintTextStyle,
                              fillColor: AppColors.whiteColor,
                              filled: true,
                              suffixIcon: null,
                            )
                          : AppInputStyles.ashOutlineBorderDisable.copyWith(
                              isDense: false,
                            ),
                      controller: model.answerController[i],
                    ),
                  ),
                ],
              ),
              // NameTextField(
              //   enable: model.retailerCreditLineReqDetails.data!
              //           .fieQuestionAnswer![i].answer!.isEmpty
              //       ? true
              //       : false,
              //   readOnly: model.retailerCreditLineReqDetails.data!
              //           .fieQuestionAnswer![i].answer!.isEmpty
              //       ? false
              //       : true,
              //   controller: model.answerController[i],
              //   fieldName: model.retailerCreditLineReqDetails.data!
              //       .fieQuestionAnswer![i].question!,
              // ),
              if (model.replyData.isNotEmpty)
                if (model.replyData[i].documents!.isNotEmpty) 10.0.giveHeight,
              if (model.replyData.isNotEmpty)
                if (model.replyData[i].documents!.isNotEmpty)
                  Wrap(
                    runSpacing: 10.0,
                    spacing: 10.0,
                    children: [
                      for (var image in model.replyData[i].documents!)
                        SizedBox(
                          height: 100.0,
                          width: 100.0,
                          child:
                              p.extension(image.path) == ".${SpecialKeys.pdf}"
                                  ? Image.asset(
                                      AppAsset.pdfImage,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.file(
                                      File(image.path),
                                      fit: BoxFit.cover,
                                    ),
                        ),
                    ],
                  ),
              if (model.retailerCreditLineReqDetails.data!.fieQuestionAnswer![i]
                  .answer!.isEmpty)
                model.isAnswerButtonBusy[i]
                    ? SizedBox(
                        height: 40.0,
                        child: Utils.loaderBusy(),
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SubmitButton(
                            onPressed: () {
                              model.submitAnswers(i, context);
                            },
                            width: 100.0,
                            text: AppLocalizations.of(context)!.reply,
                          ),
                          SubmitButton(
                            onPressed: () {
                              model.pickFilesForAnswer(i);
                            },
                            width: 100.0,
                            text: AppLocalizations.of(context)!.chooseFiles,
                          ),
                        ],
                      ),
              10.0.giveHeight,
              const Divider(
                color: AppColors.dividerColor,
              ),
            ],
          ),
      ],
    );
  }
}
