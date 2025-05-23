import 'package:bingo/const/all_const.dart';
import 'package:bingo/const/app_extensions/strings_extention.dart';
import 'package:bingo/presentation/widgets/text_fields/name_text_field.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'package:bingo/const/utils.dart';
import 'package:bingo/const/web_devices.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/secondaryNameAppBar.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/web_app_bar.dart';

import '../../../../../../data_models/enums/user_type_for_web.dart';
import '../../../../../widgets/buttons/submit_button.dart';
import '../../../../../widgets/utils_folder/validation_text.dart';
import 'grace_period_add_edit_view_model.dart';

class GracePeriodAddEditView extends StatelessWidget {
  const GracePeriodAddEditView({super.key, this.data});
  final String? data;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GracePeriodAddEditViewModel>.reactive(
        viewModelBuilder: () => GracePeriodAddEditViewModel(),
        onViewModelReady: (GracePeriodAddEditViewModel model) {
          model.prefill(data);
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
                      h1: 'Add Grace Period Group Type',
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
                              h1: 'Add Grace Period Group Type',
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Grace Period Group Type',
                                            style: AppTextStyles.headerText,
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: SubmitButton(
                                              color: AppColors.bingoGreen,
                                              isRadius: false,
                                              height: 40,
                                              width: 80,
                                              onPressed: () {
                                                // Navigator.pop(context);
                                                model.goBack(context);
                                              },
                                              text: "View all Grace period",
                                            ),
                                          )
                                        ],
                                      ),
                                      const Divider(
                                        color: AppColors.dividerColor,
                                      ),
                                      Flex(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        direction: device == ScreenSize.small
                                            ? Axis.vertical
                                            : Axis.horizontal,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width:
                                                    device == ScreenSize.small
                                                        ? 80.0.wp
                                                        : 30.0.wp,
                                                child: NameTextField(
                                                  controller:
                                                      model.typeIdController,
                                                  fieldName: "Grace Period ID"
                                                      .isRequired,
                                                  hintStyle: AppTextStyles
                                                      .formTitleTextStyle
                                                      .copyWith(
                                                          color: AppColors
                                                              .ashColor,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                ),
                                              ),
                                              if (model.typeIdError.isNotEmpty)
                                                ValidationText(
                                                    model.typeIdError),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width:
                                                    device == ScreenSize.small
                                                        ? 80.0.wp
                                                        : 30.0.wp,
                                                child: NameTextField(
                                                  controller:
                                                      model.nameController,
                                                  fieldName: "Grace Period Name"
                                                      .isRequired,
                                                  hintStyle: AppTextStyles
                                                      .formTitleTextStyle
                                                      .copyWith(
                                                          color: AppColors
                                                              .ashColor,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                ),
                                              ),
                                              if (model.nameError.isNotEmpty)
                                                ValidationText(model.nameError),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width:
                                                    device == ScreenSize.small
                                                        ? 80.0.wp
                                                        : 30.0.wp,
                                                // height: 70,
                                                child: NameTextField(
                                                  controller:
                                                      model.daysController,
                                                  fieldName: "Grace Period Days"
                                                      .isRequired,
                                                  isNumber: true,
                                                  hintStyle: AppTextStyles
                                                      .formTitleTextStyle
                                                      .copyWith(
                                                          color: AppColors
                                                              .ashColor,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                ),
                                              ),
                                              if (model.daysError.isNotEmpty)
                                                ValidationText(model.daysError),
                                            ],
                                          ),
                                        ],
                                      ),
                                      10.0.giveHeight,
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: model
                                                .busy(model.typeIdController)
                                            ? Utils.webLoader()
                                            : SubmitButton(
                                                onPressed: model.update,
                                                isPadZero: true,
                                                width:
                                                    device == ScreenSize.small
                                                        ? 80.0.wp
                                                        : 60,
                                                isRadius: false,
                                                height: 45.0,
                                                color: AppColors.bingoGreen,
                                                text: "Add customer type",
                                              ),
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
