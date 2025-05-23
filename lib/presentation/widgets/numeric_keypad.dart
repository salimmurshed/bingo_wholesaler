import 'package:bingo/const/all_const.dart';
import 'package:flutter/material.dart';

class NumericKeyPad extends StatelessWidget {
  NumericKeyPad({
    super.key,
    required this.onInputNumber,
    required this.onClearLastInput,
    required this.onClearAll,
    this.show,
  });

  final ValueSetter<int> onInputNumber;
  final VoidCallback onClearLastInput;
  final VoidCallback onClearAll;
  final Function? show;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFd1d5dc),
      child: Column(
        children: [
          for (int i = 1; i < 4; i++)
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (int j = 1; j < 4; j++)
                    Expanded(
                      child: Numeral(
                        number: (i - 1) * 3 + j,
                        onKeyPress: () => onInputNumber((i - 1) * 3 + j),
                      ),
                    ),
                ],
              ),
            ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ShowButton(
                    showPin: () {
                      show!();
                    },
                  ),
                ),
                Expanded(
                  child: Numeral(
                    number: 0,
                    onKeyPress: () => onInputNumber(0),
                  ),
                ),
                Expanded(
                  child: ClearButton(
                    onClearLastInput: onClearLastInput,
                    onClearAll: onClearAll,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Numeral extends StatelessWidget {
  const Numeral({
    super.key,
    required this.number,
    required this.onKeyPress,
  });

  final int number;
  final VoidCallback onKeyPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
      margin: const EdgeInsets.all(0),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: const Color(0xFFFFFFFF),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            side: const BorderSide(
              width: 3.0,
              color: Colors.transparent,
            ),
          ),
          onPressed: onKeyPress,
          child: Text(
            '$number',
            style: const TextStyle(color: AppColors.blackColor, fontSize: 24),
          ),
        ),
      ),
    );
  }
}

class ClearButton extends StatelessWidget {
  const ClearButton({
    super.key,
    required this.onClearLastInput,
    required this.onClearAll,
  });

  final VoidCallback onClearLastInput;
  final VoidCallback onClearAll;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(1),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: const Color(0x00000000),
          shape: const ContinuousRectangleBorder(),
          side: const BorderSide(
            width: 1.0,
            color: Colors.transparent,
          ),
        ),
        onPressed: onClearLastInput,
        onLongPress: onClearAll,
        child: const Icon(
          Icons.backspace_outlined,
          color: Color(0xFF000000),
        ),
      ),
    );
  }
}

class ShowButton extends StatelessWidget {
  ShowButton({
    super.key,
    required this.showPin,
  });

  final Function showPin;

  // bool show = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(1),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: const Color(0x00000000),
          shape: const ContinuousRectangleBorder(),
          side: const BorderSide(
            width: 1.0,
            color: Colors.transparent,
          ),
        ),
        onPressed: () {
          showPin();
        },
        child: const Icon(
          Icons.remove_red_eye,
          color: Color(0xFF000000),
        ),
      ),
    );
  }
}
