part of '../../../ui/home_screen/home_screen_view.dart';

class RetailerTabsInSettingTab extends StatelessWidget {
  final HomeScreenViewModel model;

  const RetailerTabsInSettingTab(this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPaddings.allTabBarPadding,
      height: 72,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SubmitButton(
              active: model.settingTabTitle == HomePageSettingTabs.users
                  ? true
                  : false,
              onPressed: () {
                model.changeSettingTab(HomePageSettingTabs.users);
              },
              width: 114.0,
              text: AppLocalizations.of(context)!.users,
            ),
            SubmitButton(
              active: model.settingTabTitle == HomePageSettingTabs.roles
                  ? true
                  : false,
              onPressed: () {
                model.changeSettingTab(HomePageSettingTabs.roles);
              },
              width: 114.0,
              text: AppLocalizations.of(context)!.roles,
            ),
            SubmitButton(
              active: model.settingTabTitle == HomePageSettingTabs.stores
                  ? true
                  : false,
              onPressed: () {
                model.changeSettingTab(HomePageSettingTabs.stores);
              },
              width: 114.0,
              text: AppLocalizations.of(context)!.stores,
            ),
            SubmitButton(
              active:
                  model.settingTabTitle == HomePageSettingTabs.manageAccounts
                      ? true
                      : false,
              onPressed: () {
                model.changeSettingTab(HomePageSettingTabs.manageAccounts);
              },
              width: 114.0,
              text: AppLocalizations.of(context)!.manageAccount,
            ),
            SubmitButton(
              active:
                  model.settingTabTitle == HomePageSettingTabs.companyProfile
                      ? true
                      : false,
              onPressed: () {
                model.changeSettingTab(HomePageSettingTabs.companyProfile);
              },
              width: 114.0,
              text: AppLocalizations.of(context)!.companyProfile,
            ),
            SubmitButton(
              active: model.settingTabTitle == HomePageSettingTabs.security
                  ? true
                  : false,
              onPressed: () {
                model.changeSettingTab(HomePageSettingTabs.security);
              },
              width: 114.0,
              text: AppLocalizations.of(context)!.security,
            ),
          ],
        ),
      ),
    );
  }
}
