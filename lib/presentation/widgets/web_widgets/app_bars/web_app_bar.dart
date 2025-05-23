import 'dart:convert';
import 'dart:ui';
import 'package:bingo/const/app_extensions/widgets_extensions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../app/app_secrets.dart';
import '../../../../const/special_key.dart';
import '../../../../const/utils.dart';
import 'package:universal_html/html.dart' as html;
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart' as i1;
import '../../../../const/web _utils.dart';
import '../../../../repository/repository_components.dart';
import '../../../../repository/repository_retailer.dart';
import '../../../../repository/repository_wholesaler.dart';
import '../../../../services/storage/device_storage.dart';
import '../cards/popup_menu_with_value.dart';
import '/repository/repository_retailer.dart' as i2;
import '/repository/repository_wholesaler.dart' as i3;

import '/app/locator.dart';
import '/app/web_route.dart';
import '/const/all_const.dart';
import '/services/auth_service/auth_service.dart';
import 'package:flutter/material.dart';

import '../../../../const/web_devices.dart';
import '../../../../data_models/enums/user_type_for_web.dart';
import '../../../../data_models/models/user_model/user_model.dart';
import '../../../../main.dart';
import '../../../../services/storage/db.dart';
import 'nav_button.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

// @immutable
class WebAppBar extends StatefulWidget {
  const WebAppBar({
    Key? key,
    this.onTap,
    this.tabNumber = "",
  }) : super(key: key);
  final Function(String)? onTap;
  final String tabNumber;

  @override
  State<WebAppBar> createState() => _WebAppBarState();
}

class _WebAppBarState extends State<WebAppBar> {
  @override
  void initState() {
    _authService.checkEnrollment();
    _authService.getLanguage();
    super.initState();
  }

  final repositoryComponents = locator<RepositoryComponents>();
  final _authService = locator<AuthService>();
  var deviceStorage = locator<ZDeviceStorage>();

  final UserModel user =
      UserModel.fromJson(jsonDecode(prefs.getString(DataBase.userData) ?? ""));

  List<SalesZones> get salesZones => user.data!.salesZones ?? [];

  List<SalesRoutes> get salesRoutes => user.data!.salesRoutes ?? [];

  List<Stores> get salesStores => user.data!.stores ?? [];

  List<Widget> getEncryptedData() {
    List data = [
      "anacaona@mailinator.com",
      "12345678",
      "info@bepensa.com.do",
      "Password@213",
      "fietest@test.com",
      "Password@213"
    ];
    List<Widget> b = [];
    final encrypter = encrypt.Encrypter(
        encrypt.AES(SpecialKeys.key, mode: encrypt.AESMode.cbc));
    for (var element in data) {
      b.add(SelectableText(encrypter
          .encrypt(
            element,
            iv: SpecialKeys.iv,
          )
          .base64));
    }
    return b;
  }

  UserTypeForWeb get enroll => _authService.enrollment.value;

  String narrateFunction(String v) {
    return v.replaceAll("/", "").toLowerCase();
  }

  bool isBusy = false;

  String get selectedLanguageCode => _authService.selectedLanguageCode;

  Future<void> setLanguage(String v, BuildContext context) async {
    await _authService.updateLanguage(v);
    List p = Uri.base.path.split('/');
    html.window.location.reload();
    setState(() {});
  }

  void logout(BuildContext context) async {
    setState(() {
      isBusy = true;
    });
    var authService = locator<AuthService>();

    await authService.logoutService();

    final gh = i1.GetItHelper(locator);
    if (locator.isRegistered<RepositoryRetailer>()) {
      locator.unregister<RepositoryRetailer>();
      gh.lazySingleton<i2.RepositoryRetailer>(() => i2.RepositoryRetailer());
    }
    if (locator.isRegistered<RepositoryWholesaler>()) {
      locator.unregister<RepositoryWholesaler>();
      gh.lazySingleton<i3.RepositoryWholesaler>(
          () => i3.RepositoryWholesaler());
    }
    await deviceStorage.clearData();
    Locale deviceLocale = window.locale;
    String langCode = deviceLocale.languageCode;
    authService.clearLanguage();
    if (!kIsWeb) {}
    repositoryComponents.setDashBoardInitialPage(context);

    context.goNamed(Routes.dashboard);
    setState(() {
      isBusy = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return device == ScreenSize.small
        ? Drawer(
            child: SizedBox(
              // width: 200,
              height: 100.0.hp,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  topBars(context),
                  const Divider(
                    color: AppColors.dividerColor,
                  ),
                  bottomBars(context),
                  const Spacer(),
                  profileSection(context)
                ],
              ),
            ),
          )
        : Column(
            children: [
              // Column(
              //   children: getEncryptedData().map((e) => e).toList(),
              // ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: const BoxDecoration(color: Colors.white),
                child: Column(
                  children: [
                    SizedBox(
                      width: 100.0.wp,
                      child: SingleChildScrollView(
                        scrollDirection: device == ScreenSize.wide
                            ? Axis.vertical
                            : Axis.horizontal,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [topBars(context), profileSection(context)],
                        ),
                      ),
                    ),
                    const Divider(
                      color: AppColors.dividerColor,
                    ),
                    bottomBars(context)
                  ],
                ),
              ),
            ],
          );
  }

  Widget profileSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(device == ScreenSize.wide ? 0.0 : 16.0),
      child: Row(
        mainAxisAlignment: device == ScreenSize.wide
            ? MainAxisAlignment.end
            : MainAxisAlignment.spaceBetween,
        // direction: device == ScreenSize.wide ? Axis.horizontal : Axis.vertical,
        children: [
          const Icon(Icons.notification_important),
          NavButton(
              text: enroll == UserTypeForWeb.retailer
                  ? "Retailer"
                  : enroll == UserTypeForWeb.wholesaler
                      ? "Wholesaler"
                      : "FIE"),
          _profileMenu(
            context,
            color: AppColors.contextMenuOne,
            items: [
              {
                "title":
                    AppLocalizations.of(context)!.logout.toUpperCamelCase(),
                "action": 1
              },
              {"title": AppLocalizations.of(context)!.editProfile, "action": 2},
              {
                "title": isBusy
                    ? 'logging out'
                    : "${user.data!.firstName} ${user.data!.lastName}",
                "action": 3
              },
            ],
            child: user.data!.profileImage!.isEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Image.asset(
                      AppAsset.logo,
                      height: 60,
                      width: 60,
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: WebUtils.image(
                      context,
                      user.data!.profileImage ?? "",
                      height: 60,
                      width: 60,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  // Flex(
  // direction: device ==
  // ScreenSize.wide
  // ? Axis.horizontal
  //     : Axis.vertical,
  Widget bottomBars(BuildContext context) {
    return SizedBox(
      width: 100.0.wp,
      child: SingleChildScrollView(
        scrollDirection:
            device == ScreenSize.wide ? Axis.vertical : Axis.horizontal,
        child: Flex(
          crossAxisAlignment: CrossAxisAlignment.start,
          direction:
              device == ScreenSize.wide ? Axis.horizontal : Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flex(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              direction:
                  device == ScreenSize.wide ? Axis.horizontal : Axis.vertical,
              children: [
                if (device != ScreenSize.small)
                  NavButton(
                      text: AppLocalizations.of(context)!
                          .secondaryNavBar_dashboard,
                      onTap: () {
                        widget.onTap!(Routes.dashboardScreen);
                      },
                      isBottom: "" ==
                              narrateFunction(
                                  ModalRoute.of(context)!.settings.name!) ||
                          "dashboard" ==
                              narrateFunction(
                                  ModalRoute.of(context)!.settings.name!)),
                if (enroll == UserTypeForWeb.retailer)
                  NavButton(
                      text: AppLocalizations.of(context)!
                          .secondaryNavBar_newOrder,
                      onTap: () {
                        context.goNamed(Routes.orderAddView);
                      },
                      isBottom: narrateFunction(
                              ModalRoute.of(context)!.settings.name!) ==
                          Routes.orderAddView),
                if (enroll != UserTypeForWeb.fie)
                  NavButton(
                      text:
                          AppLocalizations.of(context)!.secondaryNavBar_orders,
                      onTap: () {
                        context.goNamed(Routes.orderListView,
                            pathParameters: {'page': '1'});
                      },
                      isBottom: narrateFunction(
                                  ModalRoute.of(context)!.settings.name!) ==
                              Routes.orderListView ||
                          narrateFunction(
                                  ModalRoute.of(context)!.settings.name!) ==
                              Routes.orderDetailsView),
                if (enroll != UserTypeForWeb.fie)
                  NavButton(
                      text: AppLocalizations.of(context)!.secondaryNavBar_sales,
                      onTap: () {
                        context.goNamed(Routes.saleScreen,
                            pathParameters: {'page': '1'});
                      },
                      isBottom: Routes.saleScreen ==
                              narrateFunction(
                                  ModalRoute.of(context)!.settings.name!) ||
                          Routes.saleDetails ==
                              narrateFunction(
                                  ModalRoute.of(context)!.settings.name!) ||
                          Routes.saleTransaction ==
                              narrateFunction(
                                  ModalRoute.of(context)!.settings.name!) ||
                          Routes.addSales ==
                              narrateFunction(
                                  ModalRoute.of(context)!.settings.name!)),
                if (enroll != UserTypeForWeb.fie)
                  NavButton(
                      text: AppLocalizations.of(context)!
                          .secondaryNavBar_creditLines,
                      onTap: () {
                        context.goNamed(Routes.creditlineView);
                      },
                      isBottom: Routes.creditlineView ==
                          narrateFunction(
                              ModalRoute.of(context)!.settings.name!)),
                if (enroll == UserTypeForWeb.wholesaler)
                  NavButton(
                      text: AppLocalizations.of(context)!
                          .secondaryNavBar_advancedSales,
                      onTap: () {
                        widget.onTap!(Routes.elses);
                      },
                      isBottom: "credit lines" == Routes.elses),
                if (enroll == UserTypeForWeb.fie)
                  NavButton(
                      text: AppLocalizations.of(context)!
                          .secondaryNavBar_creditLines,
                      onTap: () {
                        widget.onTap!(Routes.elses);
                      },
                      isBottom: "settlements" == Routes.elses),
                if (enroll == UserTypeForWeb.fie)
                  NavButton(
                      text: AppLocalizations.of(context)!
                          .secondaryNavBar_advancedSales,
                      onTap: () {
                        widget.onTap!(Routes.elses);
                      },
                      isBottom: "settlements" == Routes.elses),
                NavButton(
                    text: AppLocalizations.of(context)!
                        .secondaryNavBar_statements,
                    onTap: () {
                      if (enroll == UserTypeForWeb.fie) {
                        context.goNamed(Routes.fieFinancialStatementView,
                            queryParameters: {
                              'enroll': 'wholesaler',
                              'page': '1'
                            });
                      } else {
                        context.goNamed(
                          Routes.financialStatementView,
                          queryParameters: {
                            'page': '1',
                          },
                        );
                        // widget.onTap!(Routes.financialStatementView);
                      }
                    },
                    isBottom: "statements" ==
                            narrateFunction(
                                ModalRoute.of(context)!.settings.name!) ||
                        "fie-statements" ==
                            narrateFunction(
                                ModalRoute.of(context)!.settings.name!) ||
                        "sale-statements" ==
                            narrateFunction(
                                ModalRoute.of(context)!.settings.name!) ||
                        "fie-sale-statements" ==
                            narrateFunction(
                                ModalRoute.of(context)!.settings.name!)),
                NavButton(
                    text: AppLocalizations.of(context)!
                        .secondaryNavBar_settlements,
                    onTap: () {
                      context.goNamed(
                        Routes.retailerSettlement,
                        pathParameters: {'page': 'settlements', 'p': '1'},
                      );
                    },
                    isBottom: Routes.retailerSettlement ==
                            narrateFunction(
                                ModalRoute.of(context)!.settings.name!) ||
                        Routes.retailerSettlement ==
                            narrateFunction(
                                ModalRoute.of(context)!.settings.name!) ||
                        Routes.paymentLotDetailsView ==
                            narrateFunction(
                                ModalRoute.of(context)!.settings.name!)),
              ],
            ),
            device == ScreenSize.wide
                ? selectionPanels(context)
                : const SizedBox()
          ],
        ),
      ),
    );
  }

  Widget selectionPanels(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: device == ScreenSize.wide ? 0.0 : 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        // direction: device == ScreenSize.wide ? Axis.horizontal : Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (enroll == UserTypeForWeb.retailer)
            Utils.showPopupMenu(context,
                isPadded: true,
                text: AppLocalizations.of(context)!.webHeader_popup_store,
                color: AppColors.bingoGreen,
                items: [
                  if (salesStores.isNotEmpty)
                    for (int i = 0; i < salesStores.length; i++)
                      salesStores[i].name,
                ]),
          if (enroll == UserTypeForWeb.wholesaler)
            Utils.showPopupMenu(context,
                isPadded: true,
                text: AppLocalizations.of(context)!.webHeader_popup_zoneRoute,
                color: AppColors.bingoGreen,
                items: [
                  AppLocalizations.of(context)!.webHeader_popButton_zone,
                  if (salesZones.isNotEmpty)
                    for (int i = 0; i < salesZones.length; i++)
                      salesZones[i].zoneName,
                  AppLocalizations.of(context)!.webHeader_popButton_route,
                  if (salesRoutes.isNotEmpty)
                    for (int i = 0; i < salesRoutes.length; i++)
                      salesRoutes[i].salesRouteName,
                  AppLocalizations.of(context)!.webHeader_popButton_viewAll,
                ]),
          10.0.giveWidth,
          PopupMenuWithValue(
              // isPadded: true,
              onTap: (int v) {
                openPopResult(v, context);
              },
              text: AppLocalizations.of(context)!.webHeader_popup_settings,
              color: AppColors.contextMenuTwo,
              items: enroll == UserTypeForWeb.retailer
                  ? [
                      {
                        't': AppLocalizations.of(context)!
                            .webHeader_popButton_users,
                        'v': 0
                      },
                      {
                        't': AppLocalizations.of(context)!
                            .webHeader_popButton_roles,
                        'v': 1
                      },
                      {
                        't': AppLocalizations.of(context)!
                            .webHeader_popButton_stores,
                        'v': 2
                      },
                      {
                        't': AppLocalizations.of(context)!
                            .webHeader_popButton_manageAccount,
                        'v': 3
                      },
                      {
                        't': AppLocalizations.of(context)!
                            .webHeader_popButton_companyProfile,
                        'v': 4
                      }
                    ]
                  : enroll == UserTypeForWeb.wholesaler
                      ? [
                          {
                            't': AppLocalizations.of(context)!
                                .webHeader_popButton_users,
                            'v': 0
                          },
                          {
                            't': AppLocalizations.of(context)!
                                .webHeader_popButton_roles,
                            'v': 1
                          },
                          {
                            't': AppLocalizations.of(context)!
                                .webHeader_popButton_business,
                            'v': 2
                          },
                          {
                            't': AppLocalizations.of(context)!
                                .webHeader_popButton_logistics,
                            'v': 3
                          },
                          {
                            't': AppLocalizations.of(context)!
                                .webHeader_popButton_finance,
                            'v': 4
                          },
                          {
                            't': AppLocalizations.of(context)!
                                .webHeader_popButton_paymentMethod,
                            'v': 5
                          },
                          {
                            't': AppLocalizations.of(context)!
                                .webHeader_popButton_deliveryMethod,
                            'v': 6
                          },
                          {
                            't': AppLocalizations.of(context)!
                                .webHeader_popButton_companyProfile,
                            'v': 7
                          }
                        ]
                      : [
                          {
                            't': AppLocalizations.of(context)!
                                .webHeader_popButton_users,
                            'v': 0
                          },
                          {
                            't': AppLocalizations.of(context)!
                                .webHeader_popButton_roles,
                            'v': 1
                          },
                          {
                            't': AppLocalizations.of(context)!
                                .webHeader_popButton_pricingFees,
                            'v': 2
                          },
                          {
                            't': AppLocalizations.of(context)!
                                .webHeader_popButton_finance,
                            'v': 3
                          },
                          {
                            't': AppLocalizations.of(context)!
                                .webHeader_popButton_business,
                            'v': 4
                          },
                          {
                            't': AppLocalizations.of(context)!
                                .webHeader_popButton_companyProfile,
                            'v': 5
                          },
                          {
                            't': AppLocalizations.of(context)!
                                .webHeader_popButton_creditLineParameters,
                            'v': 6
                          }
                        ])
        ],
      ),
    );
  }

  Widget topBars(BuildContext context) {
    return Flex(
      crossAxisAlignment: device == ScreenSize.wide
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      direction: device == ScreenSize.wide ? Axis.horizontal : Axis.vertical,
      children: [
        Padding(
          padding: EdgeInsets.all(device == ScreenSize.wide ? 0.0 : 8.0),
          child: Image.asset(
            AppAsset.loginLogo,
            height: 40,
            // width: 100,
          ),
        ),
        device != ScreenSize.wide ? selectionPanels(context) : const SizedBox(),
        if (device == ScreenSize.small)
          NavButton(
            isColor: Routes.dashboardScreen ==
                Utils.narrateFunction(ModalRoute.of(context)!.settings.name!),
            text: AppLocalizations.of(context)!.dashBoard,
            onTap: () {
              context.goNamed(Routes.dashboardScreen);
            },
          ),
        if (enroll == UserTypeForWeb.fie || enroll == UserTypeForWeb.retailer)
          NavButton(
            isColor: Routes.wholesaler ==
                    Utils.narrateFunction(
                        ModalRoute.of(context)!.settings.name!) ||
                Routes.wholesalerDetailsView ==
                    Utils.narrateFunction(
                        ModalRoute.of(context)!.settings.name!),
            text: AppLocalizations.of(context)!.topNavBar_wholesaler,
            onTap: () {
              context.goNamed(Routes.wholesaler, pathParameters: {"page": "1"});
            },
          ),
        if (enroll == UserTypeForWeb.fie || enroll == UserTypeForWeb.wholesaler)
          NavButton(
            isColor: Routes.paymentLotDetailsViewfromretailer ==
                    Utils.narrateFunction(
                        ModalRoute.of(context)!.settings.name!) ||
                Routes.retailer ==
                    Utils.narrateFunction(
                        ModalRoute.of(context)!.settings.name!) ||
                Routes.retailerCreditLineView ==
                    Utils.narrateFunction(
                        ModalRoute.of(context)!.settings.name!) ||
                Routes.retailerInternalView ==
                    Utils.narrateFunction(
                        ModalRoute.of(context)!.settings.name!) ||
                Routes.retailerProfile ==
                    Utils.narrateFunction(
                        ModalRoute.of(context)!.settings.name!) ||
                Routes.retailerLocation ==
                    Utils.narrateFunction(
                        ModalRoute.of(context)!.settings.name!) ||
                Routes.retailerSettlements ==
                    Utils.narrateFunction(
                        ModalRoute.of(context)!.settings.name!) ||
                Routes.retailerSales ==
                    Utils.narrateFunction(
                        ModalRoute.of(context)!.settings.name!) ||
                Routes.retailerOrders ==
                    Utils.narrateFunction(
                        ModalRoute.of(context)!.settings.name!),
            onTap: () {
              context.goNamed(Routes.retailer, pathParameters: {"page": "1"});
            },
            text: AppLocalizations.of(context)!.topNavBar_retailer,
          ),
        if (enroll == UserTypeForWeb.retailer)
          NavButton(
            isColor: Routes.fieListView ==
                    Utils.narrateFunction(
                        ModalRoute.of(context)!.settings.name!) ||
                Routes.fieDetailsView ==
                    Utils.narrateFunction(
                        ModalRoute.of(context)!.settings.name!),
            onTap: () {
              context
                  .goNamed(Routes.fieListView, queryParameters: {"page": "1"});
            },
            text: AppLocalizations.of(context)!.topNavBar_financialInstitutions,
          ),
        if (enroll == UserTypeForWeb.retailer)
          NavButton(
            isColor: Routes.creditLineRequestDetailsView ==
                    Utils.narrateFunction(
                        ModalRoute.of(context)!.settings.name!) ||
                Routes.creditLineRequestWebView ==
                    Utils.narrateFunction(
                        ModalRoute.of(context)!.settings.name!) ||
                Routes.addRequestView ==
                    Utils.narrateFunction(
                        ModalRoute.of(context)!.settings.name!) ||
                Routes.addNewCreditlineView ==
                    Utils.narrateFunction(
                        ModalRoute.of(context)!.settings.name!) ||
                Routes.wholesalerRequest ==
                    Utils.narrateFunction(
                        ModalRoute.of(context)!.settings.name!) ||
                Routes.associationRequestDetailsView ==
                    Utils.narrateFunction(
                        ModalRoute.of(context)!.settings.name!) ||
                Routes.fieRequest ==
                    Utils.narrateFunction(
                        ModalRoute.of(context)!.settings.name!),
            text: AppLocalizations.of(context)!.topNavBar_requests,
            onTap: () {
              context.goNamed(Routes.wholesalerRequest);
            },
          ),
        if (enroll == UserTypeForWeb.wholesaler)
          NavButton(
            isColor: Routes.zoneRouteOption ==
                    Utils.narrateFunction(
                        ModalRoute.of(context)!.settings.name!) ||
                Routes.zoneRouteDynamic ==
                    Utils.narrateFunction(
                        ModalRoute.of(context)!.settings.name!) ||
                Routes.zoneRouteStatic ==
                    Utils.narrateFunction(
                        ModalRoute.of(context)!.settings.name!) ||
                Routes.zoneRouteZone ==
                    Utils.narrateFunction(
                        ModalRoute.of(context)!.settings.name!),
            text: AppLocalizations.of(context)!.topNavBar_zonesRoutes,
            onTap: () {
              context.goNamed(Routes.zoneRouteDynamic, queryParameters: {
                'page': '1',
                "from": (DateFormat('yyyy-MM-dd').format(DateTime.now()))
                    .toString(),
                "to":
                    (DateFormat('yyyy-MM-dd').format(DateTime.now())).toString()
              });
            },
          ),
        if (enroll == UserTypeForWeb.wholesaler)
          NavButton(
            isColor: Routes.productDetailsView ==
                    Utils.narrateFunction(
                        ModalRoute.of(context)!.settings.name!) ||
                Routes.promoCodeView ==
                    Utils.narrateFunction(
                        ModalRoute.of(context)!.settings.name!) ||
                Routes.productSummary ==
                    Utils.narrateFunction(
                        ModalRoute.of(context)!.settings.name!) ||
                Routes.editPromoCodeView ==
                    Utils.narrateFunction(
                        ModalRoute.of(context)!.settings.name!) ||
                Routes.addPromoCodeView ==
                    Utils.narrateFunction(
                        ModalRoute.of(context)!.settings.name!),
            onTap: () {
              context
                  .goNamed(Routes.promoCodeView, pathParameters: {'page': '1'});
            },
            text: AppLocalizations.of(context)!.topNavBar_productsPricing,
          ),
        if (enroll == UserTypeForWeb.fie)
          NavButton(
            text: AppLocalizations.of(context)!.topNavBar_businessStructure,
          ),
        if (enroll == UserTypeForWeb.wholesaler || enroll == UserTypeForWeb.fie)
          NavButton(
            isColor: Routes.wholesalerRequest ==
                    Utils.narrateFunction(
                        ModalRoute.of(context)!.settings.name!) ||
                Routes.creditLineRequestWebView ==
                    Utils.narrateFunction(
                        ModalRoute.of(context)!.settings.name!) ||
                Routes.retailerRequest ==
                    Utils.narrateFunction(
                        ModalRoute.of(context)!.settings.name!) ||
                Routes.creditLineRequestDetailsView ==
                    Utils.narrateFunction(
                        ModalRoute.of(context)!.settings.name!) ||
                Routes.associationRequestDetailsView ==
                    Utils.narrateFunction(
                        ModalRoute.of(context)!.settings.name!),
            text: AppLocalizations.of(context)!.topNavBar_requests,
            onTap: () {
              enroll == UserTypeForWeb.wholesaler
                  ? context.goNamed(Routes.retailerRequest)
                  : context.goNamed(Routes.wholesalerRequest);
            },
          ),
      ],
    );
  }

  Widget _profileMenu(context,
      {required Widget child, required Color color, required List items}) {
    return Material(
      color: Colors.white,
      child: PopupMenuButton(
        tooltip: 'Profile',
        splashRadius: 20.0,
        offset: const Offset(0, 60),
        itemBuilder: (BuildContext context) {
          return items
              .map((e) => PopupMenuItem(
                    height: 30,
                    onTap: () {
                      if (e["action"] == 1) {
                        logout(context);
                      } else if (e["action"] == 2) {
                        context.goNamed(Routes.editProfile);
                      }
                    },
                    value: 1,
                    child: Text(
                      e["title"],
                      style: const TextStyle(
                          fontSize: 10, color: AppColors.ashColor),
                    ),
                  ))
              .toList();
        },
        elevation: 8.0,
        child: child,
      ),
    );
  }

  void openPopResult(int v, BuildContext context) {
    if (enroll == UserTypeForWeb.retailer) {
      if (v == 0) {
        context.goNamed(Routes.userList, pathParameters: {
          'page': "1",
        });
      } else if (v == 1) {
        context.goNamed(Routes.rolesView);
      } else if (v == 2) {
        context.goNamed(Routes.storeList);
      } else if (v == 3) {
        context.goNamed(Routes.manageAccountView, pathParameters: {
          'page': "1",
        });
      } else if (v == 4) {
        context.goNamed(Routes.companyProfileView);
      }
    } else if (enroll == UserTypeForWeb.wholesaler) {
      if (v == 0) {
        context.goNamed(Routes.userList, pathParameters: {
          'page': "1",
        });
      } else if (v == 1) {
        context.goNamed(Routes.rolesView);
      } else if (v == 2) {
        context.goNamed(Routes.business);
      } else if (v == 3) {
        context.goNamed(Routes.logistics);
      } else if (v == 4) {
        context.goNamed(Routes.finance);
      } else if (v == 5) {
        context.goNamed(Routes.paymentMethodView);
      } else if (v == 6) {
        context.goNamed(Routes.deliveryMethodView);
      } else if (v == 7) {
        context.goNamed(Routes.companyProfileView);
      }
    }
  }
}
