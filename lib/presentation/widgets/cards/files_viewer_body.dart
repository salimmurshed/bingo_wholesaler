import 'dart:io';

import '/const/all_const.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

import '../../../app/locator.dart';
import '../../../services/navigation/navigation_service.dart';
import '../alert/image_viewer.dart';
import '../alert/pdf_viewer.dart';

class FilesViewerBody extends StatelessWidget {
  FilesViewerBody(this.files, {Key? key}) : super(key: key);
  final _navigationService = locator<NavigationService>();

  List<File> files;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.0.wp,
      child: Wrap(
        runSpacing: 10,
        children: [
          for (var data in files)
            SizedBox(
              height: 100.0,
              child: p.extension(data.path).replaceAll(".", "") == "pdf"
                  ? GestureDetector(
                      onTap: () {
                        viewFile(data.path);
                      },
                      child: Image.asset(AppAsset.pdfImage),
                    )
                  : p.extension(data.path).replaceAll(".", "") == "png"
                      ? GestureDetector(
                          onTap: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            viewImage(data.path, true);
                          },
                          child: Image.asset(AppAsset.pngImage),
                        )
                      : GestureDetector(
                          onTap: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            viewImage(data.path, true);
                          },
                          child: Image.asset(AppAsset.jpgImage),
                        ),
            ),
        ],
      ),
    );
  }

  void viewFile(pdf) async {
    _navigationService.animatedDialog(PdfViewer(
      pdf: pdf,
      isFile: true,
    ));
  }

  void viewImage(String image, bool isfile) {
    _navigationService.animatedDialog(ImageViewer(
      image: image,
      isFile: isfile,
    ));
  }
}
