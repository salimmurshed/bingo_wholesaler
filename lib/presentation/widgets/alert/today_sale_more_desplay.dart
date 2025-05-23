import 'dart:io';

import 'package:bingo/const/all_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../ui/fourth_tab/fourth_tab_view_model.dart';

class TodaySaleMoreDisplay extends StatelessWidget {
  const TodaySaleMoreDisplay(this.k, this.viewModel,
      {Key? key,
      this.isPending = true,
      this.saleId = "",
      required this.locationData})
      : super(key: key);
  final int k;
  final FourthTabViewModel viewModel;
  final bool isPending;
  final String saleId;
  final Map<String, String> locationData;

  String getUrl() {
    if (Platform.isIOS) {
      return 'https://maps.apple.com/?q=${locationData['latDir']},${locationData['longDir']}';
    } else {
      return 'https://www.google.com/maps/search/?api=1&query=${locationData['latDir']},${locationData['longDir']}&travelmode=driving';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isPending)
            buildRow(
              AppAsset.icMarkAsDone,
              AppLocalizations.of(context)!.markAsDone,
              onTap: () {
                Navigator.pop(context);
                viewModel.markAsDone(k, saleId: saleId);
              },
            ),
          // if (isPending) 24.0.giveHeight,
          // if (isPending)
          //   buildRow(
          //     viewModel.todayRouteList.pendingToAttendStores![k].sales!.isEmpty
          //         ? AppAsset.icAddSales
          //         : AppAsset.executeButton,
          //     viewModel.todayRouteList.pendingToAttendStores![k].sales!.isEmpty
          //         ? AppLocalizations.of(context)!.addSales
          //         : AppLocalizations.of(context)!.execute,
          //     onTap: () {
          //       Navigator.pop(context);
          //       viewModel
          //               .todayRouteList.pendingToAttendStores![k].sales!.isEmpty
          //           ? viewModel.saleAddition(
          //               viewModel.todayRouteList.pendingToAttendStores![k],
          //               true)
          //           : viewModel.salesExecution(viewModel
          //               .todayRouteList.pendingToAttendStores![k].sales![0]);
          //     },
          //   ),
          if (isPending) 24.0.giveHeight,
          if (isPending)
            buildRow(
              AppAsset.icDecline,
              AppLocalizations.of(context)!.decline,
              onTap: () {
                Navigator.pop(context);
                viewModel.declineSale(k, saleId: saleId);
              },
            ),
          if (!isPending)
            buildRow(
              AppAsset.reopenBottom2,
              AppLocalizations.of(context)!.reopen,
              onTap: () {
                Navigator.pop(context);
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  viewModel.reOpenClosedTask(
                      storeId: viewModel
                          .todayRouteList.completedStores![k].retailerStoreId!,
                      routeId:
                          viewModel.todayRouteList.completedStores![k].routeId,
                      saleId: saleId);
                });
              },
            ),
          24.0.giveHeight,
          buildRow(
            AppAsset.icOpenInMap,
            AppLocalizations.of(context)!.openInMap,
            onTap: () async {
              Navigator.pop(context);
              if (!await launchUrl(Uri.parse(getUrl()))) {
                throw Exception('Could not launch $getUrl');
              }
            },
          ),
        ],
      ),
    );
  }

  InkWell buildRow(String img, String text, {required Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Image.asset(
            img,
            height: 40.0,
            width: 40.0,
            fit: BoxFit.fill,
          ),
          10.0.giveWidth,
          Text(text)
        ],
      ),
    );
  }
}
