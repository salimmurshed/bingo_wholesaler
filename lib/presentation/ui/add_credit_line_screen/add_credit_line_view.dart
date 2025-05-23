import 'dart:io';
import 'package:bingo/presentation/widgets/text/common_text.dart';
import 'package:multi_select_flutter/dialog/mult_select_dialog.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import '../../widgets/checked_box.dart';
import '../../widgets/utils_folder/validation_text.dart';
import '/const/all_const.dart';
import '/const/app_extensions/strings_extention.dart';
import '/const/app_extensions/widgets_extensions.dart';
import '/presentation/widgets/text_fields/name_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:path/path.dart' as p;
import 'package:stacked/stacked.dart';
import '../../../const/app_sizes/app_sizes.dart';
import '../../../const/app_styles/app_box_decoration.dart';
import '../../../const/server_status_file/server_status_file.dart';
import '../../../const/special_key.dart';
import '../../../const/utils.dart';
import '../../../data_models/models/component_models/fie_list_creditline_request_model.dart';
import '../../widgets/buttons/submit_button.dart';
import '../../widgets/cards/app_bar_text.dart';
import '../../widgets/cards/files_viewer_body.dart';
import '../../widgets/cards/loader/loader.dart';
import 'add_credit_line_view_model.dart';

part '../../features_parts/request_credit_lint_parts/image_credit_line_parts.dart';

part '../../features_parts/request_credit_lint_parts/multiple_search_selection_part.dart';

part '../../features_parts/request_credit_lint_parts/question_answer_part.dart';

class AddCreditLineView extends StatelessWidget {
  const AddCreditLineView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddCreditLineViewModel>.reactive(
      onViewModelReady: (AddCreditLineViewModel model) {
        if (ModalRoute.of(context)!.settings.arguments != null) {
          model
              .setDetails(ModalRoute.of(context)!.settings.arguments as String);
        }
      },
      viewModelBuilder: () => AddCreditLineViewModel(),
      builder: (context, model, child) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.appBarColorRetailer,
              title: model.isView
                  ? AppBarText(
                      AppLocalizations.of(context)!.creditLineInformation)
                  : AppBarText(AppLocalizations.of(context)!.creditLineRequest),
            ),
            body: model.isBusy
                ? const LoaderWidget()
                : SingleChildScrollView(
                    child: model.allWholesalers.data == null ||
                            model.retailerCreditLineReqDetails.data == null
                        // ||
                        //         model.retailerCreditLineReqDetails.data == null
                        ? const SizedBox()
                        : Column(
                            children: [
                              Padding(
                                padding: AppPaddings.cardBody,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Utils.commonText(
                                        AppLocalizations.of(context)!
                                            .creditLineInformation,
                                        needPadding: false),
                                    10.0.giveHeight,
                                    if (model.isView)
                                      Container(
                                        padding: AppPaddings
                                            .screenARDSWidgetInnerPadding,
                                        decoration: AppBoxDecoration.shadowBox,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            if (model
                                                    .retailerCreditLineReqDetails
                                                    .data !=
                                                null)
                                              Utils.commonText(
                                                  model
                                                      .retailerCreditLineReqDetails
                                                      .data!
                                                      .wholesalerName!,
                                                  needPadding: false),
                                            18.0.giveHeight,
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 40.0.wp,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Utils.getNiceText(
                                                          "${AppLocalizations.of(context)!.currency}:"
                                                          "${model.retailerCreditLineReqDetails.data!.currency!}",
                                                          nxtln: true),
                                                      12.0.giveHeight,
                                                      Utils.getNiceText(
                                                          "${AppLocalizations.of(context)!.averagePurchaseTicket}:"
                                                          "${model.retailerCreditLineReqDetails.data!.averagePurchaseTickets!}",
                                                          nxtln: true),
                                                      12.0.giveHeight,
                                                      Utils.getNiceText(
                                                          "${AppLocalizations.of(context)!.requestedAmount}:"
                                                          "${model.retailerCreditLineReqDetails.data!.requestedAmount!}",
                                                          nxtln: true),
                                                    ],
                                                  ),
                                                ),
                                                12.0.giveHeight,
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Utils.getNiceText(
                                                          "${AppLocalizations.of(context)!.monthlyPurchase}:"
                                                          "${model.retailerCreditLineReqDetails.data!.monthlyPurchase}",
                                                          nxtln: true),
                                                      12.0.giveHeight,
                                                      Utils.getNiceText(
                                                          "${AppLocalizations.of(context)!.visitFrequency}:"
                                                          "${StatusFile.visitFrequent(model.language, model.retailerCreditLineReqDetails.data!.visitFrequency!)}",
                                                          nxtln: true),
                                                      12.0.giveHeight,
                                                      Utils.getNiceText(
                                                          "${AppLocalizations.of(context)!.fiaName}:"
                                                          "${model.retailerCreditLineReqDetails.data!.fieName!}",
                                                          nxtln: true),
                                                    ],
                                                  ),
                                                ),
                                                12.0.giveHeight,
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    if (!model.isView)
                                      for (var i = 0;
                                          i <
                                              model
                                                  .creditLineInformation.length;
                                          i++)
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                if (!model.isView) {
                                                  model
                                                      .gotoUpdateWholesalerScreen(
                                                          i);
                                                }
                                              },
                                              child: Container(
                                                padding: AppPaddings
                                                    .screenARDSWidgetInnerPadding,
                                                decoration:
                                                    AppBoxDecoration.shadowBox,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Utils.commonText(
                                                        model
                                                            .creditLineInformation[
                                                                i]
                                                            .wholesaler!
                                                            .wholesalerName!,
                                                        needPadding: false),
                                                    18.0.giveHeight,
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          width: 50.0.wp,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Utils.getNiceText(
                                                                  "${AppLocalizations.of(context)!.currency}:"
                                                                  "${model.creditLineInformation[i].currency!}",
                                                                  nxtln: true),
                                                              12.0.giveHeight,
                                                              Utils.getNiceText(
                                                                  "${AppLocalizations.of(context)!.averagePurchaseTicket}:"
                                                                  "${model.creditLineInformation[i].averageTicket!}",
                                                                  nxtln: true),
                                                              12.0.giveHeight,
                                                              Utils.getNiceText(
                                                                  "${AppLocalizations.of(context)!.requestedAmount}:"
                                                                  "${model.creditLineInformation[i].amount!}",
                                                                  nxtln: true),
                                                            ],
                                                          ),
                                                        ),
                                                        12.0.giveHeight,
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Utils.getNiceText(
                                                                "${AppLocalizations.of(context)!.monthlyPurchase}:"
                                                                "${model.creditLineInformation[i].monthlyPurchase}",
                                                                nxtln: true),
                                                            12.0.giveHeight,
                                                            Utils.getNiceText(
                                                                "${AppLocalizations.of(context)!.visitFrequency}:"
                                                                "${StatusFile.visitFrequent(model.language, model.creditLineInformation[i].visitFrequency!.id!)}",
                                                                // "${model.creditLineInformation[i].visitFrequency!.title!}",
                                                                nxtln: true),
                                                          ],
                                                        ),
                                                        12.0.giveHeight,
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            10.0.giveHeight,
                                          ],
                                        ),
                                    ValidationText(model
                                        .creditLineInformationErrorMessage),
                                    10.0.giveHeight,
                                    if (!model.isView)
                                      model.allWholesalers.data![0]
                                              .wholesalerData!.isEmpty
                                          ? Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 10.0),
                                                child: Text(
                                                  AppLocalizations.of(context)!
                                                      .noWholesaler,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            )
                                          : Align(
                                              alignment: Alignment.centerRight,
                                              child: SubmitButton(
                                                onPressed: model
                                                    .gotoAddWholesalerScreen,
                                                width: 100.0,
                                                text: AppLocalizations.of(
                                                        context)!
                                                    .addNewWholesaler,
                                              ),
                                            ),
                                    10.0.giveHeight,
                                    Container(
                                      padding: AppPaddings
                                          .screenARDSWidgetInnerPadding,
                                      decoration: AppBoxDecoration.shadowBox,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          20.0.giveHeight,
                                          NameTextField(
                                            enable: !model.isView,
                                            readOnly: model.isView,
                                            controller: model.crn1Controller,
                                            fieldName:
                                                AppLocalizations.of(context)!
                                                    .crn1TextField
                                                    .isRequired,
                                          ),
                                          if (model.crn1ErrorMessage.isNotEmpty)
                                            ValidationText(
                                                model.crn1ErrorMessage),
                                          20.0.giveHeight,
                                          NameTextField(
                                            enable: !model.isView,
                                            isNumber: true,
                                            readOnly: model.isView,
                                            controller: model.crp1Controller,
                                            fieldName:
                                                AppLocalizations.of(context)!
                                                    .crp1TextField
                                                    .isRequired,
                                          ),
                                          if (model.crp1ErrorMessage.isNotEmpty)
                                            ValidationText(
                                                model.crp1ErrorMessage),
                                          20.0.giveHeight,
                                          NameTextField(
                                            enable: !model.isView,
                                            readOnly: model.isView,
                                            controller: model.crn2Controller,
                                            fieldName:
                                                AppLocalizations.of(context)!
                                                    .crn2TextField,
                                          ),
                                          20.0.giveHeight,
                                          NameTextField(
                                            enable: !model.isView,
                                            isNumber: true,
                                            readOnly: model.isView,
                                            controller: model.crp2Controller,
                                            fieldName:
                                                AppLocalizations.of(context)!
                                                    .crp2TextField,
                                          ),
                                          20.0.giveHeight,
                                          NameTextField(
                                            enable: !model.isView,
                                            readOnly: model.isView,
                                            controller: model.crn3Controller,
                                            fieldName:
                                                AppLocalizations.of(context)!
                                                    .crn3TextField,
                                          ),
                                          20.0.giveHeight,
                                          NameTextField(
                                            enable: !model.isView,
                                            isNumber: true,
                                            readOnly: model.isView,
                                            controller: model.crp3Controller,
                                            fieldName:
                                                AppLocalizations.of(context)!
                                                    .crp3TextField,
                                          ),
                                          20.0.giveHeight,
                                          if (!model.isView)
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                    // color: Colors.red,
                                                    child:
                                                        MultipleSearchSelectionPart(
                                                            model)),
                                                ValidationText(
                                                    model.fileListErrorMessage),
                                                10.0.giveHeight,
                                                const Divider(
                                                  color: AppColors.dividerColor,
                                                ),
                                                10.0.giveHeight,
                                                CommonText(
                                                  AppLocalizations.of(context)!
                                                      .uploadFie
                                                      .isRequired,
                                                  style: AppTextStyles
                                                      .successStyle,
                                                ),
                                                10.0.giveHeight,
                                                SubmitButton(
                                                  onPressed: model.pickFiles,
                                                  width: 100.0,
                                                  text: AppLocalizations.of(
                                                          context)!
                                                      .chooseFiles,
                                                ),
                                                ValidationText(
                                                    model.filesErrorMessage),
                                                10.0.giveHeight,
                                                FilesViewerBody(model.files),
                                                10.0.giveHeight,
                                                const Divider(
                                                  color: AppColors.dividerColor,
                                                ),
                                                10.0.giveHeight,
                                                CommonText(
                                                  AppLocalizations.of(context)!
                                                      .chooseOptions
                                                      .isRequired,
                                                  style: AppTextStyles
                                                      .successStyle,
                                                ),
                                                10.0.giveHeight,
                                                10.0.giveHeight,
                                                submitButton(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .bingoCanForwardRequest,
                                                    model.selectedOption,
                                                    1,
                                                    model.changeSelectedOption),
                                                20.0.giveHeight,
                                                submitButton(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .specificFIA,
                                                    model.selectedOption,
                                                    0,
                                                    model.changeSelectedOption),
                                                ValidationText(model
                                                    .selectedOptionErrorMessage),
                                                if (model.selectedOption == 0)
                                                  20.0.giveHeight,
                                                if (model.selectedOption == 0)
                                                  Container(
                                                    decoration: AppBoxDecoration
                                                        .borderDecoration,
                                                    height: 50.0,
                                                    child: Theme(
                                                      data: ThemeData(
                                                        primaryColor:
                                                            Colors.white,
                                                      ),
                                                      child: ButtonTheme(
                                                        alignedDropdown: true,
                                                        padding:
                                                            AppPaddings.zero,
                                                        child:
                                                            DropdownButtonHideUnderline(
                                                          child: DropdownButton<
                                                              FieCreditLineRequestData>(
                                                            hint: Text(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .selectFie,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 12,
                                                                color: Color(
                                                                    0xFFa5a5a5),
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                            itemHeight: 50.0,
                                                            elevation: 8,
                                                            isDense: false,
                                                            isExpanded: true,
                                                            value: model
                                                                .selectedFie,
                                                            icon: const Icon(Icons
                                                                .arrow_drop_down_outlined),
                                                            items: [
                                                              for (var i = 0;
                                                                  i <
                                                                      model
                                                                          .allFieCreditLine
                                                                          .length;
                                                                  i++)
                                                                DropdownMenuItem<
                                                                    FieCreditLineRequestData>(
                                                                  value: model
                                                                      .allFieCreditLine[i],
                                                                  child: Text(model
                                                                      .allFieCreditLine[
                                                                          i]
                                                                      .bpName!),
                                                                )
                                                            ],
                                                            onChanged:
                                                                (FieCreditLineRequestData?
                                                                    newValue) {
                                                              model.changeSingleFie(
                                                                  newValue!);
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                10.0.giveHeight,
                                                const Divider(
                                                  color: AppColors.dividerColor,
                                                ),
                                                10.0.giveHeight,
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: model
                                                          .changeAcceptTermCondition,
                                                      child: CheckedBox(
                                                          check: model
                                                              .acceptTermCondition),
                                                    ),
                                                    10.0.giveWidth,
                                                    Expanded(
                                                      child: RichText(
                                                        text: TextSpan(
                                                          recognizer:
                                                              TapGestureRecognizer()
                                                                ..onTap = () {
                                                                  model
                                                                      .changeAcceptTermCondition();
                                                                },
                                                          text:
                                                              '${AppLocalizations.of(context)!.termSplitCreditline1} ',
                                                          style: AppTextStyles
                                                              .formTitleTextStyle,
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                                recognizer:
                                                                    TapGestureRecognizer()
                                                                      ..onTap =
                                                                          () {
                                                                        model.openTerm(
                                                                            "Creditline approval T&T",
                                                                            AppLocalizations.of(context)!.termAndConditions);
                                                                      },
                                                                text:
                                                                    '${AppLocalizations.of(context)!.termAndConditions},',
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: AppColors
                                                                        .blueColor,
                                                                    decoration:
                                                                        TextDecoration
                                                                            .underline)),
                                                            TextSpan(
                                                                recognizer:
                                                                    TapGestureRecognizer()
                                                                      ..onTap =
                                                                          () {
                                                                        model
                                                                            .changeAcceptTermCondition();
                                                                      },
                                                                text: AppLocalizations.of(
                                                                        context)!
                                                                    .termSplitCreditline6),
                                                            TextSpan(
                                                                recognizer:
                                                                    TapGestureRecognizer()
                                                                      ..onTap =
                                                                          () {
                                                                        model.openTerm(
                                                                            "Credit Line",
                                                                            AppLocalizations.of(context)!.creditlineTerms);
                                                                      },
                                                                text: AppLocalizations.of(
                                                                        context)!
                                                                    .creditlineTerms,
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: AppColors
                                                                        .blueColor,
                                                                    decoration:
                                                                        TextDecoration
                                                                            .underline)),
                                                            TextSpan(
                                                                recognizer:
                                                                    TapGestureRecognizer()
                                                                      ..onTap =
                                                                          () {
                                                                        model
                                                                            .changeAcceptTermCondition();
                                                                      },
                                                                text: AppLocalizations.of(
                                                                        context)!
                                                                    .termSplitCreditline7),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                ValidationText(model
                                                    .acceptTermConditionErrorMessage),
                                                50.0.giveHeight,
                                                if (model
                                                    .allWholesalers
                                                    .data![0]
                                                    .wholesalerData!
                                                    .isNotEmpty)
                                                  model.isButtonBusy
                                                      ? const SizedBox(
                                                          height: 100.0,
                                                          child: Center(
                                                            child: SizedBox(
                                                              height: 16.0,
                                                              width: 16.0,
                                                              child: Center(
                                                                child:
                                                                    CircularProgressIndicator(
                                                                  color: AppColors
                                                                      .loader1,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      : Column(
                                                          children: [
                                                            SubmitButton(
                                                              onPressed: () {
                                                                model.addCreditLine(
                                                                    context);
                                                              },
                                                              width: 100.0.wp,
                                                              height: 45.0,
                                                              text: AppLocalizations
                                                                      .of(context)!
                                                                  .createCreditLineRequest,
                                                            ),
                                                            10.0.giveHeight,
                                                            SubmitButton(
                                                              onPressed: () {
                                                                model.cancel(
                                                                    context);
                                                              },
                                                              color: AppColors
                                                                  .redColor,
                                                              width: 100.0.wp,
                                                              height: 45.0,
                                                              text: AppLocalizations
                                                                      .of(context)!
                                                                  .cancelButton
                                                                  .toUpperCase(),
                                                            ),
                                                          ],
                                                        ),
                                              ],
                                            ),
                                          37.0.giveHeight,
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              if (model.isView)
                                Padding(
                                  padding: AppPaddings.cardBodyHorizontal,
                                  child: Container(
                                    padding: AppPaddings
                                        .screenARDSWidgetInnerPadding,
                                    decoration: AppBoxDecoration.shadowBox,
                                    child: ImageCreditLineParts(model),
                                  ),
                                ),
                              20.0.giveHeight,
                              if (model.isView)
                                if ((model.retailerCreditLineReqDetails.data!
                                            .fieQuestionAnswer ??
                                        [])
                                    .isNotEmpty)
                                  Padding(
                                    padding: AppPaddings.cardBodyHorizontal,
                                    child: Container(
                                      padding: AppPaddings
                                          .screenARDSWidgetInnerPadding,
                                      decoration: AppBoxDecoration.shadowBox,
                                      child: QuestionAnswerPart(model),
                                    ),
                                  ),
                            ],
                          ),
                  ),
          ),
        );
      },
    );
  }

  submitButton(
    String text,
    int selected,
    int index,
    void Function(int) changeSelectedOption,
  ) {
    return GestureDetector(
      onTap: () {
        changeSelectedOption(index);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          selected == index
              ? const Icon(
                  Icons.circle,
                  color: AppColors.checkBoxSelected,
                )
              : const Icon(
                  Icons.circle_outlined,
                  color: AppColors.checkBox,
                ),
          10.0.giveWidth,
          Flexible(
            child: Text(text),
          ),
        ],
      ),
    );
  }
}
