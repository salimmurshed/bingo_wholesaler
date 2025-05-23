import '../../../data_models/enums/user_type_for_web.dart';
import '/const/all_const.dart';
import '/const/utils.dart';
import '/presentation/ui/routes_details/routes_details_view_model.dart';
import '/presentation/widgets/cards/todo_card.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../data_models/construction_model/routes_argument_model/routes_argument_model.dart';

class RouteDetails extends StatelessWidget {
  const RouteDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RouteDetailsViewModel>.reactive(
        onViewModelReady: (RouteDetailsViewModel model) => model.setData(
            ModalRoute.of(context)!.settings.arguments
                as RoutesZoneArgumentModel),
        viewModelBuilder: () => RouteDetailsViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: model.enrollment == UserTypeForWeb.retailer
                  ? AppColors.appBarColorRetailer
                  : AppColors.appBarColorWholesaler,
              title: Text(model.routesZoneArgument!.routeId),
            ),
            body: model.isBusy
                ? Center(
                    child: Utils.loaderBusy(),
                  )
                : model.isZone
                    ? SingleChildScrollView(
                        child: Column(
                          children: [
                            20.0.giveHeight,
                            for (int i = 0;
                                i <
                                    model.saleZonesDetailsData.locationsDetails!
                                        .length;
                                i++)
                              InkWell(
                                onTap: () {
                                  model.gotoMap(
                                      locationsDetailsSales: model
                                          .saleZonesDetailsData
                                          .locationsDetails![i]);
                                },
                                child: ToDoCard(
                                    locationsDetailsSales: model
                                        .saleZonesDetailsData
                                        .locationsDetails![i]),
                              )
                          ],
                        ),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            20.0.giveHeight,
                            for (int i = 0;
                                i <
                                    model.routesDetailsModelData
                                        .locationsDetails!.length;
                                i++)
                              InkWell(
                                onTap: () {
                                  model.gotoMap(
                                      locationsDetails: model
                                          .routesDetailsModelData
                                          .locationsDetails![i]);
                                },
                                child: ToDoCard(
                                    locationsDetail: model
                                        .routesDetailsModelData
                                        .locationsDetails![i]),
                              )
                          ],
                        ),
                      ),
          );
        });
  }
}
