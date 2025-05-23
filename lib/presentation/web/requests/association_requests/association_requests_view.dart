import 'package:bingo/app/web_route.dart';
import 'package:bingo/const/all_const.dart';
import 'package:bingo/const/app_extensions/status.dart';
import 'package:bingo/const/app_extensions/widgets_extensions.dart';
import 'package:bingo/presentation/widgets/buttons/submit_button.dart';
import 'package:bingo/presentation/widgets/text_fields/name_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bingo/const/utils.dart';
import 'package:bingo/const/web_devices.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/secondaryNameAppBar.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/web_app_bar.dart';

import '../../../../const/app_sizes/app_sizes.dart';
import '../../../../data_models/enums/status_name.dart';
import '../../../../data_models/enums/user_type_for_web.dart';
import '../../../widgets/web_widgets/app_bars/nav_button.dart';
import '../../../widgets/web_widgets/body/table.dart';
import '../../../widgets/web_widgets/with_tab_website_base_body.dart';
import 'association_requests_view_model.dart';

class AssociationRequestView extends StatelessWidget {
  const AssociationRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AssociationRequestViewModel>.reactive(
        viewModelBuilder: () => AssociationRequestViewModel(),
        onViewModelReady: (AssociationRequestViewModel model) {
          model.callApi(context);
        },
        builder: (context, model, child) {
          return Scaffold(
            appBar: device == ScreenSize.wide
                ? null
                : AppBar(
                    backgroundColor: model.enrollment == UserTypeForWeb.retailer
                        ? AppColors.bingoGreen
                        : AppColors.appBarColorWholesaler,
                    title: Row(
                      children: [
                        Expanded(
                          child: SecondaryNameAppBar(
                            h1: model.enrollment == UserTypeForWeb.wholesaler
                                ? "View All Association Request"
                                : ModalRoute.of(context)!.settings.name ==
                                        "wholesaler_request"
                                    ? "View All Wholesaler Request"
                                    : "View All Institution Request",
                          ),
                        ),
                        if (model.enrollment == UserTypeForWeb.retailer)
                          SubmitButton(
                            color: AppColors.bingoGreen,
                            // color: AppColors.bingoGreen,
                            isRadius: false,
                            height: 45,
                            width: 80,
                            onPressed: () {
                              // Navigator.pop(context);
                              model.addNew(context);
                            },
                            text: AppLocalizations.of(context)!.addNew,
                          )
                      ],
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
                            Row(
                              children: [
                                SecondaryNameAppBar(
                                  h1: model.enrollment ==
                                          UserTypeForWeb.wholesaler
                                      ? "View All Association Request"
                                      : ModalRoute.of(context)!.settings.name ==
                                              "wholesaler_request"
                                          ? "View All Wholesaler Request"
                                          : "View All Institution Request",
                                ),
                                if (model.enrollment == UserTypeForWeb.retailer)
                                  SubmitButton(
                                    color: AppColors.bingoGreen,
                                    // color: AppColors.bingoGreen,
                                    isRadius: false,
                                    height: 45,
                                    width: 80,
                                    onPressed: () {
                                      // Navigator.pop(context);
                                      model.addNew(context);
                                    },
                                    text: AppLocalizations.of(context)!.addNew,
                                  )
                              ],
                            ),
                          WithTabWebsiteBaseBody(
                            body: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                model.isBusy
                                    ? Utils.bigLoader()
                                    : Scrollbar(
                                        controller: model.scrollController,
                                        thickness: 10,
                                        child: SingleChildScrollView(
                                          controller: model.scrollController,
                                          scrollDirection: Axis.horizontal,
                                          child: SizedBox(
                                            width: device != ScreenSize.wide
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
                                                0: const FixedColumnWidth(70.0),
                                                1: device != ScreenSize.wide
                                                    ? const FixedColumnWidth(
                                                        120.0)
                                                    : const FlexColumnWidth(),
                                                2: const FixedColumnWidth(
                                                    200.0),
                                                3: const FixedColumnWidth(
                                                    200.0),
                                                4: device != ScreenSize.wide
                                                    ? const FixedColumnWidth(
                                                        150.0)
                                                    : const FlexColumnWidth(),
                                                5: const FixedColumnWidth(
                                                    200.0),
                                                6: const FixedColumnWidth(
                                                    150.0),
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
                                                              .table_no),
                                                      dataCellHd(model
                                                                  .enrollment ==
                                                              UserTypeForWeb
                                                                  .wholesaler
                                                          ? AppLocalizations.of(
                                                                  context)!
                                                              .table_retailerName
                                                          : ModalRoute.of(context)!
                                                                      .settings
                                                                      .name ==
                                                                  "wholesaler_request"
                                                              ? AppLocalizations
                                                                      .of(
                                                                          context)!
                                                                  .table_wholesalerName
                                                              : AppLocalizations
                                                                      .of(context)!
                                                                  .table_fieName),
                                                      dataCellHd(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .table_phoneNo),
                                                      dataCellHd(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .table_id),
                                                      dataCellHd(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .table_email),
                                                      dataCellHd(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .table_status),
                                                      dataCellHd(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .table_action),
                                                    ]),
                                                ////wholesaler
                                                for (int i = 0;
                                                    i <
                                                        model
                                                            .searchedWholesalerAssociationRequest
                                                            .length;
                                                    i++)
                                                  TableRow(
                                                    decoration: BoxDecoration(
                                                      border: Utils.tableBorder,
                                                      color:
                                                          AppColors.whiteColor,
                                                    ),
                                                    children: [
                                                      dataCell(
                                                        "${1 + i}",
                                                        isCenter: true,
                                                      ),
                                                      dataCell(
                                                        model
                                                            .searchedWholesalerAssociationRequest[
                                                                i]
                                                            .retailerName!,
                                                        isCenter: false,
                                                      ),
                                                      dataCell(
                                                        model
                                                            .searchedWholesalerAssociationRequest[
                                                                i]
                                                            .phoneNumber!,
                                                        isCenter: false,
                                                      ),
                                                      dataCell(
                                                        model
                                                            .searchedWholesalerAssociationRequest[
                                                                i]
                                                            .id!,
                                                        isCenter: false,
                                                      ),
                                                      dataCell(
                                                        model
                                                            .searchedWholesalerAssociationRequest[
                                                                i]
                                                            .email!,
                                                        isCenter: false,
                                                      ),
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 20),
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 3),
                                                        child: Center(
                                                          child: statusNamesEnumFromServer(model
                                                                      .searchedWholesalerAssociationRequest[
                                                                          i]
                                                                      .status ??
                                                                  "0")
                                                              .toStatus(
                                                                  textStyle: AppTextStyles
                                                                      .statusCardStatus
                                                                      .copyWith(
                                                                          fontSize:
                                                                              AppFontSize.s14)),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 30),
                                                        child: FittedBox(
                                                          // width: 80,
                                                          child: Material(
                                                            color: Colors.white,
                                                            child: PopupMenuButton<
                                                                    int>(
                                                                color: Colors
                                                                    .white,
                                                                splashRadius:
                                                                    20.0,
                                                                offset:
                                                                    const Offset(
                                                                        0, 40),
                                                                onSelected:
                                                                    (int v) {
                                                                  model.action(
                                                                      context,
                                                                      v,
                                                                      model
                                                                          .searchedWholesalerAssociationRequest[
                                                                              i]
                                                                          .associationUniqueId!,
                                                                      i,
                                                                      ModalRoute.of(
                                                                              context)!
                                                                          .settings
                                                                          .name);
                                                                },
                                                                elevation: 8.0,
                                                                tooltip: "",
                                                                itemBuilder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return [
                                                                    PopupMenuItem<
                                                                            int>(
                                                                        height:
                                                                            30,
                                                                        value:
                                                                            0,
                                                                        child: Text(
                                                                            AppLocalizations.of(context)!
                                                                                .webActionButtons_viewRequest,
                                                                            style:
                                                                                const TextStyle(
                                                                              fontSize: 12,
                                                                              color: AppColors.ashColor,
                                                                            ))),
                                                                    if (model.currentStatus(model
                                                                            .searchedWholesalerAssociationRequest[
                                                                                i]
                                                                            .status!) ==
                                                                        StatusNames
                                                                            .accepted)
                                                                      PopupMenuItem<
                                                                              int>(
                                                                          height:
                                                                              30,
                                                                          value:
                                                                              1,
                                                                          child: Text(
                                                                              AppLocalizations.of(context)!.activationCode.toUpperCamelCaseSpaced(),
                                                                              style: const TextStyle(
                                                                                fontSize: 12,
                                                                                color: AppColors.ashColor,
                                                                              ))),
                                                                    if (model.currentStatus(model
                                                                            .searchedWholesalerAssociationRequest[
                                                                                i]
                                                                            .status!) ==
                                                                        StatusNames
                                                                            .verified)
                                                                      PopupMenuItem<
                                                                              int>(
                                                                          height:
                                                                              30,
                                                                          value:
                                                                              1,
                                                                          child: Text(
                                                                              AppLocalizations.of(context)!.activationCode.toUpperCamelCaseSpaced(),
                                                                              style: const TextStyle(
                                                                                fontSize: 12,
                                                                                color: AppColors.ashColor,
                                                                              ))),
                                                                    if (model.currentStatus(model
                                                                            .searchedWholesalerAssociationRequest[
                                                                                i]
                                                                            .status!) ==
                                                                        StatusNames
                                                                            .pending)
                                                                      PopupMenuItem<
                                                                              int>(
                                                                          height:
                                                                              30,
                                                                          value:
                                                                              1,
                                                                          child: Text(
                                                                              AppLocalizations.of(context)!.accept,
                                                                              style: const TextStyle(
                                                                                fontSize: 12,
                                                                                color: AppColors.ashColor,
                                                                              ))),
                                                                    if (model.currentStatus(model
                                                                            .searchedWholesalerAssociationRequest[
                                                                                i]
                                                                            .status!) ==
                                                                        StatusNames
                                                                            .completed)
                                                                      PopupMenuItem<
                                                                          int>(
                                                                        height:
                                                                            30,
                                                                        value:
                                                                            1,
                                                                        child:
                                                                            Text(
                                                                          AppLocalizations.of(context)!
                                                                              .approve,
                                                                          style:
                                                                              const TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            color:
                                                                                AppColors.ashColor,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    if (model
                                                                            .searchedWholesalerAssociationRequest[
                                                                                i]
                                                                            .status!
                                                                            .toLowerCase() !=
                                                                        describeEnum(StatusNames.rejected)
                                                                            .toLowerCase())
                                                                      PopupMenuItem<
                                                                          int>(
                                                                        height:
                                                                            30,
                                                                        value:
                                                                            2,
                                                                        child:
                                                                            Text(
                                                                          AppLocalizations.of(context)!
                                                                              .webActionButtons_reject,
                                                                          style:
                                                                              const TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            color:
                                                                                AppColors.ashColor,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                  ];
                                                                },
                                                                child: Card(
                                                                  color: AppColors
                                                                      .contextMenuTwo,
                                                                  elevation: 2,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(3),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            10.0,
                                                                        vertical:
                                                                            2.0),
                                                                    child: Row(
                                                                      children: [
                                                                        Text(
                                                                          AppLocalizations.of(context)!
                                                                              .actions,
                                                                          style:
                                                                              const TextStyle(color: AppColors.whiteColor),
                                                                        ),
                                                                        const Icon(
                                                                            Icons
                                                                                .keyboard_arrow_down_sharp,
                                                                            color:
                                                                                AppColors.whiteColor)
                                                                      ],
                                                                    ),
                                                                  ),
                                                                )),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ////retailer
                                                for (int i = 0;
                                                    i <
                                                        model
                                                            .searchedRetailerAssociationRequest
                                                            .length;
                                                    i++)
                                                  TableRow(
                                                    decoration: BoxDecoration(
                                                      border: Utils.tableBorder,
                                                      color:
                                                          AppColors.whiteColor,
                                                    ),
                                                    children: [
                                                      dataCell(
                                                        "${1 + i}",
                                                        isCenter: true,
                                                      ),
                                                      dataCell(
                                                        ModalRoute.of(context)!
                                                                    .settings
                                                                    .name ==
                                                                "wholesaler_request"
                                                            ? model
                                                                .searchedRetailerAssociationRequest[
                                                                    i]
                                                                .wholesalerName!
                                                            : model
                                                                .searchedRetailerAssociationRequest[
                                                                    i]
                                                                .fieName!,
                                                        isCenter: false,
                                                      ),
                                                      dataCell(
                                                        model
                                                            .searchedRetailerAssociationRequest[
                                                                i]
                                                            .phoneNumber!,
                                                        isCenter: false,
                                                      ),
                                                      dataCell(
                                                        model
                                                            .searchedRetailerAssociationRequest[
                                                                i]
                                                            .id!,
                                                        isCenter: false,
                                                      ),
                                                      dataCell(
                                                        model
                                                            .searchedRetailerAssociationRequest[
                                                                i]
                                                            .email!,
                                                        isCenter: false,
                                                      ),
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 20),
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 3),
                                                        child: Center(
                                                          child: statusNamesEnumFromServer(model
                                                                      .searchedRetailerAssociationRequest[
                                                                          i]
                                                                      .status ??
                                                                  "0")
                                                              .toStatus(
                                                                  textStyle: AppTextStyles
                                                                      .statusCardStatus
                                                                      .copyWith(
                                                                          fontSize:
                                                                              AppFontSize.s14)),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 30),
                                                        child: FittedBox(
                                                          // width: 80,
                                                          child: Material(
                                                            color: Colors.white,
                                                            child: PopupMenuButton<
                                                                    int>(
                                                                color: Colors
                                                                    .white,
                                                                splashRadius:
                                                                    20.0,
                                                                offset:
                                                                    const Offset(
                                                                        0, 40),
                                                                onSelected:
                                                                    (int v) {
                                                                  model.action(
                                                                      context,
                                                                      v,
                                                                      ModalRoute.of(context)!.settings.name ==
                                                                              "wholesaler_request"
                                                                          ? model
                                                                              .searchedRetailerAssociationRequest[
                                                                                  i]
                                                                              .associationUniqueId!
                                                                          : model
                                                                              .searchedRetailerAssociationRequest[
                                                                                  i]
                                                                              .uniqueId!,
                                                                      i,
                                                                      ModalRoute.of(
                                                                              context)!
                                                                          .settings
                                                                          .name);
                                                                },
                                                                elevation: 8.0,
                                                                tooltip: "",
                                                                itemBuilder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return [
                                                                    PopupMenuItem<
                                                                        int>(
                                                                      height:
                                                                          30,
                                                                      value: 0,
                                                                      child:
                                                                          Text(
                                                                        AppLocalizations.of(context)!
                                                                            .webActionButtons_viewRequest,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          color:
                                                                              AppColors.ashColor,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    if (model.currentStatus(model
                                                                            .searchedRetailerAssociationRequest[
                                                                                i]
                                                                            .status!) ==
                                                                        StatusNames
                                                                            .inProcess)
                                                                      PopupMenuItem<
                                                                          int>(
                                                                        height:
                                                                            30,
                                                                        value:
                                                                            1,
                                                                        child:
                                                                            Text(
                                                                          AppLocalizations.of(context)!
                                                                              .accept
                                                                              .toUpperCamelCaseSpaced(),
                                                                          style:
                                                                              const TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            color:
                                                                                AppColors.ashColor,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    if (model.currentStatus(model
                                                                            .searchedRetailerAssociationRequest[
                                                                                i]
                                                                            .status!) ==
                                                                        StatusNames
                                                                            .verified)
                                                                      PopupMenuItem<
                                                                          int>(
                                                                        height:
                                                                            30,
                                                                        value:
                                                                            1,
                                                                        child:
                                                                            Text(
                                                                          AppLocalizations.of(context)!
                                                                              .addActivationCode
                                                                              .toUpperCamelCaseSpaced(),
                                                                          style:
                                                                              const TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            color:
                                                                                AppColors.ashColor,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    if (model.currentStatus(model.searchedRetailerAssociationRequest[i].status!) == StatusNames.inProcess ||
                                                                        model.currentStatus(model.searchedRetailerAssociationRequest[i].status!) ==
                                                                            StatusNames
                                                                                .pending ||
                                                                        model.currentStatus(model.searchedRetailerAssociationRequest[i].status!) ==
                                                                            StatusNames
                                                                                .accepted ||
                                                                        model.currentStatus(model.searchedRetailerAssociationRequest[i].status!) ==
                                                                            StatusNames
                                                                                .verified)
                                                                      PopupMenuItem<
                                                                          int>(
                                                                        height:
                                                                            30,
                                                                        value:
                                                                            2,
                                                                        child:
                                                                            Text(
                                                                          AppLocalizations.of(context)!
                                                                              .reject
                                                                              .toUpperCamelCaseSpaced(),
                                                                          style:
                                                                              const TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            color:
                                                                                AppColors.ashColor,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                  ];
                                                                },
                                                                child: Card(
                                                                  color: AppColors
                                                                      .contextMenuTwo,
                                                                  elevation: 2,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(3),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            10.0,
                                                                        vertical:
                                                                            2.0),
                                                                    child: Row(
                                                                      children: [
                                                                        Text(
                                                                          AppLocalizations.of(context)!
                                                                              .actions,
                                                                          style:
                                                                              const TextStyle(color: AppColors.whiteColor),
                                                                        ),
                                                                        const Icon(
                                                                            Icons
                                                                                .keyboard_arrow_down_sharp,
                                                                            color:
                                                                                AppColors.whiteColor)
                                                                      ],
                                                                    ),
                                                                  ),
                                                                )),
                                                          ),
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
                            ),
                            child: navBar(context, model),
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

  Widget navBar(BuildContext context, AssociationRequestViewModel model) {
    return Flex(
      direction: device == ScreenSize.wide ? Axis.horizontal : Axis.vertical,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              NavButton(
                isBottom: Routes.wholesalerRequest ==
                        Utils.narrateFunction(
                            ModalRoute.of(context)!.settings.name!) ||
                    Routes.retailerRequest ==
                        Utils.narrateFunction(
                            ModalRoute.of(context)!.settings.name!),
                text: model.enrollment == UserTypeForWeb.retailer
                    ? AppLocalizations.of(context)!.associationScreen_tab1
                    : "Association Requests",
                onTap: () {
                  model.changeScreen(
                      context,
                      model.enrollment == UserTypeForWeb.wholesaler
                          ? Routes.retailerRequest
                          : Routes.wholesalerRequest);
                },
              ),
              if (model.enrollment == UserTypeForWeb.retailer)
                NavButton(
                  isBottom: Routes.fieRequest ==
                      Utils.narrateFunction(
                          ModalRoute.of(context)!.settings.name!),
                  text: AppLocalizations.of(context)!.associationScreen_tab2,
                  onTap: () {
                    model.changeScreen(context, Routes.fieRequest);
                  },
                ),
              NavButton(
                isBottom: Routes.creditlineView ==
                    Utils.narrateFunction(
                        ModalRoute.of(context)!.settings.name!),
                text: AppLocalizations.of(context)!.associationScreen_tab3,
                onTap: () {
                  model.changeScreen(context, Routes.creditLineRequestWebView);
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(AppLocalizations.of(context)!.search),
              ),
              10.0.giveWidth,
              SizedBox(
                  width: 100,
                  height: 50,
                  child: NameTextField(
                    onChanged: (String v) {
                      model.searchList(v);
                    },
                    hintStyle: AppTextStyles.formTitleTextStyleNormal,
                  ))
            ],
          ),
        ),
      ],
    );
  }
}
