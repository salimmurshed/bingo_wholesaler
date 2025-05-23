import 'dart:async';

import 'package:bingo/const/all_const.dart';
import 'package:bingo/const/web_devices.dart';
import 'package:bingo/presentation/widgets/buttons/submit_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  MapSample({this.lat = 37.42796133580664, this.long = -122.085749655962});

  final double lat;
  final double long;

  @override
  State<MapSample> createState() => MapSampleState();
}

double gLat = 0.0;
double gLong = 0.0;
String placeName = "";

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
    gLat = widget.lat;
    gLong = widget.long;
    getNewPlace(gLat, gLong).then((value) => placeName = value);
    callMap(gLat, gLong);

    setState(() {});
  }

  final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(gLat, gLong),
    zoom: 14.0,
  );

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    final marker = Marker(
      markerId: MarkerId('place_name'),
      position: LatLng(gLat, gLong),
      icon: BitmapDescriptor.defaultMarker,
      infoWindow: const InfoWindow(
        title: 'salimsalim',
        snippet: 'address',
      ),
    );
    setState(() {
      markers[MarkerId('place_name')] = marker;
    });
  }

  @override
  Widget build(BuildContext context) {
    return device == ScreenSize.wide
        ? mappingWidgetWide()
        : Scaffold(
            body: mappingWidgetSmall(),
          );
  }

  mappingWidgetSmall() {
    return Stack(
      children: [
        SizedBox(
          width: 80.0.wp,
          child: GoogleMap(
            scrollGesturesEnabled: true,
            myLocationEnabled: true,
            markers: <Marker>{
              Marker(
                  draggable: true,
                  markerId: MarkerId("1"),
                  position: LatLng(gLat, gLong),
                  icon: BitmapDescriptor.defaultMarker,
                  infoWindow: InfoWindow(
                    title: placeName,
                  ),
                  onDragEnd: ((newPosition) async {
                    setState(() {
                      gLat = newPosition.latitude;
                      gLong = newPosition.longitude;
                      getNewPlace(newPosition.latitude, newPosition.longitude)
                          .then((value) {
                        placeName = value;
                      });
                    });
                  }))
            },
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              // _controller.complete(controller);
              setState(() {
                _onMapCreated(controller);
              });
            },
          ),
        ),
        Positioned(
          top: 56.0,
          right: 10.0,
          child: FloatingActionButton(
            heroTag: "2",
            onPressed: () {
              Navigator.pop(context, {
                "lat": gLat,
                "lng": gLong,
                "place": placeName,
              });
            },
            child: const Icon(Icons.check),
          ),
        ),
      ],
    );
  }

  mappingWidgetWide() {
    return AlertDialog(
      backgroundColor: AppColors.whiteColor,
      content: SizedBox(
        height: 80.0.hp,
        width: 80.0.wp,
        child: GoogleMap(
          scrollGesturesEnabled: true,
          myLocationEnabled: true,
          markers: <Marker>{
            Marker(
                draggable: true,
                markerId: const MarkerId("1"),
                position: LatLng(gLat, gLong),
                icon: BitmapDescriptor.defaultMarker,
                infoWindow: InfoWindow(
                  title: placeName,
                ),
                onDragEnd: ((newPosition) async {
                  setState(() {
                    gLat = newPosition.latitude;
                    gLong = newPosition.longitude;
                    getNewPlace(newPosition.latitude, newPosition.longitude)
                        .then((value) {
                      placeName = value;
                    });
                  });
                }))
          },
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            // _controller.complete(controller);
            setState(() {
              _onMapCreated(controller);
            });
          },
        ),
      ),
      actions: [
        SubmitButton(
          onPressed: () {
            Navigator.pop(context, {
              "lat": gLat,
              "lng": gLong,
              "place": placeName,
            });
          },
          text: "Submit",
        )
      ],
    );
  }

  Future getNewPlace(latitude, longitude) async {
    List<Placemark> addresses =
        await placemarkFromCoordinates(latitude, longitude);

    Placemark place = addresses[0];
    debugPrint(
        "${place.street}, ${place.locality ?? place.subLocality ?? place.subAdministrativeArea},${place.postalCode},"
        " ${place.country}");
    return "${place.street}, ${place.locality ?? place.subLocality}, ${place.postalCode},  ${place.country}";
  }

  callMap(lat, lng) async {
    CameraPosition _kLake = CameraPosition(target: LatLng(lat, lng), zoom: 14);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
