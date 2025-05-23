import '/const/all_const.dart';
import '/const/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ErrorCheckImage extends StatelessWidget {
  const ErrorCheckImage(this.image,
      {this.height = 10.0,
      this.width = 10.0,
      this.fit = BoxFit.contain,
      this.longLoader = false,
      Key? key})
      : super(key: key);
  final String image;
  final double height;
  final double width;
  final BoxFit fit;
  final bool longLoader;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      height: height,
      width: width,
      fit: fit,
      placeholder: (context, url) => longLoader
          ? SizedBox(
              height: height,
              width: width,
              child: Center(
                child: Utils.loaderBusy(),
              ),
            )
          : Image.asset(AppAsset.logo),
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.colorBurn,
            ),
          ),
        ),
      ),
      errorWidget: (context, url, error) {
        return Image.asset(AppAsset.logo);
      },
    );
  }
}
