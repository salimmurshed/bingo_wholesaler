import 'package:bingo/const/all_const.dart';
import 'package:bingo/presentation/widgets/buttons/submit_button.dart';
import 'package:bingo/presentation/widgets/text_fields/name_text_field.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bingo/const/utils.dart';
import 'package:bingo/const/web_devices.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/secondaryNameAppBar.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/web_app_bar.dart';

import '../../../../const/web _utils.dart';
import '../../../../data_models/enums/user_type_for_web.dart';
import '../../../widgets/text/common_text.dart';
import '../../../widgets/utils_folder/validation_text.dart';
import '../../../widgets/web_widgets/body/table.dart';
// import '../../../widgets/web_widgets/html_editor_enhanced/html_editor.dart';
// import '../../../widgets/web_widgets/html_editor_enhanced/utils/options.dart';
import 'company_profile_view_model.dart';

class CompanyProfileView extends StatelessWidget {
  const CompanyProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CompanyProfileViewModel>.reactive(
        viewModelBuilder: () => CompanyProfileViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            drawer: WebAppBar(
                onTap: (String v) {
                  model.changeTab(context, v);
                },
                tabNumber: model.tabNumber),
            appBar: device == ScreenSize.wide
                ? null
                : AppBar(
                    backgroundColor: model.enrollment == UserTypeForWeb.retailer
                        ? AppColors.bingoGreen
                        : AppColors.appBarColorWholesaler,
                    title: SecondaryNameAppBar(
                      h1: 'Company Profiles',
                    ),
                  ),
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
                              h1: 'Company Profiles',
                            ),
                          Container(
                            padding: EdgeInsets.all(
                                device != ScreenSize.wide ? 12.0 : 32.0),
                            color: Colors.white,
                            width: 100.0.wp,
                            child: model.isBusy
                                ? Utils.bigLoader()
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: device == ScreenSize.wide
                                            ? 400
                                            : null,
                                        child: Flex(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: device ==
                                                  ScreenSize.wide
                                              ? MainAxisAlignment.spaceBetween
                                              : MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              device == ScreenSize.wide
                                                  ? CrossAxisAlignment.center
                                                  : CrossAxisAlignment.start,
                                          direction: device == ScreenSize.wide
                                              ? Axis.horizontal
                                              : Axis.vertical,
                                          children: [
                                            SizedBox(
                                              width: device == ScreenSize.small
                                                  ? 80.0.wp
                                                  : 22.0.wp,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      NameTextField(
                                                          enable: true,
                                                          hintStyle: AppTextStyles
                                                              .formTitleTextStyleNormal,
                                                          style: AppTextStyles
                                                              .formFieldTextStyle,
                                                          controller: model
                                                              .commercialNameController,
                                                          fieldName:
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .commercialName),
                                                      if (model
                                                          .commercialNameError
                                                          .isNotEmpty)
                                                        ValidationText(model
                                                            .commercialNameError),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      NameTextField(
                                                          enable: true,
                                                          hintStyle: AppTextStyles
                                                              .formTitleTextStyleNormal,
                                                          style: AppTextStyles
                                                              .formFieldTextStyle,
                                                          controller: model
                                                              .mainProductController,
                                                          fieldName:
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .mainProduct),
                                                      if (model.mainProductError
                                                          .isNotEmpty)
                                                        ValidationText(model
                                                            .mainProductError),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      NameTextField(
                                                          enable: true,
                                                          hintStyle: AppTextStyles
                                                              .formTitleTextStyleNormal,
                                                          style: AppTextStyles
                                                              .formFieldTextStyle,
                                                          controller: model
                                                              .dateFoundedController,
                                                          fieldName:
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .dateFounded),
                                                      if (model.dateFoundedError
                                                          .isNotEmpty)
                                                        ValidationText(model
                                                            .dateFoundedError),
                                                    ],
                                                  ),
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 64.0),
                                                      child: SizedBox(
                                                        width: device ==
                                                                ScreenSize.small
                                                            ? 80.0.wp
                                                            : 22.0.wp,
                                                        height: 47,
                                                      )),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: device == ScreenSize.small
                                                  ? 80.0.wp
                                                  : 22.0.wp,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      NameTextField(
                                                          enable: true,
                                                          hintStyle: AppTextStyles
                                                              .formTitleTextStyleNormal,
                                                          style: AppTextStyles
                                                              .formFieldTextStyle,
                                                          controller: model
                                                              .informationController,
                                                          fieldName:
                                                              "Information"),
                                                      if (model.informationError
                                                          .isNotEmpty)
                                                        ValidationText(model
                                                            .informationError),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      NameTextField(
                                                          enable: true,
                                                          hintStyle: AppTextStyles
                                                              .formTitleTextStyleNormal,
                                                          style: AppTextStyles
                                                              .formFieldTextStyle,
                                                          controller: model
                                                              .urlController,
                                                          fieldName:
                                                              "Website URL"),
                                                      if (model.webUrlError
                                                          .isNotEmpty)
                                                        ValidationText(
                                                            model.webUrlError),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      CommonText(
                                                        "Upload Logo",
                                                        style: AppTextStyles
                                                            .formTitleTextStyle
                                                            .copyWith(
                                                                color: AppColors
                                                                    .blackColor),
                                                      ),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8),
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: AppColors
                                                                    .cardShadow),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0)),
                                                        child: Row(
                                                          children: [
                                                            SubmitButton(
                                                              onPressed: () {
                                                                model
                                                                    .uploadFile();
                                                              },
                                                              fontColor: AppColors
                                                                  .blackColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              text: AppLocalizations
                                                                      .of(context)!
                                                                  .chooseFiles,
                                                              width: 35.0,
                                                              color: AppColors
                                                                  .webBackgroundColor,
                                                            ),
                                                            Expanded(
                                                              child: Row(
                                                                children: [
                                                                  5.0.giveWidth,
                                                                  Expanded(
                                                                    child: Text(
                                                                      model.logoImageName.isNotEmpty
                                                                          ? model
                                                                              .logoImageName
                                                                          : AppLocalizations.of(context)!
                                                                              .noFileSelected,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            if (model
                                                                    .logoImage !=
                                                                null)
                                                              SizedBox(
                                                                height: 40.0,
                                                                width: 40.0,
                                                                child: Image
                                                                    .memory(
                                                                  model
                                                                      .logoImage!,
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                              ),
                                                            // 20.0.giveWidth
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  model.logoImage != null
                                                      ? SizedBox(
                                                          height: 100.0,
                                                          width: 100.0,
                                                          child: Image.memory(
                                                              model.logoImage!),
                                                        )
                                                      : model.serverImage
                                                              .isEmpty
                                                          ? Image.asset(AppAsset
                                                              .loginLogo)
                                                          : WebUtils.image(
                                                              context,
                                                              model.serverImage,
                                                              width: 100,
                                                              height: 100),
                                                ],
                                              ),
                                            ),
                                            // Container(
                                            //   width: device == ScreenSize.small
                                            //       ? 80.0.wp
                                            //       : 46.0.wp,
                                            //   decoration: BoxDecoration(
                                            //       border: Border.all(
                                            //     width: 1,
                                            //     color: AppColors.cardShadow,
                                            //   )),
                                            //   child: HtmlEditor(
                                            //     controller: model
                                            //         .aboutUsController, //required
                                            //     htmlEditorOptions:
                                            //         HtmlEditorOptions(
                                            //       initialText: model.aboutUs,
                                            //       shouldEnsureVisible: true,
                                            //       hint: "Your text here...",
                                            //     ),
                                            //     htmlToolbarOptions:
                                            //         const HtmlToolbarOptions(
                                            //       toolbarPosition:
                                            //           ToolbarPosition
                                            //               .aboveEditor,
                                            //       toolbarType:
                                            //           ToolbarType.nativeGrid,
                                            //     ),
                                            //     otherOptions:
                                            //         const OtherOptions(
                                            //       height: 400,
                                            //     ),
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 24.0),
                                          child: model.busy(model.buttonBusy)
                                              ? Utils.webLoader()
                                              : SubmitButton(
                                                  onPressed: () {
                                                    model.updateCompanyProfile(
                                                        context);
                                                  },
                                                  width:
                                                      device == ScreenSize.small
                                                          ? 80.0.wp
                                                          : 22.0.wp,
                                                  height: 47,
                                                  isRadius: false,
                                                  isPadZero: true,
                                                  text:
                                                      "Update Company Profile",
                                                ),
                                        ),
                                      ),
                                      if (UserTypeForWeb.wholesaler ==
                                          model.enrollment)
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Divider(
                                              color: AppColors.dividerColor,
                                            ),
                                            100.0.giveHeight,
                                            const Divider(
                                              color: AppColors.dividerColor,
                                            ),
                                            Scrollbar(
                                              controller:
                                                  model.scrollController,
                                              thickness: 10,
                                              child: SingleChildScrollView(
                                                controller:
                                                    model.scrollController,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: SizedBox(
                                                  width:
                                                      device != ScreenSize.wide
                                                          ? null
                                                          : 100.0.wp - 64 - 64,
                                                  child: Table(
                                                    defaultVerticalAlignment:
                                                        TableCellVerticalAlignment
                                                            .middle,
                                                    border: TableBorder.all(
                                                        color: AppColors
                                                            .tableHeaderBody),
                                                    columnWidths: {
                                                      0: const FixedColumnWidth(
                                                          100.0),
                                                      1: device !=
                                                              ScreenSize.wide
                                                          ? const FixedColumnWidth(
                                                              200.0)
                                                          : const FlexColumnWidth(),
                                                      2: device !=
                                                              ScreenSize.wide
                                                          ? const FixedColumnWidth(
                                                              200.0)
                                                          : const FlexColumnWidth(),
                                                    },
                                                    children: [
                                                      TableRow(
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: AppColors
                                                                .tableHeaderColor,
                                                          ),
                                                          children: [
                                                            dataCellHd(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .table_id,
                                                            ),
                                                            dataCellHd(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .table_brand,
                                                            ),
                                                            dataCellHd(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .table_logoUrl,
                                                            ),
                                                          ]),
                                                      for (int i = 0;
                                                          i < 2;
                                                          i++)
                                                        TableRow(
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Utils
                                                                .tableBorder,
                                                            color: AppColors
                                                                .whiteColor,
                                                          ),
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          8.0),
                                                              child: dataCell(
                                                                "${1 + i}",
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          8.0),
                                                              child: dataCell(
                                                                "",
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          8.0),
                                                              child: dataCell(
                                                                "",
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                    ],
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
