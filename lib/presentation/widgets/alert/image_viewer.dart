import 'dart:io';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '/const/all_const.dart';
import 'package:flutter/material.dart';

class ImageViewer extends StatelessWidget {
  const ImageViewer({super.key, this.image = "", this.isFile = false});

  final String image;
  final bool isFile;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.whiteColor,
      content: Stack(
        children: [
          image.split(".").last.toLowerCase() == "jpg" ||
                  image.split(".").last.toLowerCase() == "png"
              ? Container(
                  color: AppColors.whiteColor,
                  // height: 70.0.hp,
                  width: 80.0.wp,
                  child: isFile
                      ? Image.file(
                          File(image),
                          fit: BoxFit.cover,
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 60.0),
                          child: Image.network(
                            image,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                )
              : Container(
                  color: AppColors.whiteColor,
                  height: 20.0.hp,
                  width: 80.0.wp,
                  child: Center(
                      child: Text(
                          AppLocalizations.of(context)!.notSupportedFormat))),
          Positioned(
            top: 0.0,
            right: 0.0,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.clear,
                size: 16.0,
              ),
            ),
          )
        ],
      ),
    );
  }
}
