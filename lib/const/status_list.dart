import '/const/all_const.dart';

import '../data_models/models/status_list_model.dart';

List<StatusListModel> statusList = [
  StatusListModel(
    text: AppString.active,
    color: AppColors.statusVerified,
  ),
  StatusListModel(
    text: AppString.salePandingApproval,
    color: AppColors.statusReject,
  ),
  StatusListModel(
    text: AppString.pendingWholesalerReview,
    color: AppColors.statusProgress,
  ),
  StatusListModel(
    text: AppString.salePendingApproval,
    color: AppColors.statusReject,
  ),
  StatusListModel(
    text: AppString.saleApproval,
    color: AppColors.statusVerified,
  ),
  StatusListModel(
    text: AppString.saleDelivered,
    color: AppColors.statusVerified,
  )
];
