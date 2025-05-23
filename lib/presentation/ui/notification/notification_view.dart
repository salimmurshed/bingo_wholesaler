import '../../../data_models/enums/user_type_for_web.dart';
import '/const/all_const.dart';
import '/const/app_sizes/app_sizes.dart';
import '/const/utils.dart';
import '/presentation/widgets/cards/app_bar_text.dart';
import '/presentation/widgets/cards/shadow_card.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../const/app_extensions/time_extention.dart';
import '../../../main.dart';
import '../../widgets/cards/loader/loader.dart';
import 'notification_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NotificationViewModel>.reactive(
        viewModelBuilder: () => NotificationViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: IconButton(
                    onPressed: () {
                      model.readQrScanner(context);
                    },
                    icon: const Icon(Icons.qr_code),
                  ),
                ),
                const SizedBox(
                  width: 15.0,
                ),
              ],
              leading: IconButton(
                onPressed: () {
                  scaffoldKey.currentState!.openDrawer();
                },
                icon: Image.asset(AppAsset.moreIcon),
              ),
              backgroundColor: model.enrollment == UserTypeForWeb.retailer
                  ? AppColors.appBarColorRetailer
                  : AppColors.appBarColorWholesaler,
              title: AppBarText(AppLocalizations.of(context)!.notifications),
            ),
            body: Stack(
              children: [
                Column(
                  children: [
                    if (model.isBusy)
                      const Expanded(
                        child: Center(
                          child: LoaderWidget(),
                        ),
                      ),
                    if (!model.isBusy)
                      Expanded(
                        child: Padding(
                          padding: AppPaddings.cardPadding,
                          child: RefreshIndicator(
                            backgroundColor: AppColors.whiteColor,
                            color: AppColors.appBarColorRetailer,
                            onRefresh: () => model.getNotification(),
                            child:
                                LayoutBuilder(builder: (context, constraints) {
                              if (model.allNotifications.isEmpty) {
                                return SingleChildScrollView(
                                  physics: Utils.pullScrollPhysic,
                                  child: SizedBox(
                                    height: 80.0.hp,
                                    child: Center(
                                        child: Text(
                                      model.notificationMessage,
                                      style:
                                          AppTextStyles.dashboardHeadTitleAsh,
                                    )),
                                  ),
                                );
                              } else {
                                return SingleChildScrollView(
                                  physics: Utils.pullScrollPhysic,
                                  child: Column(
                                    children: [
                                      for (int i = 0;
                                          i < model.allNotifications.length;
                                          i++)
                                        GestureDetector(
                                          onTap: () {
                                            model.visitScreen(i);
                                          },
                                          child: ShadowCard(
                                            color: model.allNotifications[i]
                                                        .isRead ==
                                                    1
                                                ? AppColors.whiteColor
                                                : model.enrollment ==
                                                        UserTypeForWeb.retailer
                                                    ? AppColors
                                                        .appBarColorRetailerLite
                                                    : AppColors
                                                        .appBarColorWholesalerLite,
                                            isChild: true,
                                            child: SizedBox(
                                              width: 100.0.wp,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(model.allNotifications[i]
                                                      .message!),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(StringExtension
                                                        .displayTimeAgoFromTimestamp(
                                                            model
                                                                .allNotifications[
                                                                    i]
                                                                .generatedDate!,
                                                            context)),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      if (model.notificationLoadMoreButton)
                                        model.isLoaderBusy
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 20.0),
                                                child: Utils.loaderBusy(),
                                              )
                                            : Utils.loadMore(
                                                model.getNotificationLoadMore)
                                    ],
                                  ),
                                );
                              }
                            }),
                          ),
                        ),
                      ),
                  ],
                ),
                if (model.isWaiting)
                  Container(
                    child: Utils.loaderBusy(),
                    color: AppColors.bodyBusyColor,
                    height: 100.0.hp,
                    width: 100.0.wp,
                  )
              ],
            ),
          );
        });
  }
}
