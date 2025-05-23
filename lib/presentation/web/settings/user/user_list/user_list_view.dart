import 'package:bingo/const/all_const.dart';
import 'package:bingo/presentation/web/settings/user/user_list/user_list_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../const/special_key.dart';
import '../../../../../const/utils.dart';
import '../../../../../const/web_devices.dart';
import '../../../../../data_models/enums/user_roles_files.dart';
import '../../../../../data_models/enums/user_type_for_web.dart';
import '../../../../widgets/buttons/submit_button.dart';
import '../../../../widgets/text_fields/name_text_field.dart';
import '../../../../widgets/web_widgets/app_bars/secondaryNameAppBar.dart';
import '../../../../widgets/web_widgets/app_bars/web_app_bar.dart';
import '../../../../widgets/web_widgets/body/pagination.dart';
import '../../../../widgets/web_widgets/body/table.dart';
import '../../../../widgets/web_widgets/cards/add_new_with_header.dart';
import '../../../../widgets/web_widgets/cards/popup_menu_with_value.dart';
import '../../../../widgets/web_widgets/website_base_body.dart';

class UserListView extends StatelessWidget {
  const UserListView({super.key, this.page});

  final String? page;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserListViewModel>.reactive(
        viewModelBuilder: () => UserListViewModel(),
        onViewModelReady: (UserListViewModel model) {
          model.getRetailerUserList(page!);
        },
        builder: (context, model, child) {
          return Scaffold(
            drawer: WebAppBar(
                onTap: (String v) {
                  model.changeTab(context, v);
                },
                tabNumber: model.tabNumber),
            appBar: device == ScreenSize.wide
                ? null
                : AppBar(
                    backgroundColor: model.enrollment == UserTypeForWeb.retailer
                        ? AppColors.bingoGreen
                        : AppColors.appBarColorWholesaler,
                    title: Row(
                      children: [
                        Expanded(
                          child: SecondaryNameAppBar(
                            h1: AppLocalizations.of(context)!.userList_header,
                          ),
                        ),
                        // if (model.enrollment == UserTypeForWeb.retailer)
                        if (model.haveAccess(UserRolesFiles.addEditEditUser))
                          Align(
                            alignment: Alignment.topRight,
                            child: SubmitButton(
                              color: AppColors.bingoGreen,
                              isRadius: false,
                              height: 40,
                              width: 80,
                              onPressed: () {
                                // Navigator.pop(context);
                                model.gotoAddUser(context);
                              },
                              text: AppLocalizations.of(context)!.addNew,
                            ),
                          ),
                      ],
                    ),
                  ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(device != ScreenSize.wide ? 0.0 : 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (device != ScreenSize.small)
                      WebAppBar(
                          onTap: (String v) {
                            model.changeTab(context, v);
                          },
                          tabNumber: model.tabNumber),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (device != ScreenSize.small)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SecondaryNameAppBar(
                                  h1: AppLocalizations.of(context)!
                                      .userList_header,
                                ),
                                // if (model.enrollment == UserTypeForWeb.retailer)
                                if (model
                                    .haveAccess(UserRolesFiles.addEditEditUser))
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: SubmitButton(
                                      color: AppColors.bingoGreen,
                                      isRadius: false,
                                      height: 40,
                                      width: 80,
                                      onPressed: () {
                                        // Navigator.pop(context);
                                        model.gotoAddUser(context);
                                      },
                                      text:
                                          AppLocalizations.of(context)!.addNew,
                                    ),
                                  ),
                              ],
                            ),
                          WebsiteBaseBody(
                            body: model.isBusy
                                ? Utils.bigLoader()
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AddNewWithHeader(
                                        label: AppLocalizations.of(context)!
                                            .userList_body,
                                      ),
                                      if (model.retailerUsersModel!.data!.data!
                                          .isEmpty)
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 16.0),
                                          child: Center(
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .noDataInTable(""),
                                              style:
                                                  AppTextStyles.noDataTextStyle,
                                            ),
                                          ),
                                        ),
                                      if (model.retailerUsersModel!.data!.data!
                                          .isNotEmpty)
                                        Scrollbar(
                                          controller: model.scrollController,
                                          thickness: 10,
                                          child: SingleChildScrollView(
                                            controller: model.scrollController,
                                            scrollDirection: Axis.horizontal,
                                            child: SizedBox(
                                              width: device != ScreenSize.wide
                                                  ? null
                                                  : 100.0.wp - 64 - 64,
                                              child: Table(
                                                defaultVerticalAlignment:
                                                    TableCellVerticalAlignment
                                                        .middle,
                                                border: TableBorder.all(
                                                    color: AppColors
                                                        .tableHeaderBody),
                                                columnWidths: {
                                                  0: const FixedColumnWidth(
                                                      70.0),
                                                  1: const FixedColumnWidth(
                                                      100.0),
                                                  2: const FixedColumnWidth(
                                                      100.0),
                                                  3: const FixedColumnWidth(
                                                      200.0),
                                                  4: const FixedColumnWidth(
                                                      200.0),
                                                  5: const FixedColumnWidth(
                                                      100.0),
                                                  6: device != ScreenSize.wide
                                                      ? const FixedColumnWidth(
                                                          150.0)
                                                      : const FlexColumnWidth(), //f
                                                  7: const FixedColumnWidth(
                                                      180.0),
                                                  8: const FixedColumnWidth(
                                                      100.0),
                                                  9: const FixedColumnWidth(
                                                      120.0),
                                                },
                                                children: [
                                                  TableRow(
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: AppColors
                                                            .tableHeaderColor,
                                                      ),
                                                      children: [
                                                        dataCellHd(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .table_sNo),
                                                        dataCellHd(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .table_firstName),
                                                        dataCellHd(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .table_lastName),
                                                        dataCellHd(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .table_email),
                                                        dataCellHd(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .table_role),
                                                        dataCellHd("Seller"),
                                                        dataCellHd(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .table_store),
                                                        dataCellHd(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .table_date),
                                                        dataCellHd(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .table_status),
                                                        dataCellHd(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .table_action),
                                                      ]),
                                                  for (int i = 0;
                                                      i <
                                                          model
                                                              .retailerUsersModel!
                                                              .data!
                                                              .data!
                                                              .length;
                                                      i++)
                                                    TableRow(
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: AppColors
                                                            .whiteColor,
                                                      ),
                                                      children: [
                                                        dataCell(
                                                            "${model.pageFrom + i}"),
                                                        dataCell(
                                                          model
                                                              .retailerUsersModel!
                                                              .data!
                                                              .data![i]
                                                              .firstName!,
                                                          isCenter: false,
                                                        ),
                                                        dataCell(
                                                          model
                                                              .retailerUsersModel!
                                                              .data!
                                                              .data![i]
                                                              .lastName!,
                                                          isCenter: false,
                                                        ),
                                                        dataCell(
                                                          model
                                                              .retailerUsersModel!
                                                              .data!
                                                              .data![i]
                                                              .email!,
                                                          isCenter: false,
                                                        ),
                                                        dataCell(
                                                          model
                                                              .retailerUsersModel!
                                                              .data!
                                                              .data![i]
                                                              .role!
                                                              .replaceAll(
                                                                  ",", ", "),
                                                          isCenter: false,
                                                        ),
                                                        dataCell(model
                                                            .retailerUsersModel!
                                                            .data!
                                                            .data![i]
                                                            .seller!),
                                                        // RichText(
                                                        //   text: TextSpan(
                                                        //       text:
                                                        //           "${model.retailerUsersModel!.data!.data![i].idType!}\n",
                                                        //       style: AppTextStyles
                                                        //           .webTableBody,
                                                        //       children: [
                                                        //         TextSpan(
                                                        //           text: model
                                                        //               .retailerUsersModel!
                                                        //               .data!
                                                        //               .data![i]
                                                        //               .seller!,
                                                        //           style: const TextStyle(
                                                        //               fontWeight:
                                                        //                   FontWeight
                                                        //                       .bold),
                                                        //         )
                                                        //       ]),
                                                        //   textAlign:
                                                        //       TextAlign.center,
                                                        // ),
                                                        dataCell(
                                                          model
                                                              .retailerUsersModel!
                                                              .data!
                                                              .data![i]
                                                              .storeNameList!,
                                                          isCenter: false,
                                                        ), //dateFormatWithHour
                                                        dataCell(DateFormat(
                                                                SpecialKeys
                                                                    .dateFormatWithHour)
                                                            .format(DateTime
                                                                .parse(model
                                                                    .retailerUsersModel!
                                                                    .data!
                                                                    .data![i]
                                                                    .createdAt!))),
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      12),
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 3),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              color: model
                                                                          .retailerUsersModel!
                                                                          .data!
                                                                          .data![
                                                                              i]
                                                                          .status! ==
                                                                      1
                                                                  ? AppColors
                                                                      .statusVerified
                                                                  : AppColors
                                                                      .statusReject),
                                                          child: Center(
                                                            child: Text(
                                                              model
                                                                  .retailerUsersModel!
                                                                  .data!
                                                                  .data![i]
                                                                  .statusDescription!,
                                                              style: const TextStyle(
                                                                  color: AppColors
                                                                      .whiteColor),
                                                            ),
                                                          ),
                                                        ),
                                                        Center(
                                                          // width: 80,
                                                          child:
                                                              PopupMenuWithValue(
                                                                  onTap:
                                                                      (int v) {
                                                                    model.action(
                                                                        v,
                                                                        context,
                                                                        model
                                                                            .retailerUsersModel!
                                                                            .data!
                                                                            .data![
                                                                                i]
                                                                            .uniqueId!,
                                                                        model
                                                                            .retailerUsersModel!
                                                                            .data!
                                                                            .data![i]
                                                                            .status!);
                                                                  },
                                                                  text: AppLocalizations.of(
                                                                          context)!
                                                                      .table_action,
                                                                  color: AppColors
                                                                      .contextMenuTwo,
                                                                  items: [
                                                                if (model.haveAccess(
                                                                    UserRolesFiles
                                                                        .editUser))
                                                                  {
                                                                    't': AppLocalizations.of(
                                                                            context)!
                                                                        .webActionButtons_edit,
                                                                    'v': 0
                                                                  },
                                                                if (model.haveAccess(
                                                                    UserRolesFiles
                                                                        .deleteUser))
                                                                  {
                                                                    't': AppLocalizations.of(
                                                                            context)!
                                                                        .webActionButtons_delete,
                                                                    'v': 1
                                                                  },
                                                                if (model
                                                                    .isMaster)
                                                                  {
                                                                    't': model.retailerUsersModel!.data!.data![i].status ==
                                                                            0
                                                                        ? AppLocalizations.of(context)!
                                                                            .webActionButtons_active
                                                                        : AppLocalizations.of(context)!
                                                                            .webActionButtons_inactive,
                                                                    'v': 2
                                                                  }
                                                              ]),
                                                        ),
                                                      ],
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      20.0.giveHeight,
                                      if (model.totalPage > 0)
                                        model.isBusy
                                            ? const SizedBox()
                                            : PaginationWidget(
                                                totalPage: model.totalPage,
                                                perPage: 10,
                                                startTo: model.pageTo,
                                                startFrom: model.pageFrom,
                                                pageNumber: model.pageNumber,
                                                total: model.dataTotal,
                                                onPageChange: (int v) {
                                                  model.changePage(context, v);
                                                })
                                    ],
                                  ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
