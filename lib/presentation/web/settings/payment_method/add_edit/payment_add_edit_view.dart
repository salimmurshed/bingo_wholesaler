import 'package:bingo/const/all_const.dart';
import 'package:bingo/presentation/widgets/buttons/submit_button.dart';
import 'package:flutter/cupertino.dart';
import '../../../../../data_models/enums/user_type_for_web.dart';
import 'payment_add_edit_view_model.dart';
import 'package:bingo/presentation/widgets/text_fields/name_text_field.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bingo/const/utils.dart';
import 'package:bingo/const/web_devices.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/secondaryNameAppBar.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/web_app_bar.dart';

class PaymentAddEditView extends StatelessWidget {
  const PaymentAddEditView({super.key, this.id, this.title});
  final String? id;
  final String? title;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PaymentAddEditViewModel>.reactive(
        viewModelBuilder: () => PaymentAddEditViewModel(),
        onViewModelReady: (PaymentAddEditViewModel model) {
          model.setData(id, title);
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
                      h1: model.isEdit
                          ? 'Edit Order Payment Method'
                          : 'Add Order Payment Method',
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
                              h1: model.isEdit
                                  ? 'Edit Order Payment Method'
                                  : 'Add Order Payment Method',
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
                                      Text(
                                        model.isEdit
                                            ? 'Edit Order Payment Method'
                                            : 'Add Order Payment Method',
                                        style: AppTextStyles.headerText,
                                      ),
                                      20.0.giveHeight,
                                      SizedBox(
                                        width: device == ScreenSize.small
                                            ? 80.0.wp
                                            : 30.0.wp,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            NameTextField(
                                              hintStyle: AppTextStyles
                                                  .formTitleTextStyleNormal,
                                              controller:
                                                  model.paymentMethodController,
                                            ),
                                            Utils.errorShow(model.errorMessage),
                                            20.0.giveHeight,
                                            model.busy(model
                                                    .paymentMethodController)
                                                ? SizedBox(
                                                    width: device ==
                                                            ScreenSize.small
                                                        ? 80.0.wp
                                                        : 30.0.wp,
                                                    child: Center(
                                                      child: Utils.loaderBusy(),
                                                    ),
                                                  )
                                                : SubmitButton(
                                                    onPressed:
                                                        model.editPaymentMethod,
                                                    height: 45.0,
                                                    isRadius: false,
                                                    width: device ==
                                                            ScreenSize.small
                                                        ? 80.0.wp
                                                        : 30.0.wp,
                                                    text: model.isEdit
                                                        ? "Update Payment Method"
                                                        : "Add Payment Method",
                                                  )
                                          ],
                                        ),
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
