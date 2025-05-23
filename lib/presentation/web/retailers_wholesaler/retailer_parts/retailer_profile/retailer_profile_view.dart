import 'package:bingo/const/all_const.dart';
import 'package:bingo/presentation/widgets/text/common_text.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../data_models/enums/user_type_for_web.dart';
import '../../../../widgets/buttons/submit_button.dart';
import '../../../../widgets/text_fields/text_area.dart';
import '../../../../widgets/web_widgets/with_tab_website_base_body.dart';
import '../secondery_bar.dart';
import 'retailer_profile_view_model.dart';
import 'package:bingo/presentation/widgets/text_fields/name_text_field.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'package:bingo/const/utils.dart';
import 'package:bingo/const/web_devices.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/secondaryNameAppBar.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/web_app_bar.dart';

class RetailerProfileView extends StatelessWidget {
  const RetailerProfileView({super.key, this.uid, this.ttx});

  final String? uid;
  final String? ttx;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RetailerProfileViewModel>.reactive(
        viewModelBuilder: () => RetailerProfileViewModel(),
        onViewModelReady: (RetailerProfileViewModel model) {
          model.getProfile(uid);
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
                      h1: 'View Retailer Profile',
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
                              h1: 'View Retailer Profile',
                            ),
                          WithTabWebsiteBaseBody(
                            body: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                model.isBusy
                                    ? Utils.bigLoader()
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Profile Information',
                                            style: AppTextStyles.headerText,
                                          ),
                                          20.0.giveHeight,
                                          SizedBox(
                                            width: 100.0.wp,
                                            child: Flex(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              direction:
                                                  device == ScreenSize.small
                                                      ? Axis.vertical
                                                      : Axis.horizontal,
                                              children: [
                                                SizedBox(
                                                  width:
                                                      device == ScreenSize.small
                                                          ? 80.0.wp
                                                          : 30.0.wp,
                                                  child: Column(
                                                    children: [
                                                      NameTextField(
                                                        controller: model
                                                            .comNameController,
                                                        enable: false,
                                                        fieldName:
                                                            "Commercial Name",
                                                        hintStyle: AppTextStyles
                                                            .formTitleTextStyle
                                                            .copyWith(
                                                                color: AppColors
                                                                    .ashColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                      ),
                                                      20.0.giveHeight,
                                                      NameTextField(
                                                        controller: model
                                                            .dateFoundedController,
                                                        enable: false,
                                                        fieldName:
                                                            "Date Founded",
                                                        hintStyle: AppTextStyles
                                                            .formTitleTextStyle
                                                            .copyWith(
                                                                color: AppColors
                                                                    .ashColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                      ),
                                                      20.0.giveHeight,
                                                      NameTextField(
                                                        controller: model
                                                            .webUrlController,
                                                        enable: false,
                                                        fieldName:
                                                            "Website URL",
                                                        hintStyle: AppTextStyles
                                                            .formTitleTextStyle
                                                            .copyWith(
                                                                color: AppColors
                                                                    .ashColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width:
                                                      device == ScreenSize.small
                                                          ? 80.0.wp
                                                          : 70.0.wp - 5 * 32,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      const CommonText(
                                                          'About Us'),
                                                      5.0.giveHeight,
                                                      Container(
                                                          height: 180.0,
                                                          decoration:
                                                              const BoxDecoration(
                                                                  color: AppColors
                                                                      .disableColor),
                                                          child: Html(
                                                            data: model.aboutUs,
                                                          )),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          const Divider(
                                            color: AppColors.dividerColor,
                                          ),
                                          const Text(
                                            'Owner/Legal Representative',
                                            style: AppTextStyles.headerText,
                                          ),
                                          20.0.giveHeight,
                                          SizedBox(
                                            width: 100.0.wp,
                                            child: Column(
                                              children: [
                                                Flex(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  direction:
                                                      device == ScreenSize.small
                                                          ? Axis.vertical
                                                          : Axis.horizontal,
                                                  children: [
                                                    SizedBox(
                                                      width: device ==
                                                              ScreenSize.small
                                                          ? 80.0.wp
                                                          : 50.0.wp - 2.5 * 32,
                                                      child: NameTextField(
                                                        controller: model
                                                            .legalNameController,
                                                        enable: false,
                                                        fieldName: "Legal Name",
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
                                                    20.0.giveHeight,
                                                    SizedBox(
                                                      width: device ==
                                                              ScreenSize.small
                                                          ? 80.0.wp
                                                          : 50.0.wp - 2.5 * 32,
                                                      child: NameTextField(
                                                        controller: model
                                                            .taxIDController,
                                                        enable: false,
                                                        fieldName: "Tax ID",
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
                                                  width:
                                                      device == ScreenSize.small
                                                          ? 80.0.wp
                                                          : 100.0.wp,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const CommonText(
                                                          'Bussiness Address'),
                                                      5.0.giveHeight,
                                                      TextArea(
                                                        controller: model
                                                            .businessAddressController,
                                                        readOnly: true,
                                                        height: 80,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Divider(
                                            color: AppColors.dividerColor,
                                          ),
                                          const Text(
                                            'Personal Information',
                                            style: AppTextStyles.headerText,
                                          ),
                                          20.0.giveHeight,
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
                                                          : 29.0.wp,
                                                  child: NameTextField(
                                                    controller:
                                                        model.fNameController,
                                                    hintStyle: AppTextStyles
                                                        .formTitleTextStyle
                                                        .copyWith(
                                                            color: AppColors
                                                                .ashColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                    enable: false,
                                                    fieldName: "First Name",
                                                  ),
                                                ),
                                                SizedBox(
                                                  width:
                                                      device == ScreenSize.small
                                                          ? 80.0.wp
                                                          : 29.0.wp,
                                                  child: NameTextField(
                                                    controller:
                                                        model.lNameController,
                                                    hintStyle: AppTextStyles
                                                        .formTitleTextStyle
                                                        .copyWith(
                                                            color: AppColors
                                                                .ashColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                    enable: false,
                                                    fieldName: "Last Name",
                                                  ),
                                                ),
                                                SizedBox(
                                                  width:
                                                      device == ScreenSize.small
                                                          ? 80.0.wp
                                                          : 29.0.wp,
                                                  child: NameTextField(
                                                    controller: model
                                                        .positionController,
                                                    hintStyle: AppTextStyles
                                                        .formTitleTextStyle
                                                        .copyWith(
                                                            color: AppColors
                                                                .ashColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                    enable: false,
                                                    fieldName: "Position",
                                                  ),
                                                ),
                                                SizedBox(
                                                  width:
                                                      device == ScreenSize.small
                                                          ? 80.0.wp
                                                          : 29.0.wp,
                                                  child: NameTextField(
                                                    controller:
                                                        model.idController,
                                                    hintStyle: AppTextStyles
                                                        .formTitleTextStyle
                                                        .copyWith(
                                                            color: AppColors
                                                                .ashColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                    enable: false,
                                                    fieldName: "ID",
                                                  ),
                                                ),
                                                SizedBox(
                                                  width:
                                                      device == ScreenSize.small
                                                          ? 80.0.wp
                                                          : 29.0.wp,
                                                  child: NameTextField(
                                                    controller:
                                                        model.phoneController,
                                                    hintStyle: AppTextStyles
                                                        .formTitleTextStyle
                                                        .copyWith(
                                                            color: AppColors
                                                                .ashColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                    enable: false,
                                                    fieldName: "Phone Number",
                                                  ),
                                                ),
                                                SizedBox(
                                                  width:
                                                      device == ScreenSize.small
                                                          ? 80.0.wp
                                                          : 29.0.wp,
                                                ),
                                                SubmitButton(
                                                  width: 60,
                                                  height: 35,
                                                  isRadius: false,
                                                  color:
                                                      AppColors.webButtonColor,
                                                  text: AppLocalizations.of(
                                                          context)!
                                                      .viewDocuments,
                                                  onPressed:
                                                      model.viewDocuments,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                              ],
                            ),
                            child: SecondaryBar(ttx, uid),
                          ),
                          // Container(
                          //   padding: EdgeInsets.all(
                          //       device != ScreenSize.wide ? 12.0 : 8.0),
                          //   color: Colors.white,
                          //   width: 100.0.wp,
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     mainAxisAlignment: MainAxisAlignment.start,
                          //     children: [
                          //
                          //       model.isBusy
                          //           ? Utils.bigLoader()
                          //           : Column(
                          //               crossAxisAlignment:
                          //                   CrossAxisAlignment.start,
                          //               children: [
                          //                 Padding(
                          //                   padding: EdgeInsets.symmetric(
                          //                       horizontal:
                          //                           device != ScreenSize.wide
                          //                               ? 0.0
                          //                               : 32.0),
                          //                   child: Column(
                          //                     crossAxisAlignment:
                          //                         CrossAxisAlignment.start,
                          //                     children: [
                          //                       const Text(
                          //                         'Profile Information',
                          //                         style:
                          //                             AppTextStyles.headerText,
                          //                       ),
                          //                       20.0.giveHeight,
                          //                       SizedBox(
                          //                         width: 100.0.wp,
                          //                         child: Flex(
                          //                           mainAxisAlignment:
                          //                               MainAxisAlignment
                          //                                   .spaceBetween,
                          //                           crossAxisAlignment:
                          //                               CrossAxisAlignment
                          //                                   .start,
                          //                           direction: device ==
                          //                                   ScreenSize.small
                          //                               ? Axis.vertical
                          //                               : Axis.horizontal,
                          //                           children: [
                          //                             SizedBox(
                          //                               width: device ==
                          //                                       ScreenSize.small
                          //                                   ? 80.0.wp
                          //                                   : 30.0.wp,
                          //                               child: Column(
                          //                                 children: [
                          //                                   NameTextField(
                          //                                     controller: model
                          //                                         .comNameController,
                          //                                     enable: false,
                          //                                     fieldName:
                          //                                         "Commercial Name",
                          //                                     hintStyle: AppTextStyles
                          //                                         .formTitleTextStyle
                          //                                         .copyWith(
                          //                                             color: AppColors
                          //                                                 .ashColor,
                          //                                             fontWeight:
                          //                                                 FontWeight
                          //                                                     .normal),
                          //                                   ),
                          //                                   20.0.giveHeight,
                          //                                   NameTextField(
                          //                                     controller: model
                          //                                         .dateFoundedController,
                          //                                     enable: false,
                          //                                     fieldName:
                          //                                         "Date Founded",
                          //                                     hintStyle: AppTextStyles
                          //                                         .formTitleTextStyle
                          //                                         .copyWith(
                          //                                             color: AppColors
                          //                                                 .ashColor,
                          //                                             fontWeight:
                          //                                                 FontWeight
                          //                                                     .normal),
                          //                                   ),
                          //                                   20.0.giveHeight,
                          //                                   NameTextField(
                          //                                     controller: model
                          //                                         .webUrlController,
                          //                                     enable: false,
                          //                                     fieldName:
                          //                                         "Website URL",
                          //                                     hintStyle: AppTextStyles
                          //                                         .formTitleTextStyle
                          //                                         .copyWith(
                          //                                             color: AppColors
                          //                                                 .ashColor,
                          //                                             fontWeight:
                          //                                                 FontWeight
                          //                                                     .normal),
                          //                                   ),
                          //                                 ],
                          //                               ),
                          //                             ),
                          //                             SizedBox(
                          //                               width: device ==
                          //                                       ScreenSize.small
                          //                                   ? 80.0.wp
                          //                                   : 70.0.wp - 5 * 32,
                          //                               child: Column(
                          //                                 crossAxisAlignment:
                          //                                     CrossAxisAlignment
                          //                                         .start,
                          //                                 children: <Widget>[
                          //                                   const CommonText(
                          //                                       'About Us'),
                          //                                   5.0.giveHeight,
                          //                                   Container(
                          //                                       height: 180.0,
                          //                                       decoration: const BoxDecoration(
                          //                                           color: AppColors
                          //                                               .disableColor),
                          //                                       child: Html(
                          //                                         data: model
                          //                                             .aboutUs,
                          //                                       )),
                          //                                 ],
                          //                               ),
                          //                             )
                          //                           ],
                          //                         ),
                          //                       ),
                          //                       const Divider(
                          //                         color: AppColors.dividerColor,
                          //                       ),
                          //                       const Text(
                          //                         'Owner/Legal Representative',
                          //                         style:
                          //                             AppTextStyles.headerText,
                          //                       ),
                          //                       20.0.giveHeight,
                          //                       SizedBox(
                          //                         width: 100.0.wp,
                          //                         child: Column(
                          //                           children: [
                          //                             Flex(
                          //                               mainAxisAlignment:
                          //                                   MainAxisAlignment
                          //                                       .spaceBetween,
                          //                               crossAxisAlignment:
                          //                                   CrossAxisAlignment
                          //                                       .start,
                          //                               direction: device ==
                          //                                       ScreenSize.small
                          //                                   ? Axis.vertical
                          //                                   : Axis.horizontal,
                          //                               children: [
                          //                                 SizedBox(
                          //                                   width: device ==
                          //                                           ScreenSize
                          //                                               .small
                          //                                       ? 80.0.wp
                          //                                       : 50.0.wp -
                          //                                           2.5 * 32,
                          //                                   child:
                          //                                       NameTextField(
                          //                                     controller: model
                          //                                         .legalNameController,
                          //                                     enable: false,
                          //                                     fieldName:
                          //                                         "Legal Name",
                          //                                     hintStyle: AppTextStyles
                          //                                         .formTitleTextStyle
                          //                                         .copyWith(
                          //                                             color: AppColors
                          //                                                 .ashColor,
                          //                                             fontWeight:
                          //                                                 FontWeight
                          //                                                     .normal),
                          //                                   ),
                          //                                 ),
                          //                                 20.0.giveHeight,
                          //                                 SizedBox(
                          //                                   width: device ==
                          //                                           ScreenSize
                          //                                               .small
                          //                                       ? 80.0.wp
                          //                                       : 50.0.wp -
                          //                                           2.5 * 32,
                          //                                   child:
                          //                                       NameTextField(
                          //                                     controller: model
                          //                                         .taxIDController,
                          //                                     enable: false,
                          //                                     fieldName:
                          //                                         "Tax ID",
                          //                                     hintStyle: AppTextStyles
                          //                                         .formTitleTextStyle
                          //                                         .copyWith(
                          //                                             color: AppColors
                          //                                                 .ashColor,
                          //                                             fontWeight:
                          //                                                 FontWeight
                          //                                                     .normal),
                          //                                   ),
                          //                                 ),
                          //                               ],
                          //                             ),
                          //                             20.0.giveHeight,
                          //                             SizedBox(
                          //                               width: device ==
                          //                                       ScreenSize.small
                          //                                   ? 80.0.wp
                          //                                   : 100.0.wp,
                          //                               child: Column(
                          //                                 crossAxisAlignment:
                          //                                     CrossAxisAlignment
                          //                                         .start,
                          //                                 children: [
                          //                                   const CommonText(
                          //                                       'Bussiness Address'),
                          //                                   5.0.giveHeight,
                          //                                   TextArea(
                          //                                     controller: model
                          //                                         .businessAddressController,
                          //                                     readOnly: true,
                          //                                     height: 80,
                          //                                   ),
                          //                                 ],
                          //                               ),
                          //                             ),
                          //                           ],
                          //                         ),
                          //                       ),
                          //                       const Divider(
                          //                         color: AppColors.dividerColor,
                          //                       ),
                          //                       const Text(
                          //                         'Personal Information',
                          //                         style:
                          //                             AppTextStyles.headerText,
                          //                       ),
                          //                       20.0.giveHeight,
                          //                       SizedBox(
                          //                         width: 100.0.wp,
                          //                         child: Wrap(
                          //                           runSpacing: 20.0,
                          //                           alignment: WrapAlignment
                          //                               .spaceBetween,
                          //                           runAlignment: WrapAlignment
                          //                               .spaceBetween,
                          //                           children: [
                          //                             SizedBox(
                          //                               width: device ==
                          //                                       ScreenSize.small
                          //                                   ? 80.0.wp
                          //                                   : 29.0.wp,
                          //                               child: NameTextField(
                          //                                 controller: model
                          //                                     .fNameController,
                          //                                 hintStyle: AppTextStyles
                          //                                     .formTitleTextStyle
                          //                                     .copyWith(
                          //                                         color: AppColors
                          //                                             .ashColor,
                          //                                         fontWeight:
                          //                                             FontWeight
                          //                                                 .normal),
                          //                                 enable: false,
                          //                                 fieldName:
                          //                                     "First Name",
                          //                               ),
                          //                             ),
                          //                             SizedBox(
                          //                               width: device ==
                          //                                       ScreenSize.small
                          //                                   ? 80.0.wp
                          //                                   : 29.0.wp,
                          //                               child: NameTextField(
                          //                                 controller: model
                          //                                     .lNameController,
                          //                                 hintStyle: AppTextStyles
                          //                                     .formTitleTextStyle
                          //                                     .copyWith(
                          //                                         color: AppColors
                          //                                             .ashColor,
                          //                                         fontWeight:
                          //                                             FontWeight
                          //                                                 .normal),
                          //                                 enable: false,
                          //                                 fieldName:
                          //                                     "Last Name",
                          //                               ),
                          //                             ),
                          //                             SizedBox(
                          //                               width: device ==
                          //                                       ScreenSize.small
                          //                                   ? 80.0.wp
                          //                                   : 29.0.wp,
                          //                               child: NameTextField(
                          //                                 controller: model
                          //                                     .positionController,
                          //                                 hintStyle: AppTextStyles
                          //                                     .formTitleTextStyle
                          //                                     .copyWith(
                          //                                         color: AppColors
                          //                                             .ashColor,
                          //                                         fontWeight:
                          //                                             FontWeight
                          //                                                 .normal),
                          //                                 enable: false,
                          //                                 fieldName: "Position",
                          //                               ),
                          //                             ),
                          //                             SizedBox(
                          //                               width: device ==
                          //                                       ScreenSize.small
                          //                                   ? 80.0.wp
                          //                                   : 29.0.wp,
                          //                               child: NameTextField(
                          //                                 controller: model
                          //                                     .idController,
                          //                                 hintStyle: AppTextStyles
                          //                                     .formTitleTextStyle
                          //                                     .copyWith(
                          //                                         color: AppColors
                          //                                             .ashColor,
                          //                                         fontWeight:
                          //                                             FontWeight
                          //                                                 .normal),
                          //                                 enable: false,
                          //                                 fieldName: "ID",
                          //                               ),
                          //                             ),
                          //                             SizedBox(
                          //                               width: device ==
                          //                                       ScreenSize.small
                          //                                   ? 80.0.wp
                          //                                   : 29.0.wp,
                          //                               child: NameTextField(
                          //                                 controller: model
                          //                                     .phoneController,
                          //                                 hintStyle: AppTextStyles
                          //                                     .formTitleTextStyle
                          //                                     .copyWith(
                          //                                         color: AppColors
                          //                                             .ashColor,
                          //                                         fontWeight:
                          //                                             FontWeight
                          //                                                 .normal),
                          //                                 enable: false,
                          //                                 fieldName:
                          //                                     "Phone Number",
                          //                               ),
                          //                             ),
                          //                             SizedBox(
                          //                               width: device ==
                          //                                       ScreenSize.small
                          //                                   ? 80.0.wp
                          //                                   : 29.0.wp,
                          //                             ),
                          //                             SubmitButton(
                          //                               width: 60,
                          //                               height: 35,
                          //                               isRadius: false,
                          //                               color: AppColors
                          //                                   .webButtonColor,
                          //                               text:
                          //                                   AppLocalizations.of(
                          //                                           context)!
                          //                                       .viewDocuments,
                          //                               onPressed:
                          //                                   model.viewDocuments,
                          //                             ),
                          //                           ],
                          //                         ),
                          //                       ),
                          //                     ],
                          //                   ),
                          //                 ),
                          //               ],
                          //             ),
                          //     ],
                          //   ),
                          // ),
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
