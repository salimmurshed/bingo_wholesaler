part of '../../ui/add_credit_line_screen/add_credit_line_view.dart';

class MultipleSearchSelectionPart extends StatelessWidget {
  const MultipleSearchSelectionPart(this.model, {Key? key}) : super(key: key);
  final AddCreditLineViewModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          AppLocalizations.of(context)!.selectMultipleFie,
        ),
        SizedBox(
            width: 100.0.wp,
            child: Wrap(
              children: [
                for (var e in model.listFie)
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: InkWell(
                      onTap: () {
                        // model.addFieList(e);
                      },
                      child: Container(
                        decoration: AppBoxDecoration.borderDecoration,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(e.bpName!),
                        ),
                      ),
                    ),
                  ),
              ],
            )),
        10.0.giveHeight,
        SizedBox(
          // height: 45.0,
          child: TextFormField(
            readOnly: true,
            style: AppTextStyles.formFieldTextStyle,
            decoration: AppInputStyles.ashOutlineBorder
                .copyWith(hintText: AppLocalizations.of(context)!.selectFie),
            onTap: () async {
              await showDialog(
                context: context,
                builder: (ctx) {
                  return SizedBox(
                    height: 500.0,
                    child: MultiSelectDialog<FieCreditLineRequestData>(
                      backgroundColor: AppColors.whiteColor,
                      selectedColor: AppColors.checkBoxSelected,
                      title: Text(AppLocalizations.of(context)!.selectText),
                      cancelText: Text(
                        AppLocalizations.of(context)!
                            .cancelButton
                            .toUpperCamelCase(),
                        style: const TextStyle(color: AppColors.blackColor),
                      ),
                      confirmText: Text(
                        AppLocalizations.of(context)!
                            .confirmButton
                            .toUpperCamelCase(),
                        style: const TextStyle(color: AppColors.blackColor),
                      ),
                      items: model.allFieCreditLine
                          .map((e) => MultiSelectItem<FieCreditLineRequestData>(
                              e, e.bpName!))
                          .toList(),
                      initialValue: model.listFie,
                      onConfirm: (List<FieCreditLineRequestData> values) {
                        model.addFieList(values);
                        // print(values);
                      },
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
