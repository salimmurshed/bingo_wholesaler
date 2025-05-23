import 'package:auto_size_text/auto_size_text.dart';
import '/const/all_const.dart';
import '/const/app_extensions/status.dart';
import '/const/app_extensions/strings_extention.dart';
import '/const/utils.dart';
import '/presentation/widgets/cards/progress_status_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:stacked/stacked.dart';

import '../../../const/app_sizes/app_sizes.dart';
import '../../../data_models/enums/static_page_enums.dart';
import '../../widgets/buttons/tab_bar_button.dart';
import '../../widgets/cards/app_bar_text.dart';
import '../../widgets/cards/loader/loader.dart';
import '../../widgets/cards/sales_details_card.dart';
import '../../widgets/cards/shadow_card.dart';
import '../../widgets/cards/status_card_four_part.dart';
import '../../widgets/dropdowns/sort_card_design.dart';
import '../../widgets/text_fields/name_text_field.dart';
import 'customer_details_view_model.dart';

part '../../features_parts/static tabs_parts/tabs/customer_tabs.dart';

class CustomerDetailsView extends StatelessWidget {
  const CustomerDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CustomerDetailsViewModel>.reactive(
        onViewModelReady: (CustomerDetailsViewModel model) {
          if (ModalRoute.of(context)!.settings.arguments != null) {
            model.setData(
                ModalRoute.of(context)!.settings.arguments as List<String>);
          }
        },
        viewModelBuilder: () => CustomerDetailsViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: AppBarText(model.retaileName),
            ),
            body: model.isBusy
                ? SizedBox(
                    width: 100.0.wp,
                    height: 100.0.hp,
                    child: const Center(
                      child: LoaderWidget(),
                    ),
                  )
                : SizedBox(
                    height: 100.0.hp,
                    child: RefreshIndicator(
                      backgroundColor: AppColors.whiteColor,
                      color: AppColors.appBarColorWholesaler,
                      onRefresh: model.customerTab == CustomersTabs.creditlines
                          ? model.refreshCustomerCreditlineOnline
                          : model.customerTab == CustomersTabs.sales
                              ? model.refreshCustomerSales
                              : model.customerTab == CustomersTabs.locations
                                  ? model.refreshCustomerStore
                                  : model.customerTab == CustomersTabs.profile
                                      ? model.refreshCustomerProfile
                                      : model.customerTab ==
                                              CustomersTabs.internal
                                          ? model.refreshCustomerStore
                                          : model.refreshCustomerStore,
                      child: DefaultTabController(
                        length: 6,
                        initialIndex: model.customerTab.index,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomerTabs(model),
                            model.customerTab == CustomersTabs.creditlines
                                ? creditLine(model, context)
                                : model.customerTab == CustomersTabs.orders
                                    ? orders(context)
                                    : model.customerTab == CustomersTabs.sales
                                        ? sales(model, context)
                                        // : model.customerTab == CustomersTabs.settlements
                                        //     ? settlements(model)
                                        : model.customerTab ==
                                                CustomersTabs.locations
                                            ? locations(model, context)
                                            : model.customerTab ==
                                                    CustomersTabs.profile
                                                ? profile(model, context)
                                                : model.customerTab ==
                                                        CustomersTabs.internal
                                                    ? internal(model, context)
                                                    : const SizedBox(),
                          ],
                        ),
                      ),
                    ),
                  ),
          );
        });
  }

  Widget creditLine(CustomerDetailsViewModel model, BuildContext context) {
    return model.customerCreditline.isEmpty
        ? Utils.noDataWidget(context)
        : SingleChildScrollView(
            physics: Utils.pullScrollPhysic,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (model.customerCreditline.isNotEmpty)
                  SortCardDesing(
                    height: 50.0,
                    items: [
                      AppLocalizations.of(context)!.status,
                      AppLocalizations.of(context)!.date
                    ]
                        .map(
                          (e) => DropdownMenuItem<String>(
                            onTap: () {
                              model.creditlineSortList(e);
                            },
                            value: e,
                            child: Text(e),
                          ),
                        )
                        .toList(),
                    sortedItem: model.sortedItemCreditline,
                  ),
                for (int i = 0; i < model.customerCreditline.length; i++)
                  ProgressStatusCard(
                    onTap: () {
                      model.gotoCreditlineDetails(i);
                    },
                    title: model.customerCreditline[i].clInternalId!,
                    bodyFirstKey:
                        "${AppLocalizations.of(context)!.currentBalance}\n${model.customerCreditline[i].approvedCreditLineCurrency}  ${model.customerCreditline[i].consumedAmount}",
                    bodySecondKey:
                        "${AppLocalizations.of(context)!.appAmount}\n${model.customerCreditline[i].approvedCreditLineCurrency} ${model.customerCreditline[i].approvedCreditLineAmount}",
                    status: model.customerCreditline[i].status!,
                    statusDescription:
                        model.customerCreditline[i].statusDescription!,
                    language: model.language,
                    getFrictionOfAvailability:
                        model.getFrictionOfAvailability(i),
                  ),
              ],
            ),
          );
  }

//model.refreshCustomerSales
  orders(context) {
    return Utils.noDataWidget(context);
  }

  sales(CustomerDetailsViewModel model, context) {
    return (model.customerSales.isEmpty)
        ? Utils.noDataWidget(context)
        : Expanded(
            child: SingleChildScrollView(
              physics: Utils.pullScrollPhysic,
              child: Column(
                children: [
                  SortCardDesing(
                    height: 50.0,
                    items: [
                      AppLocalizations.of(context)!.status,
                      AppLocalizations.of(context)!.date
                    ]
                        .map(
                          (e) => DropdownMenuItem<String>(
                            onTap: () {
                              model.salesCustomerSortList(e);
                            },
                            value: e,
                            child: Text(e),
                          ),
                        )
                        .toList(),
                    sortedItem: model.sortedItemSales,
                  ),
                  for (int i = 0; i < model.customerSales.length; i++)
                    InkWell(
                      onTap: () {
                        model.gotoSalesDetails(model.customerSales[i]);
                      },
                      child: StatusCardFourPart(
                          firstBoxWidth: 120,
                          price:
                              "${model.customerSales[i].currency} ${model.customerSales[i].amount}",
                          title: model.customerSales[i].invoiceNumber!
                                      .isEmpty ||
                                  model.customerSales[i].invoiceNumber == "-"
                              ? model.customerSales[i].orderNumber!
                              : model.customerSales[i].invoiceNumber!,
                          // "${model.customerSales[i].uniqueId!.lastChars(10)} ",
                          niceSubtitle:
                              "${AppLocalizations.of(context)!.dueDate}: ${model.customerSales[i].dueDate}",
                          bodyFirstKey:
                              "${AppLocalizations.of(context)!.salesAmount} \n${model.customerSales[i].currency} ${model.customerSales[i].amount}",
                          bodySecondKey:
                              "${AppLocalizations.of(context)!.salesBalance}\n${model.customerSales[i].currency} ${model.customerSales[i].balance}",
                          statusChild: model.customerSales[i].status!
                              .toSaleStatus(
                                  text: model
                                      .customerSales[i].statusDescription!)),
                    ),
                  if (model.salesLoadMoreButton)
                    model.isLoadingMore
                        ? Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Utils.loaderBusy(),
                          )
                        : Utils.loadMore(model.loadMoreCustomerSales),
                ],
              ),
            ),
          );
  }

  settlements(CustomerDetailsViewModel model, context) {
    return RefreshIndicator(
      backgroundColor: AppColors.whiteColor,
      color: AppColors.appBarColorWholesaler,
      onRefresh: model.refreshCustomerSettlements,
      child: SingleChildScrollView(
        physics: Utils.pullScrollPhysic,
        child: model.customerSettlements.isEmpty
            ? Utils.noDataWidget(context)
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SortCardDesing(
                    height: 50.0,
                    items: [
                      AppLocalizations.of(context)!.status,
                      AppLocalizations.of(context)!.date
                    ]
                        .map(
                          (e) => DropdownMenuItem<String>(
                            onTap: () {
                              model.settlementsCustomerSortList(e);
                            },
                            value: e,
                            child: Text(e),
                          ),
                        )
                        .toList(),
                    sortedItem: model.sortedItemSettlements,
                  ),
                  for (int i = 0; i < model.customerSettlements.length; i++)
                    InkWell(
                      onTap: () {
                        model.gotoSettlementDetails(i);
                      },
                      child: StatusCardFourPart(
                          price:
                              "${model.customerSettlements[i].currency} ${model.customerSettlements[i].amount!}",
                          title:
                              model.customerSettlements[i].lotId!.lastChars(10),
                          subTitle:
                              "${model.customerSettlements[i].postingDate}",
                          bodyFirstKey:
                              "${AppLocalizations.of(context)!.settNo} ${i + 1}",
                          bodySecondKey:
                              "${AppLocalizations.of(context)!.lotId} ${model.customerSettlements[i].lotId!.lastChars(10)}",
                          statusChild: model.customerSales[i].status!
                              .toSaleStatus(
                                  text: model
                                      .customerSales[i].statusDescription!)),
                    ),
                ],
              ),
      ),
    );
  }

  locations(CustomerDetailsViewModel model, BuildContext context) {
    return model.customerStore.isEmpty
        ? Utils.noDataWidget(context)
        : SingleChildScrollView(
            physics: Utils.pullScrollPhysic,
            child: Column(
              children: [
                if (model.customerStore.isNotEmpty)
                  SortCardDesing(
                    height: 50.0,
                    items: [
                      AppLocalizations.of(context)!.status,
                      AppLocalizations.of(context)!.date
                    ]
                        .map(
                          (e) => DropdownMenuItem<String>(
                            onTap: () {
                              // model.salesCustomerSortList(e);
                            },
                            value: e,
                            child: Text(e),
                          ),
                        )
                        .toList(),
                    sortedItem: model.sortedItemSales,
                  ),
                for (int i = 0; i < model.customerStore.length; i++)
                  ShadowCard(
                    child: InkWell(
                      onTap: () {
                        model.gotoLocationDetails(
                          model.customerStore[i],
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AutoSizeText(
                                    model.customerStore[i].name!,
                                    maxLines: 2,
                                    style: AppTextStyles.statusCardTitle,
                                  ),
                                  5.0.giveHeight,
                                  Row(
                                    children: [
                                      Image.asset(
                                        AppAsset.locator,
                                        scale: 1.3,
                                      ),
                                      10.0.giveWidth,
                                      SizedBox(
                                        width: 75.0.wp,
                                        child: Text(
                                          model.customerStore[i].address!,
                                          maxLines: 2,
                                          style:
                                              AppTextStyles.statusCardSubTitle,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          12.0.giveHeight,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 40.0.wp,
                                child: Utils.getNiceText(
                                    "${AppLocalizations.of(context)!.bingoStoreID} ${model.customerStore[i].bingoStoreId}"),
                              ),
                              SizedBox(
                                width: 40.0.wp,
                                child: Utils.getNiceText(
                                    "${AppLocalizations.of(context)!.city}: ${model.customerStore[i].city!}"),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          );
  }

  profile(CustomerDetailsViewModel model, BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: Utils.pullScrollPhysic,
        child: model.customerProfile.data!.isEmpty
            ? Utils.noDataWidget(context)
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Utils.commonText(
                    AppLocalizations.of(context)!.profileInformation,
                    needPadding: true,
                    style: AppTextStyles.headerText,
                  ),
                  Utils.cardToTextGaps(),
                  ShadowCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SalesDetails(
                          data: [
                            "${AppLocalizations.of(context)!.commercialName}: ${model.customerProfile.data![0].companyInformation![0].commercialName!.emptyCheck()}",
                          ],
                        ),
                        Utils.getNiceText(
                            "${AppLocalizations.of(context)!.aboutUs}:"),
                        Html(
                          data: model.customerProfile.data![0]
                              .companyInformation![0].bpCompanyAboutUs!
                              .emptyCheck(),
                        ),
                        SalesDetails(
                          data: [
                            "${AppLocalizations.of(context)!.dateFounded}: ${model.customerProfile.data![0].companyInformation![0].dateFounded!.emptyCheck()}",
                            "${AppLocalizations.of(context)!.websiteUrl}: ${model.customerProfile.data![0].companyInformation![0].website!.emptyCheck()}",
                          ],
                        ),
                      ],
                    ),
                  ),
                  Utils.cardGaps(),
                  Utils.commonText(
                    AppLocalizations.of(context)!.ownerLegalRepresentative,
                    needPadding: true,
                    style: AppTextStyles.headerText,
                  ),
                  Utils.cardToTextGaps(),
                  ShadowCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SalesDetails(
                          data: [
                            "${AppLocalizations.of(context)!.legalName}\n${model.customerProfile.data![0].companyInformation![0].retailerName!.emptyCheck()}\n",
                            "${AppLocalizations.of(context)!.taxID}\n${model.customerProfile.data![0].companyInformation![0].taxId!.emptyCheck()}\n",
                            "${AppLocalizations.of(context)!.businessAddress}\n${model.customerProfile.data![0].companyInformation![0].companyAddress!.emptyCheck()}",
                          ],
                        ),
                      ],
                    ),
                  ),
                  Utils.cardGaps(),
                  Utils.commonText(
                    AppLocalizations.of(context)!.personalInformation,
                    needPadding: true,
                    style: AppTextStyles.headerText,
                  ),
                  Utils.cardToTextGaps(),
                  ShadowCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SalesDetails(
                          data: [
                            "${AppLocalizations.of(context)!.fName}${model.customerProfile.data![0].contactInformation![0].firstName!.emptyCheck()}",
                            "${AppLocalizations.of(context)!.lName}${model.customerProfile.data![0].contactInformation![0].lastName!.emptyCheck()}",
                            "${AppLocalizations.of(context)!.positioN}${model.customerProfile.data![0].contactInformation![0].position!.emptyCheck()}",
                            "${AppLocalizations.of(context)!.iD}${model.customerProfile.data![0].contactInformation![0].id!.emptyCheck()}",
                            "${AppLocalizations.of(context)!.phoneNumbeR}${model.customerProfile.data![0].contactInformation![0].phoneNumber!.emptyCheck()}",
                          ],
                        ),
                        20.0.giveHeight,
                        FittedBox(
                          // width: 160.0,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100.0),
                              ),
                              backgroundColor: AppColors.inactiveButtonColor,
                            ),
                            onPressed: () {
                              model.gotoDocumentsDetails(context);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.viewDocuments,
                              style: AppTextStyles.successStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  20.0.giveHeight,
                ],
              ),
      ),
    );
  }

  internal(CustomerDetailsViewModel model, BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: Utils.pullScrollPhysic,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Utils.commonText(
              AppLocalizations.of(context)!.profileInformation,
              needPadding: true,
              style: AppTextStyles.headerText,
            ),
            Utils.cardToTextGaps(),
            ShadowCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  10.0.giveHeight,
                  NameTextField(
                    enable: false,
                    controller: model.internalIdController,
                    fieldName: AppLocalizations.of(context)!.internalID,
                  ),
                  10.0.giveHeight,
                  NameTextField(
                    enable: false,
                    controller: model.customerTypeController,
                    fieldName: AppLocalizations.of(context)!.selectCustomerType,
                  ),
                  10.0.giveHeight,
                  NameTextField(
                    enable: false,
                    controller: model.gracePeriodGroupsController,
                    fieldName: AppLocalizations.of(context)!.gracePeriodGroups,
                  ),
                  10.0.giveHeight,
                  NameTextField(
                    enable: false,
                    controller: model.pricingGroupsController,
                    fieldName: AppLocalizations.of(context)!.pricingGroups,
                  ),
                  // NameTextField(
                  //   enable: false,
                  //   controller: model.salesZoneController,
                  //   fieldName: AppLocalizations.of(context)!.salesZone,
                  // ),
                ],
              ),
            ),
            Utils.cardGaps(),
            Utils.commonText(
              AppLocalizations.of(context)!.ownerLegalRepresentative,
              needPadding: true,
              style: AppTextStyles.headerText,
            ),
            Utils.cardToTextGaps(),
            ShadowCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  10.0.giveHeight,
                  NameTextField(
                    enable: false,
                    controller: model.selectDate,
                    fieldName: AppLocalizations.of(context)!.customerSinceDate,
                  ),
                  10.0.giveHeight,
                  NameTextField(
                    enable: false,
                    controller: model.monthlySalesController,
                    fieldName: AppLocalizations.of(context)!.monthlySales,
                  ),
                  10.0.giveHeight,
                  NameTextField(
                    enable: false,
                    controller: model.averageSalesTicketController,
                    fieldName: AppLocalizations.of(context)!.averageSalesTicket,
                  ),
                  10.0.giveHeight,
                  NameTextField(
                    enable: false,
                    controller: model.visitFreqController,
                    fieldName: AppLocalizations.of(context)!.visitFrequency,
                  ),
                  10.0.giveHeight,
                  NameTextField(
                    enable: false,
                    controller: model.suggestedCreditLineAmountController,
                    fieldName:
                        AppLocalizations.of(context)!.suggestedCreditLineAmount,
                  ),
                ],
              ),
            ),
            20.0.giveHeight,
          ],
        ),
      ),
    );
  }
}
