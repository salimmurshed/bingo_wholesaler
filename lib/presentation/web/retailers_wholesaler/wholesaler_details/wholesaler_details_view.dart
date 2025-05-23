import 'package:bingo/const/all_const.dart';
import 'package:bingo/presentation/widgets/text_fields/name_text_field.dart';
import 'package:bingo/presentation/widgets/text_fields/text_area.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/nav_button.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bingo/const/utils.dart';
import 'package:bingo/const/web_devices.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/secondaryNameAppBar.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/web_app_bar.dart';

import '../../../../data_models/enums/user_type_for_web.dart';
import '../../../widgets/buttons/submit_button.dart';
import '../../../widgets/text/common_text.dart';
import 'wholesaler_details_view_model.dart';

class WholesalerDetailsView extends StatelessWidget {
  const WholesalerDetailsView({super.key, this.uid});

  final String? uid;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WholesalerDetailsViewModel>.reactive(
        viewModelBuilder: () => WholesalerDetailsViewModel(),
        onViewModelReady: (WholesalerDetailsViewModel model) {
          model.getData(uid);
        },
        builder: (context, model, child) {
          return Scaffold(
            appBar: device == ScreenSize.wide
                ? null
                : AppBar(
                    backgroundColor: model.enrollment == UserTypeForWeb.retailer
                        ? AppColors.bingoGreen
                        : AppColors.appBarColorWholesaler,
                    title: SecondaryNameAppBar(
                      h1: 'View Association Request Information',
                    ),
                  ),
            drawer: WebAppBar(
                onTap: (String v) {
                  model.changeTab(context, v);
                },
                tabNumber: model.tabNumber),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(device != ScreenSize.wide ? 0.0 : 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (device != ScreenSize.small)
                      WebAppBar(
                          onTap: (String v) {
                            model.changeTab(context, v);
                          },
                          tabNumber: model.tabNumber),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (device != ScreenSize.small)
                            SecondaryNameAppBar(
                              h1: 'View Association Request Information',
                            ),
                          Container(
                            padding: EdgeInsets.all(
                                device != ScreenSize.wide ? 12.0 : 12.0),
                            color: Colors.white,
                            width: 100.0.wp,
                            child: model.isBusy
                                ? Utils.bigLoader()
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          NavButton(
                                              isBottom: model.screenTab == 0,
                                              onTap: () {
                                                model.changeScreenTab(0);
                                              },
                                              text: "Company Information"),
                                          NavButton(
                                              isBottom: model.screenTab == 1,
                                              onTap: () {
                                                model.changeScreenTab(1);
                                              },
                                              text: "Contact Information"),
                                        ],
                                      ),
                                      10.0.giveHeight,
                                      const Divider(
                                        color: AppColors.dividerColor,
                                      ),
                                      10.0.giveHeight,
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            model.screenTab == 0
                                                ? 'Company Information'
                                                : 'Contact Information',
                                            style: AppTextStyles.headerText,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: Text(AppLocalizations.of(
                                                        context)!
                                                    .search),
                                              ),
                                              10.0.giveWidth,
                                              SizedBox(
                                                  width: 100,
                                                  height: 50,
                                                  child: NameTextField(
                                                    hintStyle: AppTextStyles
                                                        .formTitleTextStyleNormal,
                                                  ))
                                            ],
                                          ),
                                        ],
                                      ),
                                      if (model.screenTab == 0)
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width:
                                                      device == ScreenSize.small
                                                          ? 80.0.wp
                                                          : 45.0.wp,
                                                  child: NameTextField(
                                                    enable: false,
                                                    fieldName: "Company Name",
                                                    controller: model
                                                        .companyNameController,
                                                    hintStyle: AppTextStyles
                                                        .formTitleTextStyle
                                                        .copyWith(
                                                            color: AppColors
                                                                .ashColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width:
                                                      device == ScreenSize.small
                                                          ? 80.0.wp
                                                          : 45.0.wp,
                                                  child: NameTextField(
                                                    enable: false,
                                                    fieldName: "Tax ID",
                                                    controller:
                                                        model.taxIdController,
                                                    hintStyle: AppTextStyles
                                                        .formTitleTextStyle
                                                        .copyWith(
                                                            color: AppColors
                                                                .ashColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            20.0.giveHeight,
                                            SizedBox(
                                              width: device == ScreenSize.small
                                                  ? 80.0.wp
                                                  : 45.0.wp,
                                              child: NameTextField(
                                                enable: false,
                                                fieldName: "Association Date",
                                                controller: model
                                                    .associateDateController,
                                                hintStyle: AppTextStyles
                                                    .formTitleTextStyle
                                                    .copyWith(
                                                        color:
                                                            AppColors.ashColor,
                                                        fontWeight:
                                                            FontWeight.normal),
                                              ),
                                            ),
                                            20.0.giveHeight,
                                            CommonText(
                                              "Company Address",
                                              style: AppTextStyles
                                                  .formTitleTextStyle
                                                  .copyWith(
                                                      color:
                                                          AppColors.blackColor),
                                            ),
                                            4.0.giveHeight,
                                            TextArea(
                                              readOnly: true,
                                              controller:
                                                  model.addressController,
                                            )
                                          ],
                                        ),
                                      if (model.screenTab == 1)
                                        SizedBox(
                                          width: 100.0.wp,
                                          child: Wrap(
                                            runSpacing: 20.0,
                                            alignment:
                                                WrapAlignment.spaceBetween,
                                            runAlignment:
                                                WrapAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width:
                                                    device == ScreenSize.small
                                                        ? 80.0.wp
                                                        : 30.0.wp,
                                                child: NameTextField(
                                                  hintStyle: AppTextStyles
                                                      .formTitleTextStyle
                                                      .copyWith(
                                                          color: AppColors
                                                              .ashColor,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                  enable: false,
                                                  controller:
                                                      model.fNameController,
                                                  fieldName: "First Name",
                                                ),
                                              ),
                                              SizedBox(
                                                width:
                                                    device == ScreenSize.small
                                                        ? 80.0.wp
                                                        : 30.0.wp,
                                                child: NameTextField(
                                                  hintStyle: AppTextStyles
                                                      .formTitleTextStyle
                                                      .copyWith(
                                                          color: AppColors
                                                              .ashColor,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                  enable: false,
                                                  controller:
                                                      model.lNameController,
                                                  fieldName: "Last Name",
                                                ),
                                              ),
                                              SizedBox(
                                                width:
                                                    device == ScreenSize.small
                                                        ? 80.0.wp
                                                        : 30.0.wp,
                                                child: NameTextField(
                                                  hintStyle: AppTextStyles
                                                      .formTitleTextStyle
                                                      .copyWith(
                                                          color: AppColors
                                                              .ashColor,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                  enable: false,
                                                  controller:
                                                      model.positionController,
                                                  fieldName: "Position",
                                                ),
                                              ),
                                              SizedBox(
                                                width:
                                                    device == ScreenSize.small
                                                        ? 80.0.wp
                                                        : 30.0.wp,
                                                child: NameTextField(
                                                  hintStyle: AppTextStyles
                                                      .formTitleTextStyle
                                                      .copyWith(
                                                          color: AppColors
                                                              .ashColor,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                  enable: false,
                                                  controller:
                                                      model.idController,
                                                  fieldName: "ID",
                                                ),
                                              ),
                                              SizedBox(
                                                width:
                                                    device == ScreenSize.small
                                                        ? 80.0.wp
                                                        : 30.0.wp,
                                                child: NameTextField(
                                                  hintStyle: AppTextStyles
                                                      .formTitleTextStyle
                                                      .copyWith(
                                                          color: AppColors
                                                              .ashColor,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                  enable: false,
                                                  controller:
                                                      model.phoneController,
                                                  fieldName: "Phone Number",
                                                ),
                                              ),
                                              SizedBox(
                                                width:
                                                    device == ScreenSize.small
                                                        ? 80.0.wp
                                                        : 30.0.wp,
                                              ),
                                              SubmitButton(
                                                width: 60,
                                                height: 35,
                                                isRadius: false,
                                                color: AppColors.webButtonColor,
                                                text: AppLocalizations.of(
                                                        context)!
                                                    .viewDocuments,
                                                onPressed: model.viewDocuments,
                                              ),
                                            ],
                                          ),
                                        ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 12.0),
                                        child: Divider(
                                          color: AppColors.dividerColor,
                                        ),
                                      ),
                                      SubmitButton(
                                        width: 60,
                                        height: 45,
                                        isRadius: false,
                                        color: AppColors.webButtonColor,
                                        text: model.screenTab == 0
                                            ? "${AppLocalizations.of(context)!.nextButton} >"
                                            : "< ${AppLocalizations.of(context)!.backButton}",
                                        onPressed: model.screenTab == 0
                                            ? model.nextItem
                                            : model.previousItem,
                                      ),
                                    ],
                                  ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
