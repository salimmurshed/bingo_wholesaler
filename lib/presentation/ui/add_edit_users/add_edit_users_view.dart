import 'package:bingo/data_models/enums/user_roles_files.dart';
import 'package:bingo/presentation/widgets/text/common_text.dart';

import '../../widgets/cards/loader/loader.dart';
import '/const/all_const.dart';
import '/const/app_extensions/strings_extention.dart';
import '/presentation/widgets/buttons/submit_button.dart';
import '/presentation/widgets/cards/shadow_card.dart';
import '/presentation/widgets/dropdowns/selected_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:stacked/stacked.dart';
import '../../../const/app_styles/app_box_decoration.dart';
import '../../../const/utils.dart';
import '../../../data_models/models/component_models/retailer_role_model.dart';
import '../../../data_models/models/component_models/tax_id_type_model.dart';
import '../../../data_models/models/retailer_users_model/retailer_users_model.dart';
import '../../../data_models/models/store_model/store_model.dart';
import '../../widgets/dropdowns/multi_select_item.dart';
import '../../widgets/text_fields/name_text_field.dart';
import 'add_edit_users_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddEditUsersView extends StatelessWidget {
  const AddEditUsersView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddEditUsersViewModel>.reactive(
        viewModelBuilder: () => AddEditUsersViewModel(),
        onViewModelReady: (AddEditUsersViewModel model) {
          if (ModalRoute.of(context)!.settings.arguments != null) {
            model.setDetails(ModalRoute.of(context)!.settings.arguments
                as RetailerUsersData);
          }
        },
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(model.title),
              centerTitle: true,
              backgroundColor: AppColors.appBarColorRetailer,
            ),
            body: SingleChildScrollView(
              child: ShadowCard(
                child: SizedBox(
                  width: 100.0.wp,
                  child: model.isButtonBusy
                      ? SizedBox(
                          width: 100.0.wp,
                          height: 100.0.hp,
                          child: const Center(
                            child: LoaderWidget(),
                          ),
                        )
                      : model.taxIdType == null
                          ? SizedBox(
                              width: 100.0.wp,
                              height: 100.0.hp,
                              child: const Center(
                                child: LoaderWidget(),
                              ),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                NameTextField(
                                  isCapital: true,
                                  fieldName: AppLocalizations.of(context)!
                                      .firstName
                                      .isRequired,
                                  hintText:
                                      AppLocalizations.of(context)!.firstName,
                                  controller: model.firstNameController,
                                ),
                                if (model.errorFirstNameMessage.isNotEmpty)
                                  Text(
                                    model.errorFirstNameMessage,
                                    style: AppTextStyles.errorTextStyle,
                                  ),
                                20.0.giveHeight,
                                NameTextField(
                                  isCapital: true,
                                  fieldName: AppLocalizations.of(context)!
                                      .lastName
                                      .isRequired,
                                  hintText:
                                      AppLocalizations.of(context)!.lastName,
                                  controller: model.lastNameController,
                                ),
                                if (model.errorLastNameMessage.isNotEmpty)
                                  Text(
                                    model.errorLastNameMessage,
                                    style: AppTextStyles.errorTextStyle,
                                  ),
                                20.0.giveHeight,
                                NameTextField(
                                  fieldName: AppLocalizations.of(context)!
                                      .email
                                      .isRequired,
                                  hintText: AppLocalizations.of(context)!.email,
                                  controller: model.emailNameController,
                                ),
                                if (model.errorEmailNameMessage.isNotEmpty)
                                  Text(
                                    model.errorEmailNameMessage,
                                    style: AppTextStyles.errorTextStyle,
                                  ),
                                20.0.giveHeight,
                                SelectedDropdown<TaxIdTypeData>(
                                  hintText:
                                      AppLocalizations.of(context)!.idType,
                                  fieldName: AppLocalizations.of(context)!
                                      .idType
                                      .isRequired,
                                  dropdownValue: model.selectedTaxIdType,
                                  items: (model.taxIdType ?? [])
                                      .map((e) =>
                                          DropdownMenuItem<TaxIdTypeData>(
                                            value: e,
                                            child: Text(e.taxIdType!),
                                          ))
                                      .toList(),
                                  onChange: (v) {
                                    model.changeIdType(v);
                                  },
                                ),
                                if (model.errorIdTypeMessage.isNotEmpty)
                                  Text(
                                    model.errorIdTypeMessage,
                                    style: AppTextStyles.errorTextStyle,
                                  ),
                                20.0.giveHeight,
                                NameTextField(
                                  fieldName: AppLocalizations.of(context)!
                                      .idDocument
                                      .isRequired,
                                  hintText:
                                      AppLocalizations.of(context)!.idDocument,
                                  controller: model.idDocumentNameController,
                                ),
                                if (model.errorIdDocNameMessage.isNotEmpty)
                                  Text(
                                    model.errorIdDocNameMessage,
                                    style: AppTextStyles.errorTextStyle,
                                  ),
                                20.0.giveHeight,
                                if (!model.isUserHaveAccess(
                                    UserRolesFiles.selectStoreEditUser))
                                  CommonText(
                                    AppLocalizations.of(context)!
                                        .selectStore
                                        .isRequired,
                                    style: AppTextStyles.formTitleTextStyle
                                        .copyWith(color: AppColors.blackColor),
                                  ),
                                if (model.isUserHaveAccess(
                                    UserRolesFiles.selectStoreEditUser))
                                  InkWell(
                                    onTap: () async {
                                      await showDialog(
                                          context: context,
                                          builder: (ctx) {
                                            return MultiSelectItemWidget<
                                                StoreData>(
                                              items: model.storeList
                                                  .map((e) => MultiSelectItem<
                                                      StoreData>(e, e.name!))
                                                  .toList(),
                                              data: model.selectedStoreList,
                                              onChange: (List<StoreData>? v) {
                                                model.getSelectedStore(v!);
                                              },
                                            );
                                          });
                                    },
                                    child: IgnorePointer(
                                      child: NameTextField(
                                        fieldName: AppLocalizations.of(context)!
                                            .selectStore
                                            .isRequired,
                                        hintText: AppLocalizations.of(context)!
                                            .selectStore,
                                      ),
                                    ),
                                  ),
                                if (model.errorStoreMessage.isNotEmpty)
                                  Text(
                                    model.errorStoreMessage,
                                    style: AppTextStyles.errorTextStyle,
                                  ),
                                SizedBox(
                                  width: 100.0.wp,
                                  child: Wrap(
                                    children: [
                                      for (var e in model.selectedStoreList)
                                        Container(
                                          margin: const EdgeInsets.all(4.0),
                                          decoration:
                                              AppBoxDecoration.borderDecoration,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Text(e.name!),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                20.0.giveHeight,
                                if (!model.isUserHaveAccess(
                                    UserRolesFiles.selectRoleEditUser))
                                  CommonText(
                                    AppLocalizations.of(context)!
                                        .role
                                        .isRequired,
                                    style: AppTextStyles.formTitleTextStyle
                                        .copyWith(color: AppColors.blackColor),
                                  ),
                                if (model.isUserHaveAccess(
                                    UserRolesFiles.selectRoleEditUser))
                                  InkWell(
                                    onTap: () async {
                                      await showDialog(
                                          context: context,
                                          builder: (ctx) {
                                            return MultiSelectItemWidget<
                                                RetailerRolesData>(
                                              items: model.retailerRolesList
                                                  .map((e) => MultiSelectItem<
                                                          RetailerRolesData>(
                                                      e, e.roleName!))
                                                  .toList(),
                                              data: model.selectedRetailerRoles,
                                              onChange:
                                                  (List<RetailerRolesData>? v) {
                                                model.getSelectedRoles(v!);
                                              },
                                            );
                                          });
                                    },
                                    child: IgnorePointer(
                                      child: NameTextField(
                                        fieldName: AppLocalizations.of(context)!
                                            .role
                                            .isRequired,
                                        hintText:
                                            AppLocalizations.of(context)!.role,
                                      ),
                                    ),
                                  ),
                                if (model.errorRoleMessage.isNotEmpty)
                                  Text(
                                    model.errorRoleMessage,
                                    style: AppTextStyles.errorTextStyle,
                                  ),
                                SizedBox(
                                  width: 100.0.wp,
                                  child: Wrap(
                                    children: [
                                      for (var e in model.selectedRetailerRoles)
                                        Container(
                                          margin: const EdgeInsets.all(4.0),
                                          decoration:
                                              AppBoxDecoration.borderDecoration,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Text(e.roleName!),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                20.0.giveHeight,
                                SelectedDropdown<String>(
                                  hintText:
                                      AppLocalizations.of(context)!.status,
                                  fieldName:
                                      AppLocalizations.of(context)!.status,
                                  dropdownValue: model.status,
                                  items: model.allStatus
                                      .map((e) => DropdownMenuItem<String>(
                                            value: e,
                                            child: Text(e),
                                          ))
                                      .toList(),
                                  onChange: (v) {
                                    model.changeStatus(v);
                                  },
                                ),
                                20.0.giveHeight,
                                if (model.isUserHaveAccess(
                                    UserRolesFiles.addEditEditUser))
                                  model.isButtonBusy
                                      ? Utils.loaderBusy()
                                      : SubmitButton(
                                          onPressed: model.addEditUser,
                                          width: 100.0.wp,
                                          height: 45.0,
                                          text: model.addButtonText,
                                        )
                              ],
                            ),
                ),
              ),
            ),
          );
        });
  }
}
