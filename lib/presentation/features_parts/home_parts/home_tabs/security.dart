import 'package:bingo/const/all_const.dart';
import 'package:bingo/const/utils.dart';
import 'package:bingo/presentation/ui/home_screen/home_screen_view_model.dart';
import 'package:bingo/presentation/widgets/cards/shadow_card.dart';
import 'package:flutter/material.dart';
import '../../../widgets/buttons/submit_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Security extends StatelessWidget {
  const Security({Key? key, required this.model}) : super(key: key);
  final HomeScreenViewModel model;

  @override
  Widget build(BuildContext context) {
    model.checkPin();
    return SizedBox(
      height: 100.0.hp,
      width: 100.0.wp,
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShadowCard(
                          // isChild: true,
                          child: SizedBox(
                            width: 100.0.wp,
                            child: model.isBusy
                                ? Center(
                                    child: Utils.loaderBusy(),
                                  )
                                : Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            model.isBioEnable
                                                ? AppLocalizations.of(context)!
                                                    .disableBio
                                                : AppLocalizations.of(context)!
                                                    .enableBio,
                                            style: AppTextStyles
                                                .salesScannerDialog
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                          Switch(
                                            activeColor: AppColors.greenColor,
                                            inactiveThumbColor:
                                                AppColors.redColor,
                                            trackOutlineColor:
                                                MaterialStateProperty
                                                    .resolveWith((states) {
                                              // If the button is pressed, return green, otherwise blue
                                              if (states.contains(
                                                  MaterialState.pressed)) {
                                                return AppColors.redColor;
                                              }
                                              return AppColors.redColor;
                                            }),
                                            thumbIcon: MaterialStateProperty
                                                .resolveWith<Icon?>(
                                              (Set<MaterialState> states) {
                                                if (states.contains(
                                                    MaterialState.selected)) {
                                                  return const Icon(
                                                    Icons.check,
                                                    color: AppColors.whiteColor,
                                                  );
                                                }
                                                return const Icon(Icons.close);
                                              },
                                            ),
                                            activeTrackColor:
                                                AppColors.appBarColorWholesaler,
                                            value: model.isBioEnable,
                                            onChanged: (bool value) {
                                              model.changeSecurityBio(
                                                  value, context);
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                        10.0.giveHeight,
                        ShadowCard(
                          child: SizedBox(
                            width: 100.0.wp,
                            child: model.isBusy
                                ? Center(
                                    child: Utils.loaderBusy(),
                                  )
                                : Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!
                                                .pinChange,
                                            style: AppTextStyles
                                                .salesScannerDialog
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                          model.busy(model.openPinDialogBox)
                                              ? Utils.webLoader()
                                              : SubmitButton(
                                                  width: 100,
                                                  onPressed:
                                                      model.openPinDialog,
                                                  text: AppLocalizations.of(
                                                          context)!
                                                      .pinChange,
                                                ),
                                        ],
                                      ),
                                    ],
                                  ),
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
    );
  }
}
