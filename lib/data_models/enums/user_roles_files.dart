enum UserRolesFiles {
  selectStoreEditUser,
  selectRoleEditUser,
  addEditEditUser,
  addStoreButton,
  createTemplateAddOrder,
  activeButtonSplitCreditLine,
  editSplitCreditLineButton,
  addWholesalerAssociationRequest,
  addFieAssociationRequest,
  showRetailerCreditlineStatus,
  addCreditlineRequest,
  addNewUser,
  editUser,
  deleteUser,
  addNewStore,
  submitCompanyProfile,
  addManageAccount,
  approveSales,
  pendingSaleOnDashBoard,
  saleListVisibility,
  viewStatement,
  salePaymentOption,
  accountBalanceTabVisibility,
}

class RolesWiseAccess {
  static List<UserRolesFiles> admin = [
    UserRolesFiles.addNewUser,
    UserRolesFiles.addNewStore,
    UserRolesFiles.selectStoreEditUser,
    UserRolesFiles.selectRoleEditUser,
    UserRolesFiles.addEditEditUser,
    UserRolesFiles.addStoreButton,
    UserRolesFiles.editUser,
    UserRolesFiles.deleteUser,
  ];
  static List<UserRolesFiles> finance = [
    UserRolesFiles.addWholesalerAssociationRequest,
    UserRolesFiles.addFieAssociationRequest,
    UserRolesFiles.addManageAccount,
    UserRolesFiles.addCreditlineRequest,
    UserRolesFiles.showRetailerCreditlineStatus,
    UserRolesFiles.submitCompanyProfile,
    UserRolesFiles.activeButtonSplitCreditLine,
    UserRolesFiles.editSplitCreditLineButton
  ];
  static List<UserRolesFiles> storemanager = [
    UserRolesFiles.createTemplateAddOrder,
    UserRolesFiles.approveSales,
    UserRolesFiles.pendingSaleOnDashBoard,
    UserRolesFiles.saleListVisibility,
    UserRolesFiles.viewStatement,
    UserRolesFiles.salePaymentOption,
    UserRolesFiles.accountBalanceTabVisibility,
  ];
  static List<UserRolesFiles> master =
      UserRolesFiles.values.map((e) => e).toList();
}
