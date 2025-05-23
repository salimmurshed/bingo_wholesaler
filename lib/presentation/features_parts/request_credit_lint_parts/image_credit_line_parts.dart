part of '../../ui/add_credit_line_screen/add_credit_line_view.dart';

class ImageCreditLineParts extends StatelessWidget {
  ImageCreditLineParts(this.model, {Key? key}) : super(key: key);
  AddCreditLineViewModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.files,
          style: AppTextStyles.dashboardBodyTitle,
        ),
        const Divider(
          color: AppColors.dividerColor,
        ),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          alignment: WrapAlignment.spaceBetween,
          children: [
            for (var i = 0; i < model.fileList.length; i++)
              if (model.fileList[i].retailerDocument!.isNotEmpty)
                Container(
                  margin: const EdgeInsets.only(bottom: 10.0),
                  width: 100.0,
                  decoration: AppBoxDecoration.borderDecoration,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 100.0,
                        child: SizedBox(
                          child: Stack(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  print(model.fileList[i].retailerDocument!
                                      .split(".")
                                      .last);
                                  model.fileList[i].retailerDocument!
                                              .split(".")
                                              .last ==
                                          SpecialKeys.pdf
                                      ? model.viewPdf(
                                          model.fileList[i].retailerDocument!)
                                      : model.viewImage(
                                          model.fileList[i].retailerDocument!);
                                  print(model.fileList[i].retailerDocument!);
                                },
                                child: model.fileList[i].retailerDocument!
                                            .split(".")
                                            .last ==
                                        SpecialKeys.pdf
                                    ? Image.asset(
                                        AppAsset.pdfImage,
                                        fit: BoxFit.fitWidth,
                                      )
                                    : Image.asset(
                                        AppAsset.fileImage,
                                        fit: BoxFit.fitWidth,
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          ],
        ),
      ],
    );
  }
}
