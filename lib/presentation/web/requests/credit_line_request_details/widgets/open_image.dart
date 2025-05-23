import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';

import '../../../../../const/app_colors.dart';

class OpenImage extends StatelessWidget {
  const OpenImage({this.img, Key? key}) : super(key: key);
  final String? img;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.whiteColor,
      icon: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      content: ImageNetwork(
        image: img!,
        height: 500,
        width: 500,
      ),
    );
  }
}
