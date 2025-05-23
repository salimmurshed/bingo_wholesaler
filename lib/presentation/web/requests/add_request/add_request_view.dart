import 'dart:convert';

import 'package:bingo/const/all_const.dart';
import 'package:bingo/presentation/widgets/text/common_text.dart';
import 'package:bingo/presentation/widgets/text_fields/name_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bingo/const/utils.dart';
import 'package:bingo/const/web_devices.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/secondaryNameAppBar.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/web_app_bar.dart';

import '../../../../const/app_styles/app_box_decoration.dart';
import '../../../../data_models/enums/user_type_for_web.dart';
import '../../../widgets/buttons/submit_button.dart';
import '../../../widgets/dropdowns/custom_searchable_dropdown.dart';
import 'add_request_view_model.dart';

class AddRequestView extends StatelessWidget {
  const AddRequestView({super.key, this.type});
  final String? type;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddRequestViewModel>.reactive(
        viewModelBuilder: () => AddRequestViewModel(),
        onViewModelReady: (AddRequestViewModel model) {
          model.getWholesalerList(type);
        },
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
                      h1: '${type == 'wholesaler_request' ? 'Wholesaler' : 'Fie'}: Create Association Request',
                    ),
                  ),
            body: SingleChildScrollView(
              controller: model.scrollController,
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
                              h1: 'Create Association Request ${type == 'wholesaler_request' ? 'Wholesaler' : 'Fie'}',
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
                                          Expanded(
                                            child: Text(
                                              'Create Association Request ${type == 'wholesaler_request' ? 'Wholesaler' : 'Fie'}',
                                              style: AppTextStyles.headerText,
                                            ),
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
                                                model.goBack(context, type);
                                              },
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .viewAll,
                                            ),
                                          )
                                        ],
                                      ),
                                      const Divider(
                                        color: AppColors.dividerColor,
                                      ),
                                      50.0.giveHeight,
                                      CommonText(type == 'wholesaler_request'
                                          ? 'Select Multiple Wholesalers'
                                          : 'Select Multiple Institutions'),
                                      Container(
                                        decoration: AppBoxDecoration
                                            .borderDecoration
                                            .copyWith(
                                                color: AppColors.whiteColor),
                                        width: device == ScreenSize.small
                                            ? 80.0.wp
                                            : (80.0.wp - 20) / 3,
                                        // height: 70,
                                        child: CustomSearchableDropDown(
                                          initialValue: [],
                                          close: (i) {
                                            model.removeItem(i);
                                          },
                                          dropdownHintText: type ==
                                                  'wholesaler_request'
                                              ? "${AppLocalizations.of(context)!.selectWholeSaler}s"
                                              : AppLocalizations.of(context)!
                                                  .selectFie,
                                          showLabelInMenu: false,
                                          multiSelect: true,
                                          multiSelectTag: true,
                                          primaryColor: AppColors.disableColor,
                                          menuMode: true,
                                          labelStyle:
                                              AppTextStyles.successStyle,
                                          // labelStyle: const TextStyle(
                                          //     color: Colors.blue,
                                          //     fontWeight:
                                          //         FontWeight.bold),
                                          items: jsonDecode(jsonEncode(
                                              model.wholeSalerFieList)),
                                          label: AppLocalizations.of(context)!
                                              .selectWholeSaler,
                                          dropDownMenuItems: jsonDecode(
                                                  jsonEncode(
                                                      model.wholeSalerFieList))
                                              .map((item) {
                                            return '${item['name']}-${item['unique_id']}';
                                          }).toList(),

                                          onChanged: (List value) {
                                            model.putSelectedUserList(value);
                                          },
                                        ),
                                      ),
                                      Utils.errorShow(model.errorMessage),
                                      20.0.giveHeight,
                                      model.busy(model.loader)
                                          ? Utils.loaderBusy()
                                          : SubmitButton(
                                              width: device == ScreenSize.small
                                                  ? 80.0.wp
                                                  : (80.0.wp - 20) / 3,
                                              height: 45.0,
                                              text: "Create Request",
                                              isRadius: false,
                                              onPressed: () {
                                                model.createRequest(
                                                    type, context);
                                              },
                                            )
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
