import 'package:bingo/app/web_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../const/utils.dart';
import '../../widgets/web_widgets/app_bars/nav_button.dart';

class ProductNavs extends StatelessWidget {
  const ProductNavs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          NavButton(
            isBottom: Routes.productSummary ==
                Utils.narrateFunction(ModalRoute.of(context)!.settings.name!),
            text: AppLocalizations.of(context)!.promoScreen_tab1,
            onTap: () {
              context.goNamed(Routes.productSummary);
            },
          ),
          NavButton(
            isBottom: Routes.productDetailsView ==
                Utils.narrateFunction(ModalRoute.of(context)!.settings.name!),
            text: AppLocalizations.of(context)!.promoScreen_tab2,
            onTap: () {
              context.goNamed(Routes.productDetailsView);
            },
          ),
          NavButton(
            isBottom: Routes.promoCodeView ==
                Utils.narrateFunction(ModalRoute.of(context)!.settings.name!),
            text: AppLocalizations.of(context)!.promoScreen_tab3,
            onTap: () {
              context
                  .goNamed(Routes.promoCodeView, pathParameters: {"page": "1"});
            },
          ),
          NavButton(
            isBottom: Routes.creditlineView ==
                Utils.narrateFunction(ModalRoute.of(context)!.settings.name!),
            text: AppLocalizations.of(context)!.promoScreen_tab4,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
