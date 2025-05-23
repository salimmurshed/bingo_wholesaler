part of '../../../ui/home_screen/home_screen_view.dart';

class WholesalerTabsInSettingTab extends StatelessWidget {
  final HomeScreenViewModel model;

  const WholesalerTabsInSettingTab(this.model, {Key? key}) : super(key: key);

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
