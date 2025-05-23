import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bingo/data_models/enums/user_roles_files.dart';
import 'package:bingo/presentation/features_parts/home_parts/home_tabs/security.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import '../../../data_models/enums/user_type_for_web.dart';
import '../../../services/storage/db.dart';
import '../../../tests.dart';
import '/const/all_const.dart';
import '/const/app_extensions/status.dart';
import '/const/app_extensions/strings_extention.dart';
import '/const/special_key.dart';
import '/presentation/widgets/text_fields/name_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../../const/app_sizes/app_sizes.dart';
import '../../../const/app_styles/app_box_decoration.dart';
import '../../../const/server_status_file/server_status_file.dart';
import '../../../const/utils.dart';
import '../../../data/data_source/bank_account_type.dart';
import '../../../data_models/construction_model/confirmation_model/confirmation_model.dart';
import '../../../data_models/construction_model/date_filter_model/date_filter_model.dart';
import '../../../data_models/construction_model/invoice_model/invoice_model.dart';
import '../../../data_models/enums/data_source.dart';
import '../../../data_models/enums/home_page_bottom_tabs.dart';
import '../../../data_models/models/deposit_recommendation/deposit_recommendation.dart';
import '../../../main.dart';
import '../../widgets/buttons/submit_button.dart';
import '../../widgets/buttons/tab_bar_button.dart';
import '../../widgets/cards/account_balance_card.dart';
import '../../widgets/cards/app_bar_text.dart';
import '../../widgets/cards/dashboard_tiles_card.dart';
import '../../widgets/cards/error_check_image.dart';
import '../../widgets/cards/loader/loader.dart';
import '../../widgets/cards/shadow_card.dart';
import '../../widgets/cards/snack_bar.dart';
import '../../widgets/cards/status_card.dart';
import '../../widgets/cards/status_card_credit_line.dart';
import '../../widgets/cards/status_card_four_part.dart';
import '../../widgets/text/classified_text.dart';
import 'home_screen_view_model.dart';

part "../../features_parts/home_parts/home_tabs/account_balance.dart";

part "../../features_parts/home_parts/home_tabs/dashboard.dart";

part "../../features_parts/home_parts/home_tabs/requests.dart";

part "../../features_parts/home_parts/home_tabs/settings.dart";

part "../../features_parts/home_parts/retailer_parts_home/retailer_confirmation_card_in_dashboard.dart";

part "../../features_parts/home_parts/retailer_parts_home/retailer_dashboard_request_setting_tab_part.dart";

// part "../../features_parts/home_parts/retailer_parts_home/retailer_recommendation_card_in_dashboard.dart";
part "../../features_parts/home_parts/retailer_parts_home/retailer_tabs_in_request_tab.dart";

part "../../features_parts/home_parts/retailer_parts_home/retailer_tabs_in_setting_tab.dart";

part "../../features_parts/home_parts/wholesaler_parts_home/wholesaler_tabs_in_setting_tab.dart";

part "../../features_parts/home_parts/wholesaler_parts_home/wholesaler_dashboard_request_tab_part.dart";

part "../../features_parts/home_parts/wholesaler_parts_home/wholesaler_invoice_part_in_dashboard.dart";

part "../../features_parts/home_parts/wholesaler_parts_home/wholesaler_new_order_part_in_dashboard.dart";

part "../../features_parts/home_parts/wholesaler_parts_home"
    "/wholesaler_tabs_in_request_tab.dart";

class HomeScreenView extends StatelessWidget {
  const HomeScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeScreenViewModel>.reactive(
      viewModelBuilder: () => HomeScreenViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              // IconButton(
              //     onPressed: () {
              //       Navigator.push(
              //           context, MaterialPageRoute(builder: (c) => Testsss()));
              //     },
              //     icon: Icon(Icons.add)),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  onPressed: () {
                    model.readQrScanner(context);

                    // model.readQrScanner(context);
                  },
                  icon: const Icon(Icons.qr_code),
                ),
              ),
              IconButton(
                onPressed: () {
                  String token = prefs.getString(DataBase.fcmToken) ?? "";
                  Clipboard.setData(ClipboardData(text: token));
                },
                icon: Image.asset(AppAsset.searchIcon),
              ),
              const SizedBox(
                width: 15.0,
              ),
            ],
            leading: IconButton(
              onPressed: () {
                scaffoldKey.currentState!.openDrawer();
              },
              icon: Image.asset(AppAsset.moreIcon),
            ),
            title: AppBarText(model.getAppBarTitle()),
            backgroundColor: model.enrollment == UserTypeForWeb.retailer
                ? AppColors.appBarColorRetailer
                : AppColors.appBarColorWholesaler,
          ),
          body: _body(model),
          bottomNavigationBar: DefaultTabController(
            length: model.enrollment == UserTypeForWeb.retailer ? 4 : 2,
            child: model.enrollment == UserTypeForWeb.retailer
                ? RetailerDashboardRequestSettingTabPart(model)
                : WholesalerDashboardRequestTabPart(model),
          ),
        );
      },
    );
  }
}

_body(HomeScreenViewModel model) {
  return SizedBox(
    height: 100.00.hp,
    child: Stack(
      children: [
        // model.connectionStreamApiCall,
        model.homeScreenBottomTabs == HomePageBottomTabs.dashboard
            ? DashBoard(
                model: model,
                isRetailer: model.enrollment == UserTypeForWeb.retailer,
              )
            : model.homeScreenBottomTabs == HomePageBottomTabs.requests
                ? Requests(
                    model: model,
                    isRetailer: model.enrollment == UserTypeForWeb.retailer,
                  )
                : model.homeScreenBottomTabs == HomePageBottomTabs.settings
                    ? Settings(model: model)
                    : AccountBalance(model: model),
      ],
    ),
  );
}

// _retailer(HomeScreenViewModel model) {
//   return SizedBox(
//     height: 100.00.hp,
//     child: Stack(
//       children: [
//         model.homeScreenBottomTabs == HomePageBottomTabs.dashboard //dashboard
//             ? Padding(
//                 padding: AppPaddings.dashboardCardPadding,
//                 child: SizedBox(
//                   width: 100.0.wp,
//                   child: SingleChildScrollView(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         20.0.giveHeight,
//                         Wrap(
//                           runAlignment: WrapAlignment.spaceBetween,
//                           runSpacing: OtherSizes.runSpacing,
//                           spacing: OtherSizes.spacing,
//                           children: [
//                             for (var i = 0;
//                                 i < model.retailerCardsPropertiesList.length;
//                                 i++)
//                               DashboardTilesCard(
//                                 color:
//                                     model.retailerCardsPropertiesList[i].color!,
//                                 icon:
//                                     model.retailerCardsPropertiesList[i].icon!,
//                                 amount: model
//                                     .retailerCardsPropertiesList[i].amount!,
//                                 title:
//                                     model.retailerCardsPropertiesList[i].title!,
//                               ),
//                           ],
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(18.0),
//                           child: Card(
//                             child: Container(
//                               width: 100.0.wp,
//                               padding: const EdgeInsets.all(18.0),
//                               decoration:
//                                   AppBoxDecoration.dashboardCardDecoration,
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     AppLocalizations.of(context)!.dashboardConfirmText,
//                                     style: AppTextStyles.dashboardHeadTitle
//                                         .copyWith(
//                                       fontWeight: AppFontWeighs.semiBold,
//                                     ),
//                                   ),
//                                   for (int i = 0;
//                                       i <
//                                           (model.confirmationData.length < 2
//                                               ? model.confirmationData.length
//                                               : 2);
//                                       i++)
//                                     RetailerConfirmationCardInDashboard(
//                                       model.confirmationData[i],
//                                       function: () {
//                                         model.gotoSalesDetailsScreen(
//                                             model.confirmationData[i]);
//                                       },
//                                     ),
//                                   Text(
//                                     AppLocalizations.of(context)!.dashboardRecommendation,
//                                     style: AppTextStyles.dashboardHeadTitle
//                                         .copyWith(
//                                       fontWeight: AppFontWeighs.semiBold,
//                                     ),
//                                   ),
//                                   Container(
//                                     margin: const EdgeInsets.symmetric(
//                                       vertical: 25.0,
//                                     ),
//                                     decoration: AppBoxDecoration
//                                         .dashboardCardDecoration
//                                         .copyWith(
//                                       borderRadius: AppRadius.s50Padding,
//                                     ),
//                                     width: double.infinity,
//                                     height: 33.0,
//                                     child: Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                         horizontal: 21.0,
//                                       ),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: const [
//                                           Text(
//                                             'Hoy - 25/07/2022',
//                                             style: AppTextStyles
//                                                 .dashboardHeadTitleAsh,
//                                           ),
//                                           Icon(
//                                             Icons.arrow_drop_down_sharp,
//                                             color: AppColors.ashColor,
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                   RetailerRecommandationCardInDashboard(
//                                     model.recommadationData[0],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               )
//             : model.homeScreenBottomTabs ==
//                     HomePageBottomTabs.requests //request
//                 ? Padding(
//                     padding: EdgeInsets.only(bottom: 10.0.hp),
//                     child: SizedBox(
//                       width: 100.0.wp,
//                       child: Stack(
//                         children: [
//                           RetailerTabsInRequestTab(model),
//                           model.requestTabIndex == 0
//                               ? Padding(
//                                   padding: const EdgeInsets.only(top: 72),
//                                   child: SingleChildScrollView(
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       children: [
//                                         Padding(
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 12.0),
//                                           child: SizedBox(
//                                             width: 100.0.wp,
//                                             height: 80.0,
//                                             child: Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.center,
//                                               children: [
//                                                 const SizedBox(),
//                                                 SubmitButton(
//                                                   onPressed:
//                                                       model.gotoAddNewRequest,
//                                                   width: 100.0,
//                                                   text: AppLocalizations.of(context)!.addNew,
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                         if (model
//                                             .associationRequestData.isEmpty)
//                                           const Center(
//                                             child: Text("No Data"),
//                                           ),
//                                         for (int j = 0;
//                                             j <
//                                                 model.associationRequestData
//                                                     .length;
//                                             j++)
//                                           StatusCard(
//                                             onTap: model
//                                                 .gotoAssociationRequestDetailsScreen,
//                                             title: model
//                                                 .associationRequestData[j]
//                                                 .wholesalerName!,
//                                             subTitle: model
//                                                 .associationRequestData[j].id!,
//                                             status: model
//                                                 .associationRequestData[j]
//                                                 .status!,
//                                             bodyFirstKey: AppLocalizations.of(context)!.emailTitle,
//                                             bodyFirstValue: model
//                                                 .associationRequestData[j]
//                                                 .email!,
//                                             bodySecondKey: AppLocalizations.of(context)!.phoneTitle,
//                                             bodySecondValue: model
//                                                 .associationRequestData[j]
//                                                 .phoneNumber!,
//                                           )
//                                       ],
//                                     ),
//                                   ),
//                                 )
//                               : Padding(
//                                   padding: const EdgeInsets.only(top: 72),
//                                   child: SingleChildScrollView(
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       children: [
//                                         Padding(
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 12.0),
//                                           child: SizedBox(
//                                             width: 100.0.wp,
//                                             height: 80.0,
//                                             child: Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.center,
//                                               children: [
//                                                 const SizedBox(),
//                                                 SubmitButton(
//                                                   width: 100.0,
//                                                   text: AppLocalizations.of(context)!.addNew,
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                         for (int j = 0; j < 10; j++)
//                                           StatusCard(
//                                             title: "Mayorista prueba 1",
//                                             subTitle: "00302309495",
//                                             status: "Pending Wholesaler Review",
//                                             bodyFirstKey: "Date "
//                                                 "Requested: ",
//                                             bodyFirstValue:
//                                                 "2022-07-20 03:14:53",
//                                             bodySecondKey: "Amount:",
//                                             bodySecondValue: "RD\$ 1,000.00",
//                                           ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                         ],
//                       ),
//                     ),
//                   )
//                 : model.homeScreenBottomTabs ==
//                         HomePageBottomTabs.settings //setting
//                     ? Padding(
//                         padding: EdgeInsets.only(bottom: 10.0.hp),
//                         child: SizedBox(
//                           width: 100.0.wp,
//                           child: Stack(
//                             children: [
//                               RetailerTabsInSettingTab(model),
//                               model.settingTabIndex == 0
//                                   ? Padding(
//                                       padding: const EdgeInsets.only(top: 72),
//                                       child: SingleChildScrollView(
//                                         child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.center,
//                                           children: [
//                                             Padding(
//                                               padding:
//                                                   const EdgeInsets.symmetric(
//                                                       horizontal: 12.0),
//                                               child: SizedBox(
//                                                 width: 100.0.wp,
//                                                 height: 80.0,
//                                                 child: Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment
//                                                           .spaceBetween,
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.center,
//                                                   children: [
//                                                     const SizedBox(),
//                                                     SubmitButton(
//                                                       width: 100.0,
//                                                       text: AppLocalizations.of(context)!.addNew,
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                             for (int j = 0; j < 10; j++)
//                                               StatusCard(
//                                                 title: "JOHN DOE".toUpperCase(),
//                                                 subTitle: "",
//                                                 status: "Active",
//                                                 bodyFirstKey: "Email",
//                                                 bodyFirstValue:
//                                                     "johndoe@mailnator.com",
//                                                 bodySecondKey: "Role:",
//                                                 bodySecondValue: "Finance",
//                                               ),
//                                           ],
//                                         ),
//                                       ),
//                                     )
//                                   : model.settingTabIndex == 1
//                                       ? Padding(
//                                           padding:
//                                               const EdgeInsets.only(top: 72),
//                                           child: SingleChildScrollView(
//                                             child: Column(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.center,
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.center,
//                                               children: [
//                                                 for (int j = 0; j < 10; j++)
//                                                   StatusCard(
//                                                     title: "Admin",
//                                                     subTitle: "",
//                                                     status: "Active",
//                                                     bodyFirstKey: "Date: ",
//                                                     bodyFirstValue:
//                                                         "2021-07-05 01:50:54",
//                                                     bodySecondKey: "",
//                                                     bodySecondValue: "",
//                                                   ),
//                                               ],
//                                             ),
//                                           ),
//                                         )
//                                       : model.settingTabIndex == 2
//                                           ? Padding(
//                                               padding: const EdgeInsets.only(
//                                                   top: 72),
//                                               child: SingleChildScrollView(
//                                                 child: Column(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.center,
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.center,
//                                                   children: [
//                                                     Padding(
//                                                       padding: const EdgeInsets
//                                                               .symmetric(
//                                                           horizontal: 12.0),
//                                                       child: SizedBox(
//                                                         width: 100.0.wp,
//                                                         height: 80.0,
//                                                         child: Row(
//                                                           mainAxisAlignment:
//                                                               MainAxisAlignment
//                                                                   .spaceBetween,
//                                                           crossAxisAlignment:
//                                                               CrossAxisAlignment
//                                                                   .center,
//                                                           children: [
//                                                             const SizedBox(),
//                                                             SubmitButton(
//                                                               width: 100.0,
//                                                               text: AppLocalizations.of(context)!
//                                                                   .addNew,
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     for (int j = 0;
//                                                         j <
//                                                             model.storeData
//                                                                 .length;
//                                                         j++)
//                                                       StatusCardFourPart(
//                                                         title: model
//                                                             .storeData[j].name!,
//                                                         subTitle: model
//                                                             .storeData[j].city!,
//                                                         status: model
//                                                             .storeData[j]
//                                                             .status!,
//                                                         bodyFirstKey:
//                                                             "Remark: ${model.storeData[j].remarks!}",
//                                                       ),
//                                                     Utils.endOfData()
//                                                   ],
//                                                 ),
//                                               ),
//                                             )
//                                           : Padding(
//                                               padding: const EdgeInsets.only(
//                                                   top: 72),
//                                               child: SingleChildScrollView(
//                                                 child: Column(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.center,
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.center,
//                                                   children: [
//                                                     Padding(
//                                                       padding: const EdgeInsets
//                                                               .symmetric(
//                                                           horizontal: 12.0),
//                                                       child: SizedBox(
//                                                         width: 100.0.wp,
//                                                         height: 80.0,
//                                                         child: Row(
//                                                           mainAxisAlignment:
//                                                               MainAxisAlignment
//                                                                   .spaceBetween,
//                                                           crossAxisAlignment:
//                                                               CrossAxisAlignment
//                                                                   .center,
//                                                           children: [
//                                                             const SizedBox(),
//                                                             SubmitButton(
//                                                               width: 100.0,
//                                                               text: AppLocalizations.of(context)!
//                                                                   .addNew,
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     for (int j = 0; j < 10; j++)
//                                                       StatusCardFourPart(
//                                                         title: "Banco 1",
//                                                         subTitle:
//                                                             "2022-06-05 18:15:28",
//                                                         status: "Active",
//                                                         bodyFirstKey:
//                                                             "Acc Type: Saving",
//                                                         bodyFirstValue:
//                                                             "Currency: DOP",
//                                                         bodySecondKey:
//                                                             "Acc No.: 885585585",
//                                                         bodySecondValue:
//                                                             "IBAN: ",
//                                                       ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                             ],
//                           ),
//                         ),
//                       )
//                     : Padding(
//                         padding: EdgeInsets.only(bottom: 10.0.hp),
//                         child: SizedBox(
//                           width: 100.0.wp,
//                           child: Padding(
//                             padding: const EdgeInsets.only(top: 25.0),
//                             child: SingleChildScrollView(
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   for (int j = 0; j < 10; j++)
//                                     AccountBalanceCard(
//                                       title: "Balance: RD\$ 0"
//                                           ".00",
//                                       subTitleList: const [
//                                         "Account Type: Saving",
//                                         "Acc"
//                                             "ount No.: ",
//                                         "Bank Name: Banco Prueba "
//                                             "1",
//                                         "IBAN: ",
//                                         "Date:2022-06-19 18:52:42",
//                                         "Date/Time Updated: "
//                                             "2022-06-19 18:52:42"
//                                       ],
//                                     )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//         Positioned(
//           bottom: 0.0,
//           child: RetailerDashboardRequestSettingTabPart(model),
//         ),
//       ],
//     ),
//   );
// }

// _wholesaler(HomeScreenViewModel model) {
//   return SizedBox(
//     height: 100.00.hp,
//     child: Stack(
//       children: [
//         model.homeScreenBottomTabs == HomePageBottomTabs.dashboard
//             ? Padding(
//                 padding: EdgeInsets.only(bottom: 10.0.hp),
//                 child: SizedBox(
//                   width: 100.0.wp,
//                   child: SingleChildScrollView(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         20.0.giveHeight,
//                         Wrap(
//                           runAlignment: WrapAlignment.spaceBetween,
//                           runSpacing: OtherSizes.runSpacing,
//                           spacing: OtherSizes.spacing,
//                           children: [
//                             for (var i = 0;
//                                 i < model.wholesalerCardsPropertiesList.length;
//                                 i++)
//                               DashboardTilesCard(
//                                 color: model
//                                     .wholesalerCardsPropertiesList[i].color!,
//                                 icon: model
//                                     .wholesalerCardsPropertiesList[i].icon!,
//                                 amount: model
//                                     .wholesalerCardsPropertiesList[i].amount!,
//                                 title: model
//                                     .wholesalerCardsPropertiesList[i].title!,
//                               ),
//                           ],
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(18.0),
//                           child: Card(
//                             child: Container(
//                               width: 100.0.wp,
//                               padding: const EdgeInsets.all(18.0),
//                               decoration:
//                                   AppBoxDecoration.dashboardCardDecoration,
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     AppLocalizations.of(context)!.invoices,
//                                     style: AppTextStyles.dashboardHeadTitle
//                                         .copyWith(
//                                       fontWeight: AppFontWeighs.semiBold,
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     height: 25.0,
//                                   ),
//                                   for (int i = 0;
//                                       i <
//                                           (model.invoiceData.length < 4
//                                               ? model.invoiceData.length
//                                               : 4);
//                                       i++)
//                                     WholesalerInvoicePartInDashboard(
//                                         model.invoiceData[i]),
//                                   Text(
//                                     AppLocalizations.of(context)!.newOrderRequest,
//                                     style: AppTextStyles.dashboardHeadTitle
//                                         .copyWith(
//                                       fontWeight: AppFontWeighs.semiBold,
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     height: 25.0,
//                                   ),
//                                   for (int i = 0; i < 4; i++)
//                                     const WholesalerNewOrderPartInDashboard(),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               )
//             : Padding(
//                 padding: EdgeInsets.only(bottom: 10.0.hp),
//                 child: SizedBox(
//                   width: 100.0.wp,
//                   child: Stack(
//                     children: [
//                       RetailerTabsInRequestTab(model),
//                       model.requestTabIndex == 0
//                           ? Padding(
//                               padding: const EdgeInsets.only(
//                                 top: 72,
//                               ),
//                               child: SingleChildScrollView(
//                                 child: SizedBox(
//                                     width: 100.0.wp,
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       children: [
//                                         if (model
//                                             .wholesalerAssociationRequest
//                                             .isEmpty)
//                                           const Center(
//                                             child: Text("No Data"),
//                                           ),
//                                         for (int j = 0;
//                                             j <
//                                                 model
//                                                     .wholesalerAssociationRequest
//                                                     .length;
//                                             j++)
//                                           StatusCard(
//                                             onTap: model
//                                                 .gotoAssociationRequestDetailsScreen,
//                                             title: model
//                                                 .wholesalerAssociationRequest[
//                                                     j]
//                                                 .retailerName!,
//                                             subTitle: model
//                                                 .wholesalerAssociationRequest[
//                                                     j]
//                                                 .id!,
//                                             status: model
//                                                 .wholesalerAssociationRequest[
//                                                     j]
//                                                 .status!,
//                                             bodyFirstKey: AppLocalizations.of(context)!.emailTitle,
//                                             bodyFirstValue: model
//                                                 .wholesalerAssociationRequest[
//                                                     j]
//                                                 .email!,
//                                             bodySecondKey: AppLocalizations.of(context)!.phoneTitle,
//                                             bodySecondValue: model
//                                                 .wholesalerAssociationRequest[
//                                                     j]
//                                                 .phoneNumber!,
//                                           )
//                                       ],
//                                     )),
//                               ),
//                             )
//                           : Padding(
//                               padding: const EdgeInsets.only(top: 72),
//                               child: SingleChildScrollView(
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 12.0),
//                                       child: SizedBox(
//                                         width: 100.0.wp,
//                                         height: 80.0,
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.center,
//                                           children: [
//                                             const SizedBox(),
//                                             SubmitButton(
//                                               width: 100.0,
//                                               text: AppLocalizations.of(context)!.addNew,
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     for (int j = 0; j < 10; j++)
//                                       StatusCard(
//                                         title: "Mayorista prueba 1",
//                                         subTitle: "00302309495",
//                                         status: "Pending Wholesaler Review",
//                                         bodyFirstKey: "Date "
//                                             "Requested: ",
//                                         bodyFirstValue: "2022-07-20 03:14:53",
//                                         bodySecondKey: "Amount:",
//                                         bodySecondValue: "RD\$ 1,000.00",
//                                       ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                     ],
//                   ),
//                 ),
//               ),
//         Positioned(
//           bottom: 0.0,
//           child: WholesalerDashboardRequestTabPart(model),
//         ),
//       ],
//     ),
//   );
// }
