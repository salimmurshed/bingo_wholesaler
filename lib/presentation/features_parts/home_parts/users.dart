import '/const/all_const.dart';
import '/presentation/widgets/buttons/cancel_button.dart';
import '/presentation/widgets/buttons/submit_button.dart';
import '/presentation/widgets/cards/shadow_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stacked/stacked.dart';

import '../../../const/app_sizes/app_sizes.dart';
import '../../../const/utils.dart';
import '../../ui/home_screen/home_screen_view_model.dart';
import '../../widgets/cards/loader/loader.dart';

class UserDetails extends StackedView<HomeScreenViewModel> {
  const UserDetails(this.retailersUser, {Key? key}) : super(key: key);
  final String retailersUser;

  @override
  Widget builder(
    BuildContext context,
    HomeScreenViewModel viewModel,
    Widget? child,
  ) {
    viewModel.getUserDetails(retailersUser);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColorRetailer,
        title: Text(AppLocalizations.of(context)!.userDetails.toUpperCase()),
        centerTitle: true,
      ),
      backgroundColor: AppColors.backgroundSecondary,
      body: viewModel.isBusy
          ? SizedBox(
              width: 100.0.wp,
              height: 100.0.hp,
              child: const Center(
                child: LoaderWidget(),
              ),
            )
          : Padding(
              padding: AppPaddings.bodyVertical,
              child: ShadowCard(
                child: SizedBox(
                  width: 100.0.wp,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "${viewModel.usersData.firstName} ${viewModel.usersData.lastName}",
                        style: AppTextStyles.retailerStoreCard,
                      ),
                      const Divider(
                        color: AppColors.dividerColor,
                      ),
                      SizedBox(
                        width: 100.0.wp,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.status,
                              style: AppTextStyles.dashboardHeadTitle,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Image.asset(
                                  AppAsset.statusIcon,
                                  color: viewModel.usersData.status == 1
                                      ? AppColors.statusVerified
                                      : AppColors.statusReject,
                                ),
                                Text(
                                  viewModel.statusCheckUser(
                                      viewModel.usersData.statusDescription),
                                  // maxLines: 1,
                                  textAlign: TextAlign.end,
                                  softWrap: true,
                                  style: AppTextStyles.statusCardStatus
                                      .copyWith(
                                          color: viewModel.usersData.status == 1
                                              ? AppColors.statusVerified
                                              : AppColors.statusReject),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: AppColors.dividerColor,
                      ),
                      Utils.getNiceText(
                          '${AppLocalizations.of(context)!.email}: ${viewModel.usersData.email}'),
                      Utils.getNiceText(
                          '${AppLocalizations.of(context)!.role}: ${viewModel.usersData.role!.replaceAll(",", ", ")}'),
                      Utils.getNiceText(
                          '${AppLocalizations.of(context)!.idType}: ${viewModel.usersData.idType}'),
                      Utils.getNiceText(
                          '${AppLocalizations.of(context)!.idDocument}: ${viewModel.usersData.docId}'),
                      Utils.getNiceText(
                          '${AppLocalizations.of(context)!.stores}: ${viewModel.usersData.storeNameList}'),
                      20.0.giveHeight,
                      SizedBox(
                        width: 100.0.wp,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CancelButton(
                              onPressed: () {
                                viewModel.gotoEditUser(viewModel.usersData);
                              },
                              text: AppLocalizations.of(context)!.edit,
                            ),
                            SubmitButton(
                              onPressed: () {
                                viewModel.editUser(viewModel.usersData);
                              },
                              text: viewModel.usersData.status == 0
                                  ? AppLocalizations.of(context)!.activeButton
                                  : AppLocalizations.of(context)!
                                      .inactiveButton,
                              color: viewModel.usersData.status == 0
                                  ? AppColors.statusVerified
                                  : AppColors.statusReject,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  @override
  HomeScreenViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeScreenViewModel();
}
