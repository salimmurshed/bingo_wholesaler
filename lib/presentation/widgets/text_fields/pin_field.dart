import 'package:bingo/const/all_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PinField extends StatefulWidget {
  PinField({
    Key? key,
    required this.fieldNumber,
    required this.onCompleted,
    required this.itemNumber,
    required this.keyboardActive,
    required this.focuses,
    required this.controller,
    required this.pinV,
    this.showPin = true,
  }) : super(key: key);
  final int fieldNumber;
  ValueChanged<String> onCompleted;
  ValueChanged<int> itemNumber;
  ValueChanged<bool> keyboardActive;
  List<FocusNode> focuses;
  List<TextEditingController> controller;
  int pinV;
  bool showPin;

  @override
  State<PinField> createState() => _PinFieldState();
}

class _PinFieldState extends State<PinField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (int i = 0; i < widget.fieldNumber; i++)
          GestureDetector(
            onTap: () {
              widget.itemNumber.call(i);
              widget.keyboardActive.call(true);
            },
            child: AbsorbPointer(
              child: SizedBox(
                height: 13.0.wp,
                width: 10.0.wp,
                child: TextFormField(
                  scrollPadding: EdgeInsets.zero,
                  showCursor: true,
                  readOnly: true,
                  textInputAction: TextInputAction.done,
                  obscureText: widget.showPin,
                  autofocus: true,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.visiblePassword,
                  controller: widget.controller[i],
                  maxLength: 1,
                  focusNode: widget.focuses[i],
                  cursorColor: AppColors.blackColor,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: const InputDecoration(
                      focusColor: AppColors.checkBoxColor,
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.checkBoxColor)),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.checkBoxColor)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.checkBoxColor)),
                      counterText: '',
                      contentPadding: EdgeInsets.all(4.0),
                      hintStyle:
                          TextStyle(color: Colors.black, fontSize: 20.0)),
                ),
              ),
            ),
          )
      ],
    );
  }
}
