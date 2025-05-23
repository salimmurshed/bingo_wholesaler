import 'package:flutter/foundation.dart';

enum StatusNames {
  saleApprovalDelivered,
  salePendingApproval,
  procesada,
  confirmed,
  pending,
  current,
  active,
  pendingWholesalerReview,
  inProcess,
  verified,
  rejected,
  processed,
  completed,
  pendingFieForward,
  onEvaluationAssociationPending,
  accepted,
  onEvaluation,
  waitingReply,
  error,
  fieQueue,
  associationPendingFieQueue,
  waitingReplyAssociationPending,
  approved,
  associationPendingRecommended,
  inactive,
  recommended,
  formalized,
}

//FIE queue
//Association Pending / FIE Queue
//Waiting Reply/Association Pending
//Approved
//Association Pending/Recommended
//Inactive
//Recommended
//Formalized

StatusNames convertToStatusNames(String value) {
  bool v = (StatusNames.values.any((e) => describeEnum(e) == value));
  if (!v) {
    return StatusNames.values.firstWhere((e) => describeEnum(e) == 'error');
  } else {
    return StatusNames.values.firstWhere((e) => describeEnum(e) == value);
  }
}
