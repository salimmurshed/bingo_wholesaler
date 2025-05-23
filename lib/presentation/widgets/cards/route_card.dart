import '/const/all_const.dart';
import '/const/app_extensions/status.dart';
import '/const/utils.dart';

import '/presentation/widgets/cards/shadow_card.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data_models/models/routes_model/routes_model.dart';
import '../../../data_models/models/sales_zones/sales_zones.dart';

class RouteCard extends StatelessWidget {
  const RouteCard(
      {this.routes, this.salesZone, this.isDynamic = false, Key? key})
      : super(key: key);
  final RoutesModelData? routes;
  final SaleZonesData? salesZone;
  final bool isDynamic;

  @override
  Widget build(BuildContext context) {
    String date = routes != null ? routes!.updatedDate! : salesZone!.createdAt!;
    return ShadowCard(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (routes != null)
                    Center(
                      child: Image.asset(
                        AppAsset.marker,
                        height: 32.0,
                      ),
                    ),
                  if (routes != null) 10.0.giveWidth,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        routes != null ? routes!.routeId! : salesZone!.salesId!,
                        style: AppTextStyles.headerText,
                      ),
                      Text(
                        routes != null
                            ? routes!.description!
                            : salesZone!.salesZoneName!,
                        style: AppTextStyles.successStyle,
                      ),
                    ],
                  )
                ],
              ),
              statusNamesEnumFromServer(routes != null
                      ? routes!.statusDescription
                      : salesZone!.statusDescription!)
                  .toStoreStatus()
            ],
          ),
          20.0.giveHeight,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 40.0.wp,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Utils.getNiceText(
                        '${isDynamic ? AppLocalizations.of(context)!.date : AppLocalizations.of(context)!.dateUpdated}:$date',
                        nxtln: true),
                    5.0.giveHeight,
                    Utils.getNiceText(
                        '${AppLocalizations.of(context)!.retailers}: ${routes != null ? routes!.retailersCount : salesZone!.retailersCount!}'),
                  ],
                ),
              ),
              SizedBox(
                width: 40.0.wp,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Utils.getNiceText(
                        '${AppLocalizations.of(context)!.assignedTo}:${routes != null ? routes!.assignTo : salesZone!.assignTo!}',
                        nxtln: true),
                    5.0.giveHeight,
                    Utils.getNiceText(
                        '${AppLocalizations.of(context)!.stores}: ${routes != null ? routes!.storesCount : salesZone!.storesCount!}'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
