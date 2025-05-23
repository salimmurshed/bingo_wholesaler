import '/const/all_const.dart';
import '/presentation/widgets/cards/shadow_card.dart';
import 'package:flutter/material.dart';

import '../../../data_models/models/order_selection_model/order_selection_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductInSheet extends StatelessWidget {
  const ProductInSheet(this.products, {Key? key}) : super(key: key);
  final List<SkuData> products;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        50.0.giveHeight,
        SizedBox(
          height: 50.0.hp,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      AppLocalizations.of(context)!.selectProduct,
                      style: AppTextStyles.normalCopyText,
                    ),
                  ),
                  if (products.isEmpty)
                    SizedBox(
                      height: 35.0.hp,
                      child: Center(
                        child:
                            Text(AppLocalizations.of(context)!.emptyWholesaler),
                      ),
                    ),
                  for (int i = 0; i < products.length; i++)
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context, products[i]);
                      },
                      child: ShadowCard(
                        isChild: true,
                        child: Row(
                          children: [
                            Text(
                                "${products[i].sku!} | ${products[i].productDescription!} | ${products[i].unitPrice.toString()}")
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
