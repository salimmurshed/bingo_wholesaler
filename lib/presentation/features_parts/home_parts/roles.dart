import '/const/all_const.dart';
import '/data_models/models/component_models/retailer_role_model.dart';
import '/presentation/widgets/cards/shadow_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Roles extends StatelessWidget {
  const Roles(this.retailerRolesList, {Key? key}) : super(key: key);
  final RetailerRolesData retailerRolesList;

  @override
  Widget build(BuildContext context) {
    List<String> descriptions =
        retailerRolesList.roleDescription!.split("<br>");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColorRetailer,
        title: Text(retailerRolesList.roleName!.toUpperCase()),
        centerTitle: true,
      ),
      backgroundColor: AppColors.backgroundSecondary,
      body: ShadowCard(
        child: SizedBox(
          width: 100.0.wp,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppLocalizations.of(context)!.description,
                style: AppTextStyles.retailerStoreCard,
              ),
              10.0.giveHeight,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: descriptions.map<Widget>((String e) {
                  return Text('\u2022 $e');
                }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
