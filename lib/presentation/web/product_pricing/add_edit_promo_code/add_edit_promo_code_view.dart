import 'package:bingo/const/all_const.dart';
import 'package:bingo/const/app_extensions/strings_extention.dart';
import 'package:bingo/const/app_extensions/widgets_extensions.dart';
import 'package:bingo/presentation/widgets/text_fields/name_text_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bingo/const/utils.dart';
import 'package:bingo/const/web_devices.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/secondaryNameAppBar.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/web_app_bar.dart';

import '../../../../const/special_key.dart';
import '../../../../data_models/enums/user_type_for_web.dart';
import '../../../widgets/buttons/submit_button.dart';
import 'add_edit_promo_code_view_model.dart';

class AddEditPromoCodeView extends StatelessWidget {
  const AddEditPromoCodeView({this.data, super.key});

  final String? data;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddEditPromoCodeViewModel>.reactive(
        viewModelBuilder: () => AddEditPromoCodeViewModel(),
        onViewModelReady: (AddEditPromoCodeViewModel model) {
          if (data != null) {
            model.preFill(context, data!);
          }
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
                      h1: AppLocalizations.of(context)!.addPromo_header,
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
                              h1: AppLocalizations.of(context)!.addPromo_header,
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
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!
                                                .addPromo_body,
                                            style: AppTextStyles.headerText,
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: SubmitButton(
                                              color: AppColors.webButtonColor,
                                              isRadius: false,
                                              height: 40,
                                              width: 80,
                                              onPressed: () {
                                                // Navigator.pop(context);
                                                model.goBack(context);
                                              },
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .addPromo_viewAllButton,
                                            ),
                                          )
                                        ],
                                      ),
                                      const Divider(
                                        color: AppColors.dividerColor,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const SizedBox(),
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
                                      Flex(
                                        direction: device == ScreenSize.small
                                            ? Axis.vertical
                                            : Axis.horizontal,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width:
                                                    device == ScreenSize.small
                                                        ? 80.0.wp
                                                        : 28.0.wp,
                                                child: NameTextField(
                                                    hintText: AppLocalizations
                                                            .of(context)!
                                                        .addPromo_textField_hint,
                                                    hintStyle: AppTextStyles
                                                        .formTitleTextStyle
                                                        .copyWith(
                                                            color:
                                                                AppColors
                                                                    .ashColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                    style: AppTextStyles
                                                        .formFieldTextStyle,
                                                    controller: model
                                                        .promocodeTextEditingController,
                                                    fieldName: AppLocalizations
                                                            .of(context)!
                                                        .addPromo_textField_promoFieldTitle
                                                        .isRequired),
                                              ),
                                              Utils.errorShow(
                                                  model.errorPromoCodeMessage),
                                            ],
                                          ),
                                          if (device != ScreenSize.small)
                                            10.0.giveWidth,
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width:
                                                    device == ScreenSize.small
                                                        ? 80.0.wp
                                                        : 28.0.wp,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    model.dateSelect(
                                                        context, 0);
                                                  },
                                                  child: AbsorbPointer(
                                                    child: NameTextField(
                                                        hintText: (DateFormat(
                                                                    SpecialKeys
                                                                        .dateDDMMYYYY)
                                                                .format(DateTime
                                                                    .now()))
                                                            .toString(),
                                                        hintStyle: AppTextStyles
                                                            .formTitleTextStyle
                                                            .copyWith(
                                                                color: AppColors
                                                                    .ashColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                        style: AppTextStyles
                                                            .formFieldTextStyle,
                                                        controller: model
                                                            .startDateTextEditingController,
                                                        fieldName: "Start Date"
                                                            .isRequired),
                                                  ),
                                                ),
                                              ),
                                              Utils.errorShow(
                                                  model.errorStartDateMessage),
                                            ],
                                          ),
                                          if (device != ScreenSize.small)
                                            10.0.giveWidth,
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width:
                                                    device == ScreenSize.small
                                                        ? 80.0.wp
                                                        : 28.0.wp,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    model.dateSelect(
                                                        context, 1);
                                                  },
                                                  child: AbsorbPointer(
                                                    child: NameTextField(
                                                        hintText: (DateFormat(SpecialKeys.dateDDMMYYYY)
                                                                .format(DateTime
                                                                    .now()))
                                                            .toString(),
                                                        hintStyle: AppTextStyles
                                                            .formTitleTextStyle
                                                            .copyWith(
                                                                color: AppColors
                                                                    .ashColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                        style: AppTextStyles
                                                            .formFieldTextStyle,
                                                        controller: model
                                                            .endDateTextEditingController,
                                                        fieldName: AppLocalizations.of(
                                                                context)!
                                                            .addPromo_textField_endDateFieldTitle
                                                            .isRequired),
                                                  ),
                                                ),
                                              ),
                                              Utils.errorShow(
                                                  model.errorEndDateMessage),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: device == ScreenSize.small
                                                ? 80.0.wp
                                                : (84.0.wp + 20),
                                            child: NameTextField(
                                                hintText: AppLocalizations.of(
                                                        context)!
                                                    .addPromo_textField_descriptionTitle
                                                    .toUpperCamelCase(),
                                                hintStyle: AppTextStyles
                                                    .formTitleTextStyle
                                                    .copyWith(
                                                        color:
                                                            AppColors.ashColor,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                style: AppTextStyles
                                                    .formFieldTextStyle,
                                                controller: model
                                                    .descriptionTextEditingController,
                                                fieldName: AppLocalizations.of(
                                                        context)!
                                                    .description
                                                    .toUpperCamelCase()
                                                    .isRequired),
                                          ),
                                          Utils.errorShow(
                                              model.errorDescriptionMessage),
                                        ],
                                      ),
                                      20.0.giveHeight,
                                      model.isButtonBusy
                                          ? SizedBox(
                                              width: device == ScreenSize.small
                                                  ? 80.0.wp
                                                  : 150,
                                              height: 45,
                                              child: Center(
                                                child: Utils.loaderBusy(),
                                              ),
                                            )
                                          : SubmitButton(
                                              isRadius: false,
                                              text: model.isEdit
                                                  ? AppLocalizations.of(
                                                          context)!
                                                      .addPromo_textField_editButton
                                                  : AppLocalizations.of(
                                                          context)!
                                                      .addPromo_textField_addButton,
                                              onPressed: () {
                                                model.addEditPromoCode(context);
                                              },
                                              width: device == ScreenSize.small
                                                  ? 80.0.wp
                                                  : 150,
                                              height: 45,
                                            ),
                                      // Text(model.body1),
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
