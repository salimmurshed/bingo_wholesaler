import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import '../../../data_models/enums/user_roles_files.dart';
import '../../../data_models/enums/user_type_for_web.dart';
import '/const/all_const.dart';
import '/const/app_extensions/status.dart';
import '/const/utils.dart';
import '/presentation/ui/static_screen/static_screen_view_model.dart';
import '/presentation/widgets/buttons/tab_bar_button.dart';
import '/presentation/widgets/cards/loader/loader.dart';
import '/presentation/widgets/cards/status_card_four_part.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stacked/stacked.dart';

import '../../../const/app_sizes/app_sizes.dart';
import '../../../const/server_status_file/server_status_file.dart';
import '../../../main.dart';
import '../../widgets/cards/app_bar_text.dart';
import '../../widgets/cards/shadow_card.dart';
import '../../widgets/dropdowns/sort_card_design.dart';

part '../../features_parts/static tabs_parts/customer_tab.dart';

part '../../features_parts/static tabs_parts/fie_tab.dart';

part '../../features_parts/static tabs_parts/sales_tab.dart';

part '../../features_parts/static tabs_parts/wholesaler_tab.dart';

part '../../features_parts/static tabs_parts/order_tab.dart';

class StaticView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StaticViewModel>.reactive(
        // onModelReady: (StaticViewModel model) {
        //   model.getAppTitle();
        // },
        viewModelBuilder: () => StaticViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  scaffoldKey.currentState!.openDrawer();
                },
                icon: Image.asset(AppAsset.moreIcon),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: IconButton(
                    onPressed: () {
                      model.readQrScanner(context);
                    },
                    icon: const Icon(Icons.qr_code),
                  ),
                ),
              ],
              backgroundColor: model.enrollment == UserTypeForWeb.retailer
                  ? AppColors.appBarColorRetailer
                  : AppColors.appBarColorWholesaler,
              title: AppBarText(model.changeAppBar().toUpperCase()),
            ),
            body: getViewForIndex(model.currentTabIndex, model),
            bottomNavigationBar: DefaultTabController(
              length: model.enrollment == UserTypeForWeb.retailer ? 4 : 3,
              child: Container(
                padding: AppPaddings.allBottomTabBarPadding,
                color: AppColors.background,
                height: 9.0.hp,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      // model.connectionStreamApiCall,
                      GestureDetector(
                        onTap: () {
                          model.setTabIndex(0);
                        },
                        child: TabBarButton(
                            width: 120,
                            active: model.currentTabIndex == 0 ? true : false,
                            text: AppLocalizations.of(context)!.orders),
                      ),
                      if (model
                          .isUserHaveAccess(UserRolesFiles.saleListVisibility))
                        GestureDetector(
                          onTap: () {
                            model.setTabIndex(1);
                          },
                          child: TabBarButton(
                              width: 120,
                              active: model.currentTabIndex == 1 ? true : false,
                              text: AppLocalizations.of(context)!.sales),
                        ),
                      model.enrollment == UserTypeForWeb.retailer
                          ? GestureDetector(
                              onTap: () {
                                model.setTabIndex(2);
                              },
                              child: TabBarButton(
                                  width: 120,
                                  active:
                                      model.currentTabIndex == 2 ? true : false,
                                  text: AppLocalizations.of(context)!
                                      .wholesalers),
                            )
                          : GestureDetector(
                              onTap: () {
                                model.setTabIndex(2);
                              },
                              child: TabBarButton(
                                  width: 100,
                                  active:
                                      model.currentTabIndex == 2 ? true : false,
                                  text:
                                      AppLocalizations.of(context)!.customers),
                            ),
                      if (model.enrollment == UserTypeForWeb.retailer)
                        GestureDetector(
                          onTap: () {
                            model.setTabIndex(3);
                          },
                          child: TabBarButton(
                              // width: 240,
                              active: model.currentTabIndex == 3 ? true : false,
                              text: AppLocalizations.of(context)!.fieSingle),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget getViewForIndex(int index, StaticViewModel model) {
    switch (index) {
      case 0:
        return OrderTab(model);
      case 1:
        return SalesTab(model);
      case 2:
        return model.enrollment == UserTypeForWeb.retailer
            ? WholesalerTabs(model)
            : CustomerTab(model);
      case 3:
        return FieTabs(model);
    }
    return const SizedBox();
  }
}
//retilerAssociationWholesalers
