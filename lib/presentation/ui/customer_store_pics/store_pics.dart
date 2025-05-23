import '/const/all_const.dart';
import '/const/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../const/app_sizes/app_sizes.dart';
import '../../../const/app_styles/app_box_decoration.dart';
import '../../widgets/cards/app_bar_text.dart';

class StorePics extends StatelessWidget {
  StorePics(this.storeLogo, this.signBoardPhoto, {Key? key}) : super(key: key);
  String? storeLogo;
  String? signBoardPhoto;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText(AppLocalizations.of(context)!.photos.toUpperCase()),
      ),
      body: Padding(
        padding: AppMargins.salesDetailsMainCardMargin,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.frontBusinessPhoto,
              style: AppTextStyles.statusCardTitle
                  .copyWith(fontWeight: AppFontWeighs.semiBold),
            ),
            10.0.giveHeight,
            Container(
              width: 100.0.wp,
              height: 280.0,
              padding: AppMargins.salesDetailsMainCardMargin,
              decoration: AppBoxDecoration.dashboardCardDecoration.copyWith(
                borderRadius: AppRadius.salesDetailsRadius,
              ),
              child: CachedNetworkImage(
                  imageUrl: storeLogo!,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Center(child: Utils.loaderBusy()),
                  errorWidget: (context, url, error) {
                    return SizedBox(
                      height: 248.0,
                      width: 100.0.wp,
                      child: Image.asset(
                        AppAsset.errorImage,
                        fit: BoxFit.cover,
                      ),
                    );
                  }),
            ),
            20.0.giveHeight,
            Text(
              AppLocalizations.of(context)!.signBoardPhoto,
              style: AppTextStyles.statusCardTitle
                  .copyWith(fontWeight: AppFontWeighs.semiBold),
            ),
            10.0.giveHeight,
            Container(
              width: 100.0.wp,
              height: 280.0,
              padding: AppMargins.salesDetailsMainCardMargin,
              decoration: AppBoxDecoration.dashboardCardDecoration.copyWith(
                borderRadius: AppRadius.salesDetailsRadius,
              ),
              child: CachedNetworkImage(
                  imageUrl: signBoardPhoto!,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Center(child: Utils.loaderBusy()),
                  errorWidget: (context, url, error) {
                    return SizedBox(
                      height: 248.0,
                      width: 100.0.wp,
                      child: Image.asset(
                        AppAsset.errorImage,
                        fit: BoxFit.cover,
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
