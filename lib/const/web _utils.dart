import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';

class WebUtils {
  static Widget image(
    BuildContext context,
    String imageUrl, {
    double height = 120.0,
    double width = 150.0,
  }) {
    return IgnorePointer(
      child: SizedBox(
        height: height,
        width: width,
        child: ImageNetwork(
          image: imageUrl,
          height: height,
          width: width,
          duration: 100,
          curve: Curves.easeIn,
          onPointer: true,
          debugPrint: false,
          fullScreen: false,
          fitAndroidIos: BoxFit.fill,
          fitWeb: BoxFitWeb.fill,
          borderRadius: BorderRadius.circular(200),
          onLoading: const SizedBox(),
          onError: const Icon(
            Icons.error,
            color: Colors.red,
          ),
          onTap: () {},
        ),
      ),
    );
  }
}
