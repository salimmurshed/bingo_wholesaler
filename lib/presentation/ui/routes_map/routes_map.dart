import '/const/all_const.dart';
import '/data_models/models/routes_details_model/routes_details_model.dart';
import '/presentation/ui/routes_map/routes_map_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';
import '../../../data_models/construction_model/route_zone_argument_model/route_zone_argument_model.dart';
import '../../widgets/buttons/submit_button.dart';

class RoutesMap extends StatelessWidget {
  const RoutesMap({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RoutesMapViewModel>.reactive(
        onViewModelReady: (RoutesMapViewModel model) => model.setData(
            ModalRoute.of(context)!.settings.arguments
                as RoutesZonesArgumentData),
        viewModelBuilder: () => RoutesMapViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(model.locationData.routeId!),
              centerTitle: true,
              backgroundColor: AppColors.appBarColorWholesaler,
            ),
            body: Stack(
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: model.kGooglePlex,
                  markers: <Marker>{
                    Marker(
                      draggable: true,
                      markerId: MarkerId(model.locationData.storeName!),
                      position: LatLng(
                          double.parse(model.locationData.latitude!.isEmpty
                              ? '0.0'
                              : model.locationData.latitude!),
                          double.parse(model.locationData.longitude!.isEmpty
                              ? '0.0'
                              : model.locationData.longitude!)),
                      icon: BitmapDescriptor.defaultMarker,
                      infoWindow: InfoWindow(
                        title: model.locationData.storeAddress,
                      ),
                    )
                  },
                  onMapCreated: (GoogleMapController controller) {
                    model.controllerCompleter.complete(controller);
                  },
                ),
                Positioned(
                  bottom: 0.0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 36.0),
                    // height: 50.0,
                    color: AppColors.background,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.inactiveButtonColor,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: model.locationData.visitOrder == 0
                                    ? const Icon(
                                        Icons.clear,
                                        color: AppColors.redColor,
                                      )
                                    : Text(model.locationData.visitOrder
                                        .toString()),
                              ),
                            ),
                            10.0.giveWidth,
                            Image.asset(
                              AppAsset.house,
                              height: 32.0,
                            ),
                            10.0.giveWidth,
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  model.locationData.storeName!,
                                  style: AppTextStyles.headerText,
                                ),
                                SizedBox(
                                  width: 70.0.wp,
                                  child: Text(
                                    model.locationData.storeAddress!,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles.successStyle,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        10.0.giveHeight,
                        Row(
                          children: [
                            SubmitButton(
                              text: "nueva venta",
                              onPressed: model.gotoAddSale,
                              width: 40.0.wp,
                            ),
                            SubmitButton(
                              text: "listo",
                              onPressed: () {},
                              width: 40.0.wp,
                            ),
                          ],
                        ),
                        50.0.giveHeight,
                      ],
                    ),
                  ),
                )
              ],
            ),
            // floatingActionButton: FloatingActionButton.extended(
            //   onPressed: _goToTheLake,
            //   label: const Text('To the lake!'),
            //   icon: const Icon(Icons.directions_boat),
            // ),
          );
        });
  }
}
