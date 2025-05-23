import '/presentation/ui/retailer_settlements_details/retailer_settlements_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class RetailerSettlementsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RetailerSettlementsViewModel>.reactive(
        viewModelBuilder: () => RetailerSettlementsViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            body: Container(),
          );
        });
  }
}
