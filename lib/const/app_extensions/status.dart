import '../../presentation/widgets/utils_folder/status/transaction_status_widget.dart';
import '/const/all_const.dart';
import '/data/data_source/sales_status.dart';
import 'package:flutter/material.dart';

import '../../data_models/enums/status_name.dart';
import '../../main.dart';
import '../utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension StatusExtension on StatusNames {
  Widget toStatus(
      {bool isIconAvailable = true,
      bool isCenter = false,
      TextStyle textStyle = AppTextStyles.statusCardStatus,
      double width = 150}) {
    switch (this) {
      case StatusNames.salePendingApproval:
        return statusWidget(
            isCenter: isCenter,
            text: AppLocalizations.of(activeContext)!.statusSalePendingApproval,
            color: AppColors.statusReject,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case StatusNames.fieQueue:
        return statusWidget(
            isCenter: isCenter,
            text: AppLocalizations.of(activeContext)!.statusFIEqueue,
            color: AppColors.statusQueue,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);

      case StatusNames.completed:
        return statusWidget(
            isCenter: isCenter,
            text: AppLocalizations.of(activeContext)!
                .statusCompleted, //"Completed",
            color: AppColors.statusVerified,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case StatusNames.procesada:
        return statusWidget(
            isCenter: isCenter,
            text: AppLocalizations.of(activeContext)!
                .statusProcessed, //"Procesada",
            color: AppColors.statusVerified,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case StatusNames.saleApprovalDelivered:
        return statusWidget(
            isCenter: isCenter,
            text: AppLocalizations.of(activeContext)!
                .statusSaleApprovedDelivered
                .toLowerCase(),
            color: AppColors.statusVerified,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case StatusNames.pending:
        return statusWidget(
            isCenter: isCenter,
            text: AppLocalizations.of(activeContext)!.statusPending,
            color: AppColors.statusConfirmed,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case StatusNames.rejected:
        return statusWidget(
            isCenter: isCenter,
            text: AppLocalizations.of(activeContext)!.statusRejected,
            color: AppColors.statusReject,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case StatusNames.active:
        return statusWidget(
            isCenter: isCenter,
            text: AppLocalizations.of(activeContext)!.statusActive,
            color: AppColors.statusVerified,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case StatusNames.pendingWholesalerReview:
        return statusWidget(
            isCenter: isCenter,
            text: AppLocalizations.of(activeContext)!
                .statusPendingWholesalerReview,
            color: AppColors.statusProgress,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case StatusNames.inProcess:
        return statusWidget(
            isCenter: isCenter,
            text: AppLocalizations.of(activeContext)!.statusInProcess,
            color: AppColors.statusVerified,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case StatusNames.verified:
        return statusWidget(
            isCenter: isCenter,
            text: AppLocalizations.of(activeContext)!.statusVerified,
            color: AppColors.statusVerified,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case StatusNames.processed:
        return statusWidget(
            isCenter: isCenter,
            text: AppLocalizations.of(activeContext)!.statusProcessed,
            color: AppColors.statusVerified,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case StatusNames.accepted:
        return statusWidget(
            isCenter: isCenter,
            text: AppLocalizations.of(activeContext)!.statusAccepted,
            color: AppColors.statusConfirmed,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case StatusNames.onEvaluationAssociationPending:
        return statusWidget(
            isCenter: isCenter,
            text: AppLocalizations.of(activeContext)!
                .statusOnEvaluationAssociationPending,
            color: AppColors.statusConfirmed,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case StatusNames.pendingFieForward:
        return statusWidget(
            isCenter: isCenter,
            text: AppLocalizations.of(activeContext)!.statusPendingFIEForward,
            color: AppColors.statusConfirmed,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case StatusNames.onEvaluation:
        return statusWidget(
            isCenter: isCenter,
            text: AppLocalizations.of(activeContext)!.statusOnEvaluation,
            color: AppColors.statusProgress,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case StatusNames.waitingReply:
        return statusWidget(
            isCenter: isCenter,
            text: AppLocalizations.of(activeContext)!.statusWaitingReply,
            color: AppColors.statusProgress,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case StatusNames.error:
        return statusWidget(
            isCenter: isCenter,
            text: AppLocalizations.of(activeContext)!.statusError,
            color: AppColors.statusError,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);

      case StatusNames.associationPendingFieQueue:
        return statusWidget(
            isCenter: isCenter,
            text: AppLocalizations.of(activeContext)!
                .statusAssociationPendingFIEQueue,
            color: AppColors.statusConfirmed,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case StatusNames.waitingReplyAssociationPending:
        return statusWidget(
            isCenter: isCenter,
            text: AppLocalizations.of(activeContext)!
                .statusWaitingReplyAssociationPending,
            color: AppColors.statusConfirmed,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case StatusNames.approved:
        return statusWidget(
            isCenter: isCenter,
            text: AppLocalizations.of(activeContext)!.statusApproved,
            color: AppColors.statusVerified,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case StatusNames.associationPendingRecommended:
        return statusWidget(
            isCenter: isCenter,
            text: AppLocalizations.of(activeContext)!
                .statusAssociationPendingRecommended,
            color: AppColors.statusProgress,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case StatusNames.inactive:
        return statusWidget(
            isCenter: isCenter,
            text: AppLocalizations.of(activeContext)!.statusInactive,
            color: AppColors.statusReject,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case StatusNames.recommended:
        return statusWidget(
            isCenter: isCenter,
            text: AppLocalizations.of(activeContext)!.statusRecommended,
            color: AppColors.statusRecommended,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case StatusNames.formalized:
        return statusWidget(
            isCenter: isCenter,
            text: AppLocalizations.of(activeContext)!.statusFormalized,
            color: AppColors.statusProgress,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      default:
        return statusWidget(
            isCenter: isCenter,
            text: AppLocalizations.of(activeContext)!.statusError,
            color: AppColors.statusErrorColor,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
    }
  }

  Widget toStoreStatus() {
    switch (this) {
      case StatusNames.active:
        return statusWidget(
          isCenter: false,
          text: AppLocalizations.of(activeContext)!.statusActive,
          color: AppColors.statusVerified,
        );
      case StatusNames.inactive:
        return statusWidget(
          isCenter: false,
          text: AppLocalizations.of(activeContext)!.statusInactive,
          color: AppColors.statusConfirmed,
        );
      default:
        return statusWidget(
          isCenter: false,
          text: AppLocalizations.of(activeContext)!.statusError,
          color: AppColors.statusErrorColor,
        );
    }
  }
}

class StatusArgument {
  String title;
  Color color;

  StatusArgument({this.title = "", this.color = AppColors.ashColor});
}

extension StatusExtensionFromInt on int {
  Widget toStatusFromInt(
      {bool isIconAvailable = true,
      TextStyle textStyle = AppTextStyles.statusCardStatus,
      isCenter = false,
      required String value}) {
    switch (this) {
      case 0:
        return statusWidget(
            isCenter: isCenter,
            text: value,
            color: AppColors.statusConfirmed,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case 1:
        return statusWidget(
            isCenter: isCenter,
            text: value,
            color: AppColors.statusConfirmed,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case 2:
        return statusWidget(
            isCenter: isCenter,
            text: value,
            color: AppColors.statusProgress,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case 3:
        return statusWidget(
            isCenter: isCenter,
            text: value,
            color: AppColors.statusConfirmed,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case 4:
        return statusWidget(
            isCenter: isCenter,
            text: value,
            color: AppColors.statusConfirmed,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case 5:
        return statusWidget(
            isCenter: isCenter,
            text: value,
            color: AppColors.statusProgress,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case 6:
        return statusWidget(
            isCenter: isCenter,
            text: value,
            color: AppColors.statusReject,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case 7:
        return statusWidget(
            isCenter: isCenter,
            text: value,
            color: AppColors.statusConfirmed,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case 8:
        return statusWidget(
            isCenter: isCenter,
            text: value,
            color: AppColors.statusProgress,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case 9:
        return statusWidget(
            isCenter: isCenter,
            text: value,
            color: AppColors.statusProgress,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case 10:
        return statusWidget(
            isCenter: isCenter,
            text: value,
            color: AppColors.statusProgress,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case 11:
        return statusWidget(
            isCenter: isCenter,
            text: value,
            color: AppColors.statusConfirmed,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case 12:
        return statusWidget(
            isCenter: isCenter,
            text: value,
            color: AppColors.statusConfirmed,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case 13:
        return statusWidget(
            isCenter: isCenter,
            text: value,
            color: AppColors.statusVerified,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case 14:
        return statusWidget(
            isCenter: isCenter,
            text: value,
            color: AppColors.statusVerified,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);

      default:
        return statusWidget(
            isCenter: isCenter,
            text: "Error",
            color: AppColors.statusErrorColor,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
    }
  }

  Widget toStatusFinStat({
    bool isIconAvailable = true,
    TextStyle textStyle = AppTextStyles.statusCardStatus,
    required String value,
  }) {
    switch (this) {
      case 0:
        return statusWidget(
          // width: width,
          isCenter: false,
          text: value,
          color: AppColors.statusStateCurrent,
          textStyle: textStyle,
          isIconAvailable: isIconAvailable,
        );
      case 1:
        return statusWidget(
            // width: width,
            isCenter: false,
            text: value,
            color: AppColors.statusStateDue,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case 2:
        return statusWidget(
            // width: width,
            isCenter: false,
            text: value,
            color: AppColors.statusStateOverDue,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case 3:
        return statusWidget(
            // width: width,
            isCenter: false,
            text: value,
            color: AppColors.statusStatePartPaid,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case 4:
        return statusWidget(
            isCenter: false,
            text: value,
            color: AppColors.statusStateFinExt,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case 5:
        return statusWidget(
            isCenter: false,
            text: value,
            color: AppColors.statusStateFinExt,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);

      default:
        return statusWidget(
            isCenter: false,
            text: AppLocalizations.of(activeContext)!.statusError,
            color: AppColors.statusErrorColor,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
    }
  }

  Widget toStatusTransaction(
      {bool isIconAvailable = true,
      TextStyle textStyle = AppTextStyles.statusCardStatus,
      required String value,
      bool treansactionScreen = false}) {
    switch (this) {
      case 0:
        return treansactionScreen
            ? TransactionStatusWidget(
                text: value,
                color: AppColors.statusStateCurrent,
                textStyle: textStyle,
              )
            : statusWidget(
                // width: width,
                isCenter: false,
                text: value,
                color: AppColors.statusStateCurrent,
                textStyle: textStyle,
                isIconAvailable: isIconAvailable,
              );
      case 1:
        return treansactionScreen
            ? TransactionStatusWidget(
                text: value,
                color: AppColors.statusStateDue,
                textStyle: textStyle,
              )
            : statusWidget(
                // width: width,
                isCenter: false,
                text: value,
                color: AppColors.statusStateDue,
                textStyle: textStyle,
                isIconAvailable: isIconAvailable);
      case 2:
        return treansactionScreen
            ? TransactionStatusWidget(
                text: value,
                color: AppColors.statusStateOverDue,
                textStyle: textStyle,
              )
            : statusWidget(
                // width: width,
                isCenter: false,
                text: value,
                color: AppColors.statusStateOverDue,
                textStyle: textStyle,
                isIconAvailable: isIconAvailable);
      case 3:
        return treansactionScreen
            ? TransactionStatusWidget(
                text: value,
                color: AppColors.statusStatePartPaid,
                textStyle: textStyle,
              )
            : statusWidget(
                // width: width,
                isCenter: false,
                text: value,
                color: AppColors.statusStatePartPaid,
                textStyle: textStyle,
                isIconAvailable: isIconAvailable);
      case 4:
        return treansactionScreen
            ? TransactionStatusWidget(
                text: value,
                color: AppColors.statusVerified,
                textStyle: textStyle,
              )
            : statusWidget(
                isCenter: false,
                text: value,
                color: AppColors.statusVerified,
                textStyle: textStyle,
                isIconAvailable: isIconAvailable);
      case 5:
        return treansactionScreen
            ? TransactionStatusWidget(
                text: value,
                color: AppColors.statusStateFinExt,
                textStyle: textStyle,
              )
            : statusWidget(
                isCenter: false,
                text: value,
                color: AppColors.statusStateFinExt,
                textStyle: textStyle,
                isIconAvailable: isIconAvailable);

      default:
        return treansactionScreen
            ? TransactionStatusWidget(
                text: AppLocalizations.of(activeContext)!.statusError,
                color: AppColors.statusErrorColor,
                textStyle: textStyle,
              )
            : statusWidget(
                isCenter: false,
                text: AppLocalizations.of(activeContext)!.statusError,
                color: AppColors.statusErrorColor,
                textStyle: textStyle,
                isIconAvailable: isIconAvailable);
    }
  }

  Color toStatusFinStatWeb() {
    switch (this) {
      case 0:
        return AppColors.statusStateCurrent;
      case 1:
        return AppColors.statusStateDue;
      case 2:
        return AppColors.statusStateOverDue;
      case 3:
        return AppColors.statusStatePartPaid;
      case 5:
        return AppColors.statusStateFinExt;
      default:
        return AppColors.statusErrorColor;
    }
  }

  Color toStatusSettlementStatWeb() {
    switch (this) {
      case 0:
        return AppColors.statusProgress;
      case 1:
        return AppColors.statusConfirmed;
      case 2:
        return AppColors.statusReject;
      default:
        return AppColors.statusErrorColor;
    }
  }

  Widget toStatusSettleMent(
      {bool isIconAvailable = true,
      TextStyle textStyle = AppTextStyles.statusCardStatus,
      required String value}) {
    switch (this) {
      case 0:
        return statusWidget(
            text: value,
            color: AppColors.statusProgress,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case 1:
        return statusWidget(
            text: value,
            color: AppColors.statusConfirmed,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case 2:
        return statusWidget(
            text: value,
            color: AppColors.statusReject,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);

      default:
        return statusWidget(
            text: AppLocalizations.of(activeContext)!.statusError,
            color: AppColors.statusErrorColor,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
    }
  }

  Widget toStatusSettlementCard(
      {bool isIconAvailable = true,
      TextStyle textStyle = AppTextStyles.statusCardStatus,
      required String value}) {
    switch (this) {
      case 0:
        return statusWidget(
            text: value,
            color: AppColors.statusConfirmed,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case 1:
        return statusWidget(
            text: value,
            color: AppColors.statusProgress,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case 2:
        return statusWidget(
            text: value,
            color: AppColors.statusReject,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case 3:
        return statusWidget(
            text: value,
            color: AppColors.statusRecommended,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case 4:
        return statusWidget(
            text: value,
            color: AppColors.statusVerified,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);

      default:
        return statusWidget(
            text: AppLocalizations.of(activeContext)!.statusError,
            color: AppColors.statusErrorColor,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
    }
  }
}

extension CardStatusExtensionFromInt on int {
  Widget toCardStatusFromInt(
      {bool isIconAvailable = true,
      TextStyle textStyle = AppTextStyles.statusCardStatus,
      required String value}) {
    switch (this) {
      case 0:
        return statusWidget(
            text: value,
            color: AppColors.statusReject,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case 1:
        return statusWidget(
            text: value,
            color: AppColors.statusVerified,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case 2:
        return statusWidget(
            text: value,
            color: AppColors.statusReject,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case 3:
        return statusWidget(
            text: value,
            color: AppColors.statusConfirmed,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);

      default:
        return statusWidget(
            text: AppLocalizations.of(activeContext)!.statusError,
            color: AppColors.statusErrorColor,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
    }
  }
}

extension SalesStatus on int {
  Widget toSaleStatus(
      {bool isIconAvailable = true,
      String text = "",
      TextAlign textAlign = TextAlign.start,
      TextStyle textStyle = AppTextStyles.statusCardStatus,
      bool isCenter = false}) {
    switch (this) {
      case 0:
        return statusWidget(
            isCenter: isCenter,
            text: text,
            color: AppColors.statusReject,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);

      case 1:
        return statusWidget(
            isCenter: isCenter,
            text: text,
            color: AppColors.statusVerified,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case 2:
        return statusWidget(
            isCenter: isCenter,
            text: text,
            color: AppColors.statusReject,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case 3:
        return statusWidget(
            isCenter: isCenter,
            text: text,
            color: AppColors.statusReject,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case 4:
        return statusWidget(
            isCenter: isCenter,
            text: text,
            color: AppColors.statusVerified,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case 5:
        return statusWidget(
            isCenter: isCenter,
            text: text,
            color: AppColors.statusReject,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case 6:
        return statusWidget(
            isCenter: isCenter,
            text: text,
            color: AppColors.statusVerified,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case 7:
        return statusWidget(
            isCenter: isCenter,
            text: text,
            color: AppColors.statusConfirmed,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case 8:
        return statusWidget(
            isCenter: isCenter,
            text: text,
            color: AppColors.statusReject,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case 13:
        return statusWidget(
            isCenter: isCenter,
            text: text,
            color: AppColors.statusVerified,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);

      default:
        return statusWidget(
            isCenter: isCenter,
            text: AppLocalizations.of(activeContext)!.statusError,
            color: AppColors.statusErrorColor,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
    }
  }

  Widget toSaleWebStatus(
      {bool isIconAvailable = true,
      String text = "",
      TextAlign textAlign = TextAlign.start,
      TextStyle textStyle = AppTextStyles.statusCardStatus}) {
    switch (this) {
      case 0:
        return webStatusWidget(
          text: text,
          color: AppColors.statusReject,
          textStyle: textStyle,
        );

      case 1:
        return webStatusWidget(
          text: text,
          color: AppColors.statusVerified,
          textStyle: textStyle,
        );
      case 2:
        return webStatusWidget(
          text: text,
          color: AppColors.statusReject,
          textStyle: textStyle,
        );
      case 3:
        return webStatusWidget(
          text: text,
          color: AppColors.statusReject,
          textStyle: textStyle,
        );
      case 4:
        return webStatusWidget(
          text: text,
          color: AppColors.statusVerified,
          textStyle: textStyle,
        );
      case 5:
        return webStatusWidget(
          text: text,
          color: AppColors.statusReject,
          textStyle: textStyle,
        );
      case 6:
        return webStatusWidget(
          text: text,
          color: AppColors.statusVerified,
          textStyle: textStyle,
        );
      case 7:
        return webStatusWidget(
          text: text,
          color: AppColors.statusConfirmed,
          textStyle: textStyle,
        );
      case 8:
        return webStatusWidget(
          text: text,
          color: AppColors.statusReject,
          textStyle: textStyle,
        );
      case 13:
        return webStatusWidget(
          text: text,
          color: AppColors.statusVerified,
          textStyle: textStyle,
        );

      default:
        return webStatusWidget(
          text: AppLocalizations.of(activeContext)!.statusError,
          color: AppColors.statusErrorColor,
          textStyle: textStyle,
        );
    }
  }

  String toSaleStatusDes() {
    int i = salesStatusList
        .indexWhere((element) => element.status.toString() == toString());
    return salesStatusList[i].statusDescription;
  }
}

extension OrderStatus on int {
  Widget toOrderStatus(
      {bool isIconAvailable = true,
      String text = "",
      TextStyle textStyle = AppTextStyles.statusCardStatus}) {
    switch (this) {
      case 0:
        return statusWidget(
            text: text,
            color: AppColors.statusVerified,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);

      case 1:
        return statusWidget(
            text: text,
            color: AppColors.statusWarnColor,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case 2:
        return statusWidget(
            text: text,
            color: AppColors.statusQueue,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case 3:
        return statusWidget(
            text: text,
            color: AppColors.statusErrorColor,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case 4:
        return statusWidget(
            text: text,
            color: AppColors.statusErrorColor,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case 5:
        return statusWidget(
            text: text,
            color: AppColors.statusLiteRedColor,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);

      default:
        return statusWidget(
            text: AppLocalizations.of(activeContext)!.statusError,
            color: AppColors.statusErrorColor,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
    }
  }
}

extension CreditlineStatus on int {
  Widget toCreditStatus(
      {bool isIconAvailable = true,
      String text = "",
      TextStyle textStyle = AppTextStyles.statusCardStatus}) {
    switch (this) {
      case 0:
        return statusWidget(
            text: text,
            color: AppColors.statusVerified,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);

      case 1:
        return statusWidget(
            text: text,
            color: AppColors.statusWarnColor,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case 2:
        return statusWidget(
            text: text,
            color: AppColors.statusQueue,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case 3:
        return statusWidget(
            text: text,
            color: AppColors.statusErrorColor,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case 4:
        return statusWidget(
            text: text,
            color: AppColors.lightAshColor,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
      case 5:
        return statusWidget(
            text: text,
            color: AppColors.statusLiteRedColor,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);

      default:
        return statusWidget(
            text: AppLocalizations.of(activeContext)!.statusError,
            color: AppColors.statusErrorColor,
            textStyle: textStyle,
            isIconAvailable: isIconAvailable);
    }
  }
}
