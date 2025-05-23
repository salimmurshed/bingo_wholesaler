import '../../../data_models/enums/user_roles_files.dart';
import '../../widgets/checked_box.dart';
import '../../widgets/utils_folder/validation_text.dart';
import '/const/all_const.dart';
import '/const/app_extensions/strings_extention.dart';
import '/const/utils.dart';
import '/data_models/models/retailer_approve_creditline_request/retailer_approve_creditline_request.dart';
import '/presentation/ui/retailer_creditline_details/retailer_creditline_details_view_model.dart';
import '/presentation/widgets/buttons/cancel_button.dart';
import '/presentation/widgets/cards/shadow_card.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stacked/stacked.dart';

import '../../../const/app_sizes/app_sizes.dart';
import '../../../const/app_styles/app_box_decoration.dart';
import '../../../const/server_status_file/server_status_file.dart';
import '../../../data_models/construction_model/static_data_models/visit_frequent_list_model.dart';
import '../../widgets/buttons/submit_button.dart';
import '../../widgets/cards/app_bar_text.dart';
import '../../widgets/cards/files_viewer_body.dart';
import '../../widgets/cards/loader/loader.dart';
import '../../widgets/dropdowns/selected_dropdown.dart';
import '../../widgets/text_fields/name_text_field.dart';

class RetailerCreditlineListView extends StatelessWidget {
  const RetailerCreditlineListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RetailerCreditlineListViewModel>.reactive(
        onViewModelReady: (RetailerCreditlineListViewModel model) =>
            model.setDatas(ModalRoute.of(context)!.settings.arguments
                as ApproveCreditlineRequestData),
        viewModelBuilder: () => RetailerCreditlineListViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_sharp),
                onPressed: model.goBack,
              ),
              backgroundColor: AppColors.appBarColorRetailer,
              title: AppBarText(AppLocalizations.of(context)!
                  .creditlineDetails
                  .toUpperCase()),
            ),
            body: model.isBusy
                ? SizedBox(
                    width: 100.0.wp,
                    height: 100.0.hp,
                    child: const Center(
                      child: LoaderWidget(),
                    ),
                  )
                : RefreshIndicator(
                    backgroundColor: AppColors.whiteColor,
                    color: AppColors.appBarColorRetailer,
                    onRefresh: model.pullToRefresh,
                    child: SingleChildScrollView(
                      physics: Utils.pullScrollPhysic,
                      child: Padding(
                        padding: AppPaddings.bodyVertical,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Utils.commonText(
                              AppLocalizations.of(context)!.creditLineHeader,
                              needPadding: true,
                              style: AppTextStyles.statusCardTitle,
                            ),
                            Utils.cardToTextGaps(),
                            ShadowCard(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    model.data!.bankName!,
                                    style: AppTextStyles.statusCardTitle,
                                  ),
                                  10.0.giveHeight,
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 40.0.wp,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Utils.getNiceText(
                                              '${AppLocalizations.of(context)!.creditLineID}${model.data!.internalId}',
                                              nxtln: true,
                                            ),
                                            10.0.giveHeight,
                                            Utils.getNiceText(
                                              '${AppLocalizations.of(context)!.wholesalerCamelkCase}:${model.data!.wholesalerName}',
                                              nxtln: true,
                                            ),
                                            10.0.giveHeight,
                                            Utils.getNiceText(
                                              '${AppLocalizations.of(context)!.approvedAmount}${model.data!.currency} ${model.data!.approvedAmount}',
                                              nxtln: true,
                                            ),
                                            10.0.giveHeight,
                                            Utils.getNiceText(
                                              '${AppLocalizations.of(context)!.appDate}${model.data!.approvedDate}',
                                              nxtln: true,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 40.0.wp,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Utils.getNiceText(
                                              '${AppLocalizations.of(context)!.bankAccountNo}${model.data!.bankAccountNumber!.lastChars(4)}',
                                              nxtln: true,
                                            ),
                                            10.0.giveHeight,
                                            Utils.getNiceText(
                                              '${AppLocalizations.of(context)!.remainAmount}: ${model.data!.currency} ${model.data!.remainAmount}',
                                              nxtln: true,
                                            ),
                                            10.0.giveHeight,
                                            Utils.getNiceText(
                                              '${AppLocalizations.of(context)!.minimumCommitmentDate}${model.data!.minimumCommitmentDate}',
                                              nxtln: true,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Utils.cardGaps(),
                            if (model.isReviewScreen)
                              Utils.commonText(
                                AppLocalizations.of(context)!
                                    .createCreditLineRequest,
                                needPadding: true,
                                style: AppTextStyles.statusCardTitle,
                              ),
                            if (model.isReviewScreen) 10.0.giveHeight,
                            //from here the review option condition will set
                            model.isReviewScreen
                                ? Padding(
                                    padding: AppMargins.statusCardMargin,
                                    child: Column(
                                      children: [
                                        Container(
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
                                                  model.data!.wholesalerName!,
                                                  needPadding: false),
                                              18.0.giveHeight,
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        width: 40.0.wp,
                                                        child: Utils.getNiceText(
                                                            "${AppLocalizations.of(context)!.currency}:"
                                                            "${model.data!.currency!}",
                                                            nxtln: true),
                                                      ),
                                                      10.0.giveWidth,
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            NameTextField(
                                                              controller: model
                                                                  .monthlyPurchaseController,
                                                              isNumber: true,
                                                              fieldName: AppLocalizations
                                                                      .of(context)!
                                                                  .monthlyPurchase
                                                                  .isRequired,
                                                              hintText: AppLocalizations
                                                                      .of(context)!
                                                                  .monthlyPurchase,
                                                            ),
                                                            if (model
                                                                .monthlyPurchaseErrorMessage
                                                                .isNotEmpty)
                                                              ValidationText(model
                                                                  .monthlyPurchaseErrorMessage),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  10.0.giveHeight,
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        width: 40.0.wp,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            NameTextField(
                                                              controller: model
                                                                  .averageTicketController,
                                                              isNumber: true,
                                                              fieldName: AppLocalizations
                                                                      .of(context)!
                                                                  .averagePurchaseTicket
                                                                  .isRequired,
                                                              hintText: AppLocalizations
                                                                      .of(context)!
                                                                  .averagePurchaseTicket,
                                                            ),
                                                            if (model
                                                                .averageTicketErrorMessage
                                                                .isNotEmpty)
                                                              ValidationText(model
                                                                  .averageTicketErrorMessage),
                                                          ],
                                                        ),
                                                      ),
                                                      10.0.giveWidth,
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SelectedDropdown<
                                                                VisitFrequentListModel>(
                                                              items: [
                                                                for (var i = 0;
                                                                    i <
                                                                        model
                                                                            .visitFrequentlyList
                                                                            .length;
                                                                    i++)
                                                                  DropdownMenuItem<
                                                                      VisitFrequentListModel>(
                                                                    value: model
                                                                        .visitFrequentlyList[i],
                                                                    child: Text(StatusFile.visitFrequent(
                                                                        model
                                                                            .language,
                                                                        model
                                                                            .visitFrequentlyList[i]
                                                                            .id!)),
                                                                  )
                                                              ],
                                                              dropdownValue: model
                                                                  .visitFrequency,
                                                              onChange:
                                                                  (VisitFrequentListModel?
                                                                      newValue) {
                                                                model.changeVisitFrequency(
                                                                    newValue!);
                                                              },
                                                              hintText: AppLocalizations
                                                                      .of(context)!
                                                                  .visitFrequency,
                                                              fieldName: AppLocalizations
                                                                      .of(context)!
                                                                  .visitFrequency
                                                                  .isRequired,
                                                            ),
                                                            if (model
                                                                .visitFrequencyErrorMessage
                                                                .isNotEmpty)
                                                              ValidationText(model
                                                                  .visitFrequencyErrorMessage),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  10.0.giveHeight,
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        width: 40.0.wp,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            NameTextField(
                                                              controller: model
                                                                  .requestAmountController,
                                                              isNumber: true,
                                                              fieldName: AppLocalizations
                                                                      .of(context)!
                                                                  .requestedAmount
                                                                  .isRequired,
                                                              hintText: AppLocalizations
                                                                      .of(context)!
                                                                  .requestedAmount,
                                                            ),
                                                            if (model
                                                                .requestAmountErrorMessage
                                                                .isNotEmpty)
                                                              ValidationText(model
                                                                  .requestAmountErrorMessage),
                                                          ],
                                                        ),
                                                      ),
                                                      10.0.giveWidth,
                                                      Utils.getNiceText(
                                                          "${AppLocalizations.of(context)!.fiaName}:"
                                                          "${model.data!.fieName!}",
                                                          nxtln: true),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        20.0.giveHeight,
                                        Container(
                                          padding: AppPaddings
                                              .screenARDSWidgetInnerPadding,
                                          decoration:
                                              AppBoxDecoration.shadowBox,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              20.0.giveHeight,
                                              Utils.commonText(
                                                AppLocalizations.of(context)!
                                                    .creditLineInformation,
                                                needPadding: false,
                                                style: AppTextStyles
                                                    .statusCardTitle,
                                              ),
                                              20.0.giveHeight,
                                              NameTextField(
                                                controller:
                                                    model.crn1Controller,
                                                fieldName: AppLocalizations.of(
                                                        context)!
                                                    .crn1TextField
                                                    .isRequired,
                                                hintText: AppLocalizations.of(
                                                        context)!
                                                    .crn1TextField,
                                              ),
                                              if (model
                                                  .crn1ErrorMessage.isNotEmpty)
                                                ValidationText(
                                                    model.crn1ErrorMessage),
                                              20.0.giveHeight,
                                              NameTextField(
                                                isNumber: true,
                                                controller:
                                                    model.crp1Controller,
                                                fieldName: AppLocalizations.of(
                                                        context)!
                                                    .crp1TextField
                                                    .isRequired,
                                                hintText: AppLocalizations.of(
                                                        context)!
                                                    .crp1TextField,
                                              ),
                                              if (model
                                                  .crp1ErrorMessage.isNotEmpty)
                                                ValidationText(
                                                    model.crp1ErrorMessage),
                                              20.0.giveHeight,
                                              NameTextField(
                                                controller:
                                                    model.crn2Controller,
                                                fieldName: AppLocalizations.of(
                                                        context)!
                                                    .crn2TextField,
                                                hintText: AppLocalizations.of(
                                                        context)!
                                                    .crn2TextField,
                                              ),
                                              20.0.giveHeight,
                                              NameTextField(
                                                isNumber: true,
                                                controller:
                                                    model.crp2Controller,
                                                fieldName: AppLocalizations.of(
                                                        context)!
                                                    .crp2TextField,
                                                hintText: AppLocalizations.of(
                                                        context)!
                                                    .crp2TextField,
                                              ),
                                              20.0.giveHeight,
                                              NameTextField(
                                                controller:
                                                    model.crn3Controller,
                                                fieldName: AppLocalizations.of(
                                                        context)!
                                                    .crn3TextField,
                                                hintText: AppLocalizations.of(
                                                        context)!
                                                    .crn3TextField,
                                              ),
                                              20.0.giveHeight,
                                              NameTextField(
                                                isNumber: true,
                                                controller:
                                                    model.crp3Controller,
                                                fieldName: AppLocalizations.of(
                                                        context)!
                                                    .crp3TextField,
                                                hintText: AppLocalizations.of(
                                                        context)!
                                                    .crp3TextField,
                                              ),
                                              20.0.giveHeight,
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  10.0.giveHeight,
                                                  const Divider(
                                                    color:
                                                        AppColors.dividerColor,
                                                  ),
                                                  10.0.giveHeight,
                                                  Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .uploadFie,
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
                                                    color:
                                                        AppColors.dividerColor,
                                                  ),
                                                  10.0.giveHeight,
                                                  10.0.giveHeight,
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
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
                                                  10.0.giveHeight,
                                                  SubmitButton(
                                                    onPressed: () {
                                                      model.requestReview(
                                                          context);
                                                    },
                                                    width: 100.0.wp,
                                                    height: 45.0,
                                                    text: AppLocalizations.of(
                                                            context)!
                                                        .requestCreditLineReview
                                                        .toUpperCase(),
                                                  ),
                                                  10.0.giveHeight,
                                                  SubmitButton(
                                                    onPressed: model.turnReview,
                                                    color: AppColors.redColor,
                                                    width: 100.0.wp,
                                                    height: 45.0,
                                                    text: AppLocalizations.of(
                                                            context)!
                                                        .cancelButton
                                                        .toUpperCase(),
                                                  ),
                                                ],
                                              ),
                                              37.0.giveHeight,
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Utils.commonText(
                                        AppLocalizations.of(context)!
                                            .retailerStores,
                                        needPadding: true,
                                        style: AppTextStyles.statusCardTitle,
                                      ),
                                      Padding(
                                        padding: AppPaddings.commonTextPadding,
                                        child: Text(
                                          "${AppLocalizations.of(context)!.effectiveDate} ${model.data!.effectiveDate} ["
                                          "${model.data!.timezone}]",
                                        ),
                                      ),
                                      Utils.cardToTextGaps(),
                                      for (int i = 0;
                                          i <
                                              model.data!.retailerStoreDetails!
                                                  .length;
                                          i++)
                                        ShadowCard(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 40.0.wp,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Utils.getNiceText(
                                                      '${AppLocalizations.of(context)!.locationName}:${model.data!.retailerStoreDetails![i].name}',
                                                      //change
                                                      nxtln: true,
                                                    ),
                                                    10.0.giveHeight,
                                                    Utils.getNiceText(
                                                      '${AppLocalizations.of(context)!.assignedAmount}${model.data!.currency}'
                                                      ' ${model.data!.retailerStoreDetails![i].amount!.toStringAsFixed(2)}',
                                                      nxtln: true,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 40.0.wp,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Utils.getNiceText(
                                                      '${AppLocalizations.of(context)!.address}:${model.data!.retailerStoreDetails![i].address}',
                                                      nxtln: true,
                                                    ),
                                                    10.0.giveHeight,
                                                    Utils.getNiceText(
                                                      '${AppLocalizations.of(context)!.consumedAmount}${model.data!.currency} ${model.data!.retailerStoreDetails![i].consumedAmount!.toStringAsFixed(2)}',
                                                      nxtln: true,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      Utils.cardGaps(),
                                      Utils.commonText(
                                        AppLocalizations.of(context)!
                                            .creditLineDocuments,
                                        needPadding: true,
                                        style: AppTextStyles.statusCardTitle,
                                      ),
                                      Utils.cardToTextGaps(),
                                      if (model
                                          .data!.creditlineDocuments!.isEmpty)
                                        ShadowCard(
                                          child: Utils.noDataWidget(context,
                                              height: 100.0),
                                        )
                                      else
                                        ShadowCard(
                                          child: Column(
                                            children: [
                                              for (int i = 0;
                                                  i <
                                                      model
                                                          .data!
                                                          .creditlineDocuments!
                                                          .length;
                                                  i++)
                                                ShadowCard(
                                                  isChild: true,
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        width: 36.0.wp,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Utils.getNiceText(
                                                                '${AppLocalizations.of(context)!.saleId}\n${model.data!.creditlineDocuments![i].saleUniqueId!.lastChars(10)}'),
                                                            10.0.giveHeight,
                                                            Utils.getNiceText(
                                                                '${AppLocalizations.of(context)!.documentType}\n${model.data!.creditlineDocuments![i].documentType!}'),
                                                            10.0.giveHeight,
                                                            Utils.getNiceText(
                                                                '${AppLocalizations.of(context)!.storeName}:  '
                                                                '\n${model.data!.creditlineDocuments![i].storeName!}'),
                                                            10.0.giveHeight,
                                                            Utils.getNiceText(
                                                                '${AppLocalizations.of(context)!.invoice}\n${model.data!.creditlineDocuments![i].invoice}'),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 36.0.wp,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Utils.getNiceText(
                                                                '${AppLocalizations.of(context)!.currency}:\n${model.data!.creditlineDocuments![i].currency!}'),
                                                            10.0.giveHeight,
                                                            Utils.getNiceText(
                                                                '${AppLocalizations.of(context)!.amount}:'
                                                                '\n${model.data!.creditlineDocuments![i].currency!} ${model.data!.creditlineDocuments![i].amount!}'),
                                                            10.0.giveHeight,
                                                            Utils.getNiceText(
                                                                '${AppLocalizations.of(context)!.openBalance}\n${model.data!.creditlineDocuments![i].currency!} ${model.data!.creditlineDocuments![i].openBalance!}'),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      if (model.isUserHaveAccess(UserRolesFiles
                                          .activeButtonSplitCreditLine))
                                        if (model.data!.status == 12 ||
                                            model.data!.status == 14)
                                          50.0.giveHeight,
                                      if (model.isUserHaveAccess(UserRolesFiles
                                          .activeButtonSplitCreditLine))
                                        if (model.data!.status == 12 ||
                                            model.data!.status == 14)
                                          SubmitButton(
                                              onPressed:
                                                  model.gotoSplitCreditLineView,
                                              width: 100.0.wp,
                                              height: 45.0,
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .activeButton
                                                      .toUpperCase()),
                                      if (model.isUserHaveAccess(UserRolesFiles
                                          .editSplitCreditLineButton))
                                        10.0.giveHeight,
                                      if (model.isUserHaveAccess(UserRolesFiles
                                          .editSplitCreditLineButton))
                                        if (model.data!.status == 13)
                                          Column(
                                            children: [
                                              SubmitButton(
                                                onPressed: model
                                                    .gotoSplitCreditLineEdit,
                                                width: 100.0.wp,
                                                height: 45.0,
                                                text: AppLocalizations.of(
                                                        context)!
                                                    .edit
                                                    .toUpperCase(),
                                              ),
                                              10.0.giveHeight,
                                              SubmitButton(
                                                onPressed: model.turnReview,
                                                width: 100.0.wp,
                                                height: 45.0,
                                                text: AppLocalizations.of(
                                                        context)!
                                                    .requestCreditLineReview
                                                    .toUpperCase(),
                                              ),
                                              10.0.giveHeight,
                                              CancelButton(
                                                onPressed: () {
                                                  model.inactiveCreditline(
                                                      context);
                                                },
                                                width: 100.0.wp,
                                                height: 45.0,
                                                text: AppLocalizations.of(
                                                        context)!
                                                    .inactiveButton
                                                    .toUpperCase(),
                                              ),
                                            ],
                                          ),
                                    ],
                                  ),

                            //from here the review option condition will set
                            20.0.giveHeight,
                          ],
                        ),
                      ),
                    ),
                  ),
          );
        });
  }

// getMap(model) {
//   return GoogleMap(
//     mapType: MapType.hybrid,
//     initialCameraPosition: model.kGooglePlex,
//     onMapCreated: (GoogleMapController controller) {
//       model.controller.complete(controller);
//     },
//   );
// }
}
