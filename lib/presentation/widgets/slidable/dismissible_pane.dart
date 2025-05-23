import 'package:flutter/widgets.dart';

import 'controller.dart';
import 'dismissible_pane_motions.dart';
import 'slidable.dart';

const double _kDismissThreshold = 0.75;
const Duration _kDismissalDuration = Duration(milliseconds: 300);
const Duration _kResizeDuration = Duration(milliseconds: 300);

typedef ConfirmDismissCallback = Future<bool> Function();

class DismissiblePane extends StatefulWidget {
  const DismissiblePane({
    Key? key,
    required this.onDismissed,
    this.dismissThreshold = _kDismissThreshold,
    this.dismissalDuration = _kDismissalDuration,
    this.resizeDuration = _kResizeDuration,
    this.confirmDismiss,
    this.closeOnCancel = false,
    this.motion = const InversedDrawerMotion(),
  })  : assert(dismissThreshold > 0 && dismissThreshold < 1),
        super(key: key);

  final double dismissThreshold;

  final Duration dismissalDuration;

  final Duration resizeDuration;

  final ConfirmDismissCallback? confirmDismiss;

  final VoidCallback onDismissed;

  final bool closeOnCancel;

  final Widget motion;

  @override
  _DismissiblePaneState createState() => _DismissiblePaneState();
}

class _DismissiblePaneState extends State<DismissiblePane> {
  SlidableController? controller;

  @override
  void initState() {
    super.initState();
    assert(() {
      final slidable = context.findAncestorWidgetOfExactType<Slidable>()!;
      if (slidable.key == null) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary('DismissiblePane created on a Slidable without a Key.'),
          ErrorDescription(
            'The closest Slidable of DismissiblePane has been created without '
            'a Key.\n'
            'The key argument must not be null because Slidables are '
            'commonly used in lists and removed from the list when '
            'dismissed. Without keys, the default behavior is to sync '
            'widgets based on their index in the list, which means the item '
            'after the dismissed item would be synced with the state of the '
            'dismissed item. Using keys causes the widgets to sync according '
            'to their keys and avoids this pitfall.',
          ),
          ErrorHint(
            'To avoid this problem, set the key of the enclosing Slidable '
            'widget.',
          ),
        ]);
      }
      return true;
    }());
    controller = Slidable.of(context);
    controller!.dismissGesture.addListener(handleDismissGestureChanged);
  }

  @override
  void dispose() {
    controller!.dismissGesture.removeListener(handleDismissGestureChanged);
    super.dispose();
  }

  Future<void> handleDismissGestureChanged() async {
    final endGesture = controller!.dismissGesture.value!.endGesture;
    final position = controller!.animation.value;

    if (endGesture is OpeningGesture ||
        endGesture is StillGesture && position >= widget.dismissThreshold) {
      bool canDismiss = true;
      if (widget.confirmDismiss != null) {
        canDismiss = await widget.confirmDismiss!();
      }
      if (canDismiss) {
        widget.onDismissed.call();
        controller!.close();
      } else if (widget.closeOnCancel) {
        controller!.close();
      }
      return;
    }

    controller!.openCurrentActionPane();
  }

  @override
  Widget build(BuildContext context) {
    return widget.motion;
  }
}
