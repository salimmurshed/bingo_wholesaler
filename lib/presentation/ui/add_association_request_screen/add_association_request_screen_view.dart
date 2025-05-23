import '../../../data_models/enums/user_type_for_web.dart';
import '../../widgets/checked_box.dart';
import '/const/all_const.dart';
import '/const/app_styles/app_box_decoration.dart';
import '/const/utils.dart';
import '/presentation/widgets/buttons/submit_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stacked/stacked.dart';

import '../../../const/app_sizes/app_sizes.dart';
import '../../../data_models/enums/data_source.dart';
import '../../widgets/buttons/cancel_button.dart';
import '../../widgets/cards/app_bar_text.dart';
import 'add_association_request_screen_view_model.dart';

class AddAssociationRequestView extends StatelessWidget {
  const AddAssociationRequestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddAssociationRequestViewModel>.reactive(
      onViewModelReady: (AddAssociationRequestViewModel model) {
        model.setDetails(ModalRoute.of(context)!.settings.arguments
            as RetailerTypeAssociationRequest);
      },
      viewModelBuilder: () => AddAssociationRequestViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: model.enrollment == UserTypeForWeb.retailer
                ? AppColors.appBarColorRetailer
                : AppColors.appBarColorWholesaler,
            title: AppBarText(
              AppLocalizations.of(context)!.addRequest,
            ),
          ),
          body: DefaultTabController(
            initialIndex: model.wholesalerOrFia,
            length: 2,
            child: Column(
              children: [
                Padding(
                  padding: AppPaddings.associationRequestTabBarWidgetV,
                  child: Container(
                    padding: AppPaddings.zero,
                    margin: AppPaddings.zero,
                    width: 320,
                    decoration: AppBoxDecoration.tabBarShadowDecoration,
                    child: TabBar(
                      dividerColor: AppColors.transparent,
                      indicatorWeight: 0.1,
                      indicatorColor: AppColors.transparent,
                      padding: AppPaddings.zero,
                      labelPadding: AppPaddings.zero,
                      isScrollable: false,
                      indicatorPadding: AppPaddings.zero,
                      onTap: (int i) {
                        model.changeTabBar(i);
                      },
                      tabs: [
                        tabBarThisClass(
                          AppLocalizations.of(context)!
                              .wholesaler
                              .toUpperCase(),
                          model.wholesalerOrFia,
                          0,
                        ),
                        tabBarThisClass(
                          AppLocalizations.of(context)!
                              .financialInstitution
                              .toUpperCase(),
                          model.wholesalerOrFia,
                          1,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    dragStartBehavior: DragStartBehavior.down,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      wholesalerTab(model, context),
                      financialInstitution(model, context),
                    ],
                  ),
                ),
                15.0.giveHeight,
                Padding(
                  padding: AppPaddings.bodyHorizontal23,
                  child: model.isAddRequestBusy
                      ? const CircularProgressIndicator(
                          color: AppColors.loader1,
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CancelButton(
                              onPressed: model.cancelButtonPressed,
                              active: true,
                              text: AppLocalizations.of(context)!
                                  .cancelButton
                                  .toUpperCase(),
                              height: 45,
                              width: 38.0.wp,
                            ),
                            SubmitButton(
                              onPressed: model.wholesalerOrFia == 0
                                  ? model.sendWholesalerRequest
                                  : model.sendFiaRequest,
                              active: true,
                              text: AppLocalizations.of(context)!
                                  .submitButton
                                  .toUpperCase(),
                              height: 45,
                              width: 38.0.wp,
                            ),
                          ],
                        ),
                ),
                40.0.giveHeight,
              ],
            ),
          ),
        );
      },
    );
  }

  financialInstitution(AddAssociationRequestViewModel model, context) {
    return SingleChildScrollView(
      child: Padding(
        padding: AppPaddings.bodyHorizontal23,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: AppPaddings.bodyHorizontal23,
              child: Text(
                AppLocalizations.of(context)!.selectMultipleFia,
                style: AppTextStyles.addRequestHeader,
              ),
            ),
            for (var i = 0; i < model.fiaList.length; i++)
              InkWell(
                onTap: () {
                  model.addRemoveFia(i);
                },
                child: Card(
                  elevation: 2,
                  child: Padding(
                    padding: AppPaddings.associationRequestTabBarViewListCard,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CheckedBox(
                          check: model.selectedFia
                              .contains(model.fiaList[i].uniqueId),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 60.0.wp,
                              child: Text(
                                model.fiaList[i].name!,
                                style: AppTextStyles.addRequestHeader,
                              ),
                            ),
                            SizedBox(
                              width: 60.0.wp,
                              child: Text(
                                model.fiaList[i].uniqueId!,
                                style: AppTextStyles.addRequestSubTitle,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            if (model.fiaList.isNotEmpty) 20.0.giveHeight,
            // if (model.fiaList.isNotEmpty) Utils.endOfData(),
            20.0.giveHeight,
          ],
        ),
      ),
    );
  }

  wholesalerTab(AddAssociationRequestViewModel model, context) {
    return SingleChildScrollView(
      child: Padding(
        padding: AppPaddings.bodyHorizontal23,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: AppPaddings.bodyHorizontal23,
              child: Text(
                AppLocalizations.of(context)!.selectMultipleWholesaler,
                style: AppTextStyles.addRequestHeader,
              ),
            ),
            Column(
              children: [
                for (var i = 0; i < model.wholeSaleList.length; i++)
                  InkWell(
                    onTap: () {
                      model.addRemoveWholesaler(i);
                    },
                    child: Card(
                      elevation: 2,
                      child: Padding(
                        padding:
                            AppPaddings.associationRequestTabBarViewListCard,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CheckedBox(
                              check: model.selectedWholeSaler
                                  .contains(model.wholeSaleList[i].uniqueId),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 60.0.wp,
                                  child: Text(
                                    model.wholeSaleList[i].name!,
                                    style: AppTextStyles.addRequestHeader,
                                  ),
                                ),
                                SizedBox(
                                  width: 60.0.wp,
                                  child: Text(
                                    model.wholeSaleList[i].uniqueId!,
                                    style: AppTextStyles.addRequestSubTitle,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                20.0.giveHeight,
                // if (model.wholeSaleList.isNotEmpty) Utils.endOfData(),
              ],
            ),
            20.0.giveHeight,
          ],
        ),
      ),
    );
  }

  tabBarThisClass(String text, int selectedIndex, int widgetNumber) {
    return Container(
      width: 160.0,
      height: 40.0,
      padding: AppPaddings.zero,
      margin: AppPaddings.zero,
      decoration: BoxDecoration(
        borderRadius: selectedIndex == 0
            ? AppRadius.associationReqtabL
            : AppRadius.associationReqtabR,
        color: selectedIndex == widgetNumber
            ? AppColors.appBarColor
            : AppColors.transparent,
      ),
      child: Center(
        child: Text(
          text,
          style: selectedIndex == widgetNumber
              ? AppTextStyles.addRequestTabBar
              : AppTextStyles.addRequestTabBar
                  .copyWith(color: AppColors.blackColor),
        ),
      ),
    );
  }
}
