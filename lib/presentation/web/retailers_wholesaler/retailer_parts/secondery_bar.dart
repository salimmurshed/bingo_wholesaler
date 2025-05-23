import 'package:bingo/app/web_route.dart';
import 'package:bingo/const/all_const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../const/app_colors.dart';
import '../../../../const/utils.dart';
import '../../../../const/web_devices.dart';
import '../../../widgets/buttons/submit_button.dart';
import '../../../widgets/text_fields/name_text_field.dart';
import '../../../widgets/web_widgets/app_bars/nav_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../widgets/web_widgets/cards/popup_menu_with_value.dart';

class SecondaryBar extends StatelessWidget {
  SecondaryBar(this.ttx, this.uid, {Key? key}) : super(key: key);
  final String? ttx;
  final String? uid;
  final List<List<String>> tabs = [
    [
      'Creditlines',
      Routes.retailerCreditLineView,
      '',
      Routes.retailerCreditlineDetailsView
    ],
    ['Orders', '', '', ''],
    ['Sales', Routes.retailerSales, "1", ''],
    ['Settlements', Routes.retailerSettlements, '', ''],
    ['Locations', Routes.retailerLocation, '', Routes.locationDetailsView],
    ['Profile', Routes.retailerProfile, '', ''],
    ['Internal', Routes.retailerInternalView, '', '']
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: device == ScreenSize.small ? 100.0.wp : 100.0.wp - 130,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        // direction: device == ScreenSize.small ? Axis.vertical : Axis.horizontal,
        children: [
          if (device != ScreenSize.small)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  for (int i = 0; i < tabs.length; i++)
                    NavButton(
                      onTap: () {
                        var path = {"ttx": ttx!, "uid": uid!};
                        if (tabs[i][2].isNotEmpty) {
                          path.addAll({"page": tabs[i][2]});
                        }
                        context.goNamed(tabs[i][1], queryParameters: path);
                      },
                      isBottom: tabs[i][1].toLowerCase() ==
                              Utils.narrateFunction(
                                      ModalRoute.of(context)!.settings.name!)
                                  .toLowerCase() ||
                          tabs[i][3].toLowerCase() ==
                              Utils.narrateFunction(
                                      ModalRoute.of(context)!.settings.name!)
                                  .toLowerCase(),
                      text: tabs[i][0],
                    ),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SubmitButton(
                  color: AppColors.webButtonColor,
                  isRadius: false,
                  height: 40,
                  width: 80,
                  onPressed: () {
                    context.goNamed(Routes.retailer,
                        pathParameters: {'page': "1"});
                    // model.goBack(context);
                  },
                  text: AppLocalizations.of(context)!.viewAll,
                ),
              ],
            ),
          ),
          if (device == ScreenSize.small) popUp(context),
        ],
      ),
    );
  }

  popUp(BuildContext context) {
    return SizedBox(
      height: 45,
      child: PopupMenuWithValue(
        text: 'Retailer Details',
        color: AppColors.contextMenuTwo,
        items: [
          for (int i = 0; i < tabs.length; i++) {"t": tabs[i][0], "v": i}
        ],
        onTap: (int t) {
          var path = {"ttx": ttx!, "uid": uid!};

          for (int i = 0; i < tabs.length; i++) {
            if (tabs[i][2].isNotEmpty) {
              path.addAll({"page": tabs[i][2]});
            }
          }
          print('tabs[t][1]');
          print(tabs[t][1]);
          context.goNamed(tabs[t][1], queryParameters: path);
        },
      ),
    );
  }
}
