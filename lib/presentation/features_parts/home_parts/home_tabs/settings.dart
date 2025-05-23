part of '../../../ui/home_screen/home_screen_view.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key, required this.model}) : super(key: key);
  final HomeScreenViewModel model;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.0.wp,
      child: Stack(
        children: [
          model.enrollment == UserTypeForWeb.retailer
              ? RetailerTabsInSettingTab(model)
              : WholesalerTabsInSettingTab(model),
          model.isBusy
              ? SizedBox(
                  width: 100.0.wp,
                  height: 100.0.hp,
                  child: const Center(
                    child: LoaderWidget(),
                  ),
                )
              : model.settingTabTitle == HomePageSettingTabs.users
                  ? users(context)
                  : model.settingTabTitle == HomePageSettingTabs.roles
                      ? roles(context)
                      : model.settingTabTitle == HomePageSettingTabs.stores
                          ? stores(context)
                          : model.settingTabTitle ==
                                  HomePageSettingTabs.manageAccounts
                              ? manageAccount(context)
                              : model.settingTabTitle ==
                                      HomePageSettingTabs.security
                                  ? Padding(
                                      padding: AppPaddings
                                          .requestSettingTabViewPadding,
                                      child: Security(model: model),
                                    )
                                  : companyProfile(context),
        ],
      ),
    );
  }

  Widget users(BuildContext context) {
    return model.busy(model.retailersUserList)
        ? SizedBox(
            width: 100.0.wp,
            height: 100.0.hp,
            child: const Center(
              child: LoaderWidget(),
            ),
          )
        : RefreshIndicator(
            backgroundColor: AppColors.whiteColor,
            color: AppColors.appBarColorRetailer,
            onRefresh: model.getRetailersUserPullToRefresh,
            child: SizedBox(
              height: 100.0.hp,
              child: Padding(
                padding: AppPaddings.requestSettingTabViewPadding,
                child: SingleChildScrollView(
                  physics: Utils.pullScrollPhysic,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (model.isUserHaveAccess(UserRolesFiles.addNewUser))
                        Padding(
                          padding: AppPaddings.allTabBarPadding,
                          child: SizedBox(
                            width: 100.0.wp,
                            height: 50.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(),
                                SubmitButton(
                                  onPressed: model.gotoAddNewUser,
                                  width: 100.0,
                                  text: AppLocalizations.of(context)!.addNew,
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (model.retailersUserList.isEmpty)
                        Utils.noDataWidget(context),
                      for (int j = 0; j < model.retailersUserList.length; j++)
                        StatusCard(
                            onTap: () {
                              model.gotoUserDetails(model.retailersUserList[j]);
                            },
                            title:
                                ("${model.retailersUserList[j].firstName!} ${model.retailersUserList[j].lastName!}")
                                    .toUpperCase(),
                            subTitle: "",
                            status:
                                model.retailersUserList[j].statusDescription!,
                            bodyFirstKey: AppLocalizations.of(context)!.email,
                            bodyFirstValue: model.retailersUserList[j].email!,
                            bodySecondKey:
                                "${AppLocalizations.of(context)!.role}:",
                            bodySecondValue: model.retailersUserList[j].role!,
                            statusWidth: 150),
                      if (model.retailUsersLoadMoreButton)
                        model.isUserLoadMoreBusy
                            ? Utils.loaderBusy()
                            : Utils.loadMore(model.loadMoreUsers)
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  Widget roles(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: AppColors.whiteColor,
      color: AppColors.appBarColorRetailer,
      onRefresh: model.getRoles,
      child: Padding(
        padding: AppPaddings.requestSettingTabViewPadding,
        child: SingleChildScrollView(
          physics: Utils.pullScrollPhysic,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (model.retailerRolesList.isEmpty) Utils.noDataWidget(context),
              for (int j = 0; j < model.retailerRolesList.length; j++)
                StatusCard(
                  onTap: () {
                    model.gotoUserRoleDetails(model.retailerRolesList[j]);
                  },
                  title: model.retailerRolesList[j].roleName!,
                  subTitle: "",
                  status: model.retailerRolesList[j].statusDescription!,
                  bodyFirstKey: "${AppLocalizations.of(context)!.date}: ",
                  bodyFirstValue: model.retailerRolesList[j].createdAt!,
                  bodySecondKey: "",
                  bodySecondValue: "",
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget stores(BuildContext context) {
    return model.isBusy
        ? SizedBox(
            width: 100.0.wp,
            height: 100.0.hp,
            child: const Center(
              child: LoaderWidget(),
            ),
          )
        : RefreshIndicator(
            backgroundColor: AppColors.whiteColor,
            color: AppColors.appBarColorRetailer,
            onRefresh: model.refreshStores,
            child: Padding(
              padding: AppPaddings.requestSettingTabViewPadding,
              child: SingleChildScrollView(
                physics: Utils.pullScrollPhysic,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (model.isUserHaveAccess(UserRolesFiles.addNewStore))
                      Padding(
                        padding: AppPaddings.allTabBarPadding,
                        child: SizedBox(
                          width: 100.0.wp,
                          height: 50.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(),
                              SubmitButton(
                                onPressed: model.gotoAddNewStore,
                                width: 100.0,
                                text: AppLocalizations.of(context)!.addNew,
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (model.storeData.isEmpty) Utils.noDataWidget(context),
                    for (int j = 0; j < model.storeData.length; j++)
                      GestureDetector(
                        onTap: () {
                          model.gotoViewStore(j);
                        },
                        child: ShadowCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 200,
                                    child: AutoSizeText(
                                      model.storeData[j].name!,
                                      // maxLines: 2,
                                      style: AppTextStyles.statusCardTitle,
                                    ),
                                  ),
                                  Expanded(
                                      child: statusNamesEnumFromServer(
                                              model.storeData[j].status!)
                                          .toStoreStatus()),
                                ],
                              ),
                              Text(
                                model.storeData[j].city!,
                                maxLines: 2,
                                style: AppTextStyles.statusCardSubTitle,
                              ),
                              Utils.getNiceText(
                                  "${AppLocalizations.of(context)!.remarks} ${model.storeData[j].remarks!}")
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
  }

  Widget companyProfile(context) {
    return RefreshIndicator(
      backgroundColor: AppColors.whiteColor,
      color: AppColors.appBarColorRetailer,
      onRefresh: model.getCompanyProfilePullToRefresh,
      child: Padding(
        padding: AppPaddings.requestSettingTabViewPadding,
        child: SingleChildScrollView(
          physics: Utils.pullScrollPhysic,
          child: ShadowCard(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NameTextField(
                    controller: model.commercialNameController,
                    fieldName:
                        AppLocalizations.of(context)!.commercialName.isRequired,
                  ),
                  if (model.commercialNameError.isNotEmpty)
                    Text(
                      model.commercialNameError,
                      style: AppTextStyles.errorTextStyle,
                    ),
                  10.0.giveHeight,
                  NameTextField(
                    controller: model.informationController,
                    fieldName:
                        AppLocalizations.of(context)!.information.isRequired,
                  ),
                  if (model.informationError.isNotEmpty)
                    Text(
                      model.informationError,
                      style: AppTextStyles.errorTextStyle,
                    ),
                  10.0.giveHeight,
                  NameTextField(
                    controller: model.mainProductController,
                    fieldName:
                        AppLocalizations.of(context)!.mainProduct.isRequired,
                  ),
                  if (model.mainProductError.isNotEmpty)
                    Text(
                      model.mainProductError,
                      style: AppTextStyles.errorTextStyle,
                    ),
                  10.0.giveHeight,
                  NameTextField(
                    controller: model.webUrlController,
                    fieldName: AppLocalizations.of(context)!.webUrl.isRequired,
                  ),
                  if (model.webUrlError.isNotEmpty)
                    Text(
                      model.webUrlError,
                      style: AppTextStyles.errorTextStyle,
                    ),
                  10.0.giveHeight,
                  InkWell(
                    onTap: model.selectDateFormedCompanyProfile,
                    child: IgnorePointer(
                      child: NameTextField(
                        controller: model.dateFoundedController,
                        fieldName: AppLocalizations.of(context)!
                            .dateFounded
                            .isRequired,
                      ),
                    ),
                  ),
                  if (model.dateFoundedError.isNotEmpty)
                    Text(
                      model.dateFoundedError,
                      style: AppTextStyles.errorTextStyle,
                    ),
                  10.0.giveHeight,
                  Text(
                    AppLocalizations.of(context)!.uploadLogo,
                    style: AppTextStyles.formTitleTextStyle
                        .copyWith(color: AppColors.blackColor),
                  ),
                  10.0.giveHeight,
                  SubmitButton(
                    onPressed: model.picImage,
                    height: 45.0,
                    width: 100.0,
                    text: AppLocalizations.of(context)!.chooseFiles,
                  ),
                  10.0.giveHeight,
                  imageSection(),
                  10.0.giveHeight,
                  NameTextField(
                    controller: model.aboutUsController,
                    maxLine: 5,
                    fieldName: AppLocalizations.of(context)!.aboutUs.isRequired,
                  ),
                  if (model.aboutUsError.isNotEmpty)
                    Text(
                      model.aboutUsError,
                      style: AppTextStyles.errorTextStyle,
                    ),
                  10.0.giveHeight,
                  if (model
                      .isUserHaveAccess(UserRolesFiles.submitCompanyProfile))
                    model.isButtonBusy
                        ? Center(
                            child: Utils.loaderBusy(),
                          )
                        : SubmitButton(
                            onPressed: model.submitCompanyProfile,
                            height: 45.0,
                            width: 100.0.wp,
                            text: AppLocalizations.of(context)!
                                .updateCompanyProfile,
                          )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget imageSection() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: AppColors.lightAshColor),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: model.uploadImage != null
          ? SizedBox(
              height: 200.0,
              width: 200.0,
              child: Stack(
                children: [
                  SizedBox(
                    height: 200.0,
                    width: 200.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: Image.file(
                        File(model.uploadImage!.path),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10.0,
                    right: 10.0,
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.accentColor,
                          borderRadius: BorderRadius.circular(50.0)),
                      child: IconButton(
                        onPressed: model.deletePickImage,
                        icon: const Icon(
                          Icons.close_sharp,
                          size: 24.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : model.image.isEmpty
              ? SizedBox(
                  height: 200.0,
                  width: 200.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: Image.asset(
                      AppAsset.logo,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : ErrorCheckImage(
                  model.image,
                  fit: BoxFit.cover,
                  height: 200.0,
                  width: 200.0,
                  longLoader: true,
                ),
    );
  }

  Widget manageAccount(context) {
    return RefreshIndicator(
      backgroundColor: AppColors.whiteColor,
      color: AppColors.appBarColorRetailer,
      onRefresh: model.refreshManageAccount,
      child: SizedBox(
        height: 100.0.hp,
        child: Padding(
          padding: AppPaddings.requestSettingTabViewPadding,
          child: SingleChildScrollView(
            physics: Utils.pullScrollPhysic,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (model.isUserHaveAccess(UserRolesFiles.addManageAccount))
                  Padding(
                    padding: AppPaddings.allTabBarPadding,
                    child: SizedBox(
                      width: 100.0.wp,
                      height: 50.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(),
                          SubmitButton(
                            onPressed: model.gotoAddManageAccount,
                            width: 100.0,
                            text: AppLocalizations.of(context)!.addNew,
                          ),
                        ],
                      ),
                    ),
                  ),
                if (model.retailsBankAccounts.isEmpty)
                  Utils.noDataWidget(context)
                else
                  for (int j = 0; j < model.retailsBankAccounts.length; j++)
                    GestureDetector(
                      onTap: () {
                        model.gotoViewManageAccount(j);
                      },
                      child: StatusCardFourPart(
                        title: model.retailsBankAccounts[j].fieName!,
                        subTitle:
                            model.retailsBankAccounts[j].updatedAtDate != null
                                ? ""
                                : DateFormat(SpecialKeys.dateFormatWithHour)
                                    .format(DateTime.parse(model
                                        .retailsBankAccounts[j]
                                        .updatedAtDate!)),
                        statusChild: model.retailsBankAccounts[j].status!
                            .toCardStatusFromInt(
                                value: model.statusForSetting(j)),
                        bodyFirstKey:
                            "${AppLocalizations.of(context)!.accType}: ${BankInfo.checkBankAccountType(model.retailsBankAccounts[j].bankAccountType!)}",
                        bodyFirstValue:
                            "${AppLocalizations.of(context)!.currencY} ${model.retailsBankAccounts[j].currency}",
                        bodySecondKey:
                            "${AppLocalizations.of(context)!.accNO}: ${model.retailsBankAccounts[j].bankAccountNumber}",
                        bodySecondValue:
                            "${AppLocalizations.of(context)!.iban}: ${model.retailsBankAccounts[j].iban}",
                      ),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
