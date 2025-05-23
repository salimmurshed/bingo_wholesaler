import '/presentation/ui/view_manage_account/view_manage_account_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../data_models/models/retailer_bank_list/retailer_bank_list.dart';

class ViewManageAccountView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ViewManageAccountViewModel>.reactive(
        viewModelBuilder: () => ViewManageAccountViewModel(),
        onModelReady: (ViewManageAccountViewModel model) {
          model.setData(ModalRoute.of(context)!.settings.arguments
              as RetailerBankListData);
        },
        builder: (context, model, child) {
          return Scaffold(
            body: Text(model.bankDetails!.fieName!),
          );
        });
  }
}
