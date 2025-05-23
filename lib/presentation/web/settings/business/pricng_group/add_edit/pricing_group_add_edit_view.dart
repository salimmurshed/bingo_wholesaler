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
import 'pricing_group_add_edit_view_model.dart';

class AddEditPricingGroupView extends StatelessWidget {
  const AddEditPricingGroupView({super.key, this.data});
  final String? data;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddEditPricingGroupViewModel>.reactive(
        viewModelBuilder: () => AddEditPricingGroupViewModel(),
        onViewModelReady: (AddEditPricingGroupViewModel model) {
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
                      h1: 'Add Pricing Group Type',
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
                              h1: 'Add Pricing Group Type',
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
                                            'Pricing Group Type',
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
                                              text: "View all pricing groups",
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
                                                // height: 70,
                                                child: NameTextField(
                                                  controller:
                                                      model.typeIdController,
                                                  fieldName: "Pricing Group ID"
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
                                                // height: 70,
                                                child: NameTextField(
                                                  controller:
                                                      model.typeNameController,
                                                  fieldName:
                                                      "Pricing Group Name"
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
                                              if (model
                                                  .typeNameError.isNotEmpty)
                                                ValidationText(
                                                    model.typeNameError),
                                            ],
                                          ),
                                          SizedBox(
                                            width: device == ScreenSize.small
                                                ? 80.0.wp
                                                : 30.0.wp,
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
                                                        : 144,
                                                isRadius: false,
                                                height: 45.0,
                                                color: AppColors.bingoGreen,
                                                text: "Add Priceing Group",
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
