import '../../../const/special_key.dart';
import '../../../data_models/enums/user_type_for_web.dart';
import '../../../main.dart';
import '/const/all_const.dart';
import '/presentation/widgets/buttons/submit_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stacked/stacked.dart';
import '../../../app/app_secrets.dart';
import '../../../const/app_sizes/app_sizes.dart';
import '../../../const/utils.dart';
import '../../../data/data_source/languages.dart';
import '../../../data_models/models/user_model/user_model.dart';
import '../../widgets/dropdowns/selected_dropdown.dart';
import 'drawer_view_model.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MyDrawerModel>.reactive(
        onViewModelReady: (MyDrawerModel m) => m.getUserZoneRoute(),
        viewModelBuilder: () => MyDrawerModel(),
        builder: (context, model, child) {
          return GestureDetector(
            onHorizontalDragEnd: (v) {
              // do nothing
              model.isScreenBusy ? () {} : Navigator.pop(context);
            },
            child: Scaffold(
              body: model.isScreenBusy
                  ? Utils.loaderBusy()
                  : SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 360,
                            child: Stack(
                              children: [
                                Container(
                                  padding: AppPaddings.drawerCloseIconPaddingTR,
                                  color: model.enrollment ==
                                          UserTypeForWeb.retailer
                                      ? AppColors.appBarColorRetailer
                                      : AppColors.appBarColorWholesaler,
                                  width: 100.0.wp,
                                  height: 130.0,
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                      onPressed: () {
                                        scaffoldKey.currentState!.closeDrawer();
                                        // Navigator.pop(context);
                                      },
                                      icon: const Icon(
                                        Icons.arrow_back_ios,
                                        color: AppColors.whiteColor,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 50.0,
                                  child: SizedBox(
                                    width: 100.0.wp,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        model.user.data!.profileImage!
                                                .isNotEmpty
                                            ? SizedBox(
                                                height: 159.0,
                                                width: 159.0,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          160.0),
                                                  child: CachedNetworkImage(
                                                    imageUrl: model.user.data!
                                                        .profileImage!,
                                                    height: 159.0,
                                                    width: 159.0,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              )
                                            : Image.asset(
                                                AppAsset.profileImage,
                                                height: 159.0,
                                                width: 159.0,
                                              ),
                                        11.0.giveHeight,
                                        Text(
                                          model.user.data!.name!.trim() == ""
                                              ? AppLocalizations.of(context)!
                                                  .noName
                                              : model.user.data!.name!,
                                          style: AppTextStyles.drawerText,
                                        ),
                                        Text(
                                          model.user.data!.enrollmentType!
                                                      .trim() ==
                                                  ""
                                              ? AppLocalizations.of(context)!
                                                  .noName
                                              : model.user.data!.enrollmentType!
                                                          .toLowerCase() ==
                                                      "retailer"
                                                  ? AppLocalizations.of(
                                                          context)!
                                                      .retailer
                                                  : AppLocalizations.of(
                                                          context)!
                                                      .wholesaler,
                                          style: AppTextStyles.drawerText
                                              .copyWith(
                                                  fontWeight:
                                                      AppFontWeighs.semiBold),
                                        ),
                                        10.0.giveHeight,
                                        SubmitButton(
                                          onPressed: model.gotoProfile,
                                          color: AppColors.borderColors,
                                          active: false,
                                          width: 167.0,
                                          height: 45.0,
                                          text: AppLocalizations.of(context)!
                                              .editProfile,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              if (model.enrollment == UserTypeForWeb.wholesaler)
                                5.0.giveHeight,
                              if (model.enrollment == UserTypeForWeb.wholesaler)
                                SizedBox(
                                  width: 322.0,
                                  child: SelectedDropdown<UserZoneRouteModel>(
                                      onChange: (UserZoneRouteModel value) {
                                        if (value.id!.isNotEmpty) {
                                          model.changeSaleZoneRoute(
                                              context, value);
                                        }
                                      },
                                      dropdownValue: model.selectedZoneRoute,
                                      hintText: AppLocalizations.of(context)!
                                          .salesZoneRoute,
                                      fieldName: AppLocalizations.of(context)!
                                          .salesZoneRoute,
                                      items: [
                                        for (UserZoneRouteModel item
                                            in model.userZoneRouteModel)
                                          DropdownMenuItem<UserZoneRouteModel>(
                                            value: item,
                                            child: Container(
                                              height: 48.0,
                                              width: double.infinity,
                                              color: model.pendingToAttendStores ==
                                                      null
                                                  ? Colors.transparent
                                                  : model.pendingToAttendStores!
                                                          .any((element) =>
                                                              element
                                                                  .routeIdMr ==
                                                              item.id!)
                                                      ? Colors.grey.shade300
                                                      : Colors.transparent,
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  ((item.id!.isEmpty ||
                                                              item.id == "all"
                                                          ? ""
                                                          : "    ") +
                                                      item.name!),
                                                  style: TextStyle(
                                                      fontWeight: item.id!
                                                                  .isEmpty ||
                                                              item.id == "all"
                                                          ? FontWeight.bold
                                                          : FontWeight.normal),
                                                ),
                                              ),
                                            ),
                                          )
                                      ]),
                                ),
                              if (model.enrollment == UserTypeForWeb.retailer)
                                5.0.giveHeight,
                              if (model.enrollment == UserTypeForWeb.retailer)
                                SizedBox(
                                  width: 322.0,
                                  child: SelectedDropdown<Stores>(
                                      onChange: (Stores? value) {
                                        model.changeSaleStore(value!);
                                      },
                                      dropdownValue: model.selectedStore,
                                      hintText: AppLocalizations.of(context)!
                                          .salesStores,
                                      fieldName: AppLocalizations.of(context)!
                                          .salesStores,
                                      items: [
                                        DropdownMenuItem(
                                          onTap: model.setClear,
                                          value: null,
                                          child: Text(
                                              AppLocalizations.of(context)!
                                                  .all),
                                        ),
                                        for (Stores item in model.salesStores)
                                          DropdownMenuItem<Stores>(
                                            value: item,
                                            child: Text(item.name!),
                                          )
                                      ]),
                                ),
                              22.0.giveHeight,
                              // model.isBusy
                              //     ? const Center(
                              //         child: LoaderWidget(),
                              //       )
                              //     :
                              SizedBox(
                                width: 322.0,
                                child: SelectedDropdown<AllLanguage>(
                                    onChange: (AllLanguage value) {
                                      model.changeLanguage(value, context);
                                    },
                                    dropdownValue: model.selectedLanguage,
                                    hintText: AppLocalizations.of(context)!
                                        .selectLanguage,
                                    fieldName: AppLocalizations.of(context)!
                                        .selectLanguage,
                                    items: [
                                      for (AllLanguage item in model.languages)
                                        DropdownMenuItem(
                                          value: item,
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                item.file!,
                                                height: 24.0,
                                              ),
                                              10.0.giveWidth,
                                              Text(item.code!.toUpperCase()),
                                            ],
                                          ),
                                        )
                                    ]),
                              ),
                              SizedBox(
                                height: 5.0.hp,
                              ),
                              Text(SpecialKeys.appVersion.toUpperCase()),
                              SizedBox(
                                height: 2.0.hp,
                              ),
                              model.isBusy
                                  ? Utils.loaderBusy()
                                  : SubmitButton(
                                      onPressed: () {
                                        model.logout(context);
                                      },
                                      active: false,
                                      color: AppColors.borderColors,
                                      width: 99.0,
                                      height: 45.0,
                                      text:
                                          AppLocalizations.of(context)!.logout,
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ),
            ),
          );
        });
  }
}
