import 'dart:math' as math;

import '/const/all_const.dart';
import 'package:flutter/material.dart';

class ExpandableThemeData {
  static const ExpandableThemeData defaults = ExpandableThemeData(
    iconColor: Colors.black54,
    useInkWell: true,
    inkWellBorderRadius: BorderRadius.zero,
    animationDuration: Duration(milliseconds: 300),
    scrollAnimationDuration: Duration(milliseconds: 300),
    crossFadePoint: 0.5,
    fadeCurve: Curves.linear,
    sizeCurve: Curves.fastOutSlowIn,
    alignment: Alignment.topLeft,
    headerAlignment: ExpandablePanelHeaderAlignment.top,
    bodyAlignment: ExpandablePanelBodyAlignment.left,
    iconPlacement: ExpandablePanelIconPlacement.right,
    tapHeaderToExpand: false,
    tapBodyToExpand: false,
    tapBodyToCollapse: false,
    hasIcon: true,
    iconSize: 24.0,
    iconPadding: EdgeInsets.all(8.0),
    iconRotationAngle: -math.pi,
    expandIcon: Icons.expand_more,
    collapseIcon: Icons.expand_more,
  );

  static const ExpandableThemeData empty = ExpandableThemeData();

  final Color? iconColor;

  final bool? useInkWell;

  final Duration? animationDuration;

  final Duration? scrollAnimationDuration;

  final double? crossFadePoint;

  final AlignmentGeometry? alignment;

  final Curve? fadeCurve;

  final Curve? sizeCurve;

  final ExpandablePanelHeaderAlignment? headerAlignment;

  final ExpandablePanelBodyAlignment? bodyAlignment;

  final ExpandablePanelIconPlacement? iconPlacement;

  final bool? tapHeaderToExpand;

  final bool? tapBodyToExpand;

  final bool? tapBodyToCollapse;

  final bool? hasIcon;

  final double? iconSize;

  final EdgeInsets? iconPadding;

  final double? iconRotationAngle;

  final IconData? expandIcon;

  final IconData? collapseIcon;

  final BorderRadius? inkWellBorderRadius;

  const ExpandableThemeData({
    this.iconColor,
    this.useInkWell,
    this.animationDuration,
    this.scrollAnimationDuration,
    this.crossFadePoint,
    this.fadeCurve,
    this.sizeCurve,
    this.alignment,
    this.headerAlignment,
    this.bodyAlignment,
    this.iconPlacement,
    this.tapHeaderToExpand,
    this.tapBodyToExpand,
    this.tapBodyToCollapse,
    this.hasIcon,
    this.iconSize,
    this.iconPadding,
    this.iconRotationAngle,
    this.expandIcon,
    this.collapseIcon,
    this.inkWellBorderRadius,
  });

  static ExpandableThemeData combine(
      ExpandableThemeData? theme, ExpandableThemeData? defaults) {
    if (defaults == null || defaults.isEmpty()) {
      return theme ?? empty;
    } else if (theme == null || theme.isEmpty()) {
      return defaults;
    } else if (theme.isFull()) {
      return theme;
    } else {
      return ExpandableThemeData(
        iconColor: theme.iconColor ?? defaults.iconColor,
        useInkWell: theme.useInkWell ?? defaults.useInkWell,
        inkWellBorderRadius:
            theme.inkWellBorderRadius ?? defaults.inkWellBorderRadius,
        animationDuration:
            theme.animationDuration ?? defaults.animationDuration,
        scrollAnimationDuration:
            theme.scrollAnimationDuration ?? defaults.scrollAnimationDuration,
        crossFadePoint: theme.crossFadePoint ?? defaults.crossFadePoint,
        fadeCurve: theme.fadeCurve ?? defaults.fadeCurve,
        sizeCurve: theme.sizeCurve ?? defaults.sizeCurve,
        alignment: theme.alignment ?? defaults.alignment,
        headerAlignment: theme.headerAlignment ?? defaults.headerAlignment,
        bodyAlignment: theme.bodyAlignment ?? defaults.bodyAlignment,
        iconPlacement: theme.iconPlacement ?? defaults.iconPlacement,
        tapHeaderToExpand:
            theme.tapHeaderToExpand ?? defaults.tapHeaderToExpand,
        tapBodyToExpand: theme.tapBodyToExpand ?? defaults.tapBodyToExpand,
        tapBodyToCollapse:
            theme.tapBodyToCollapse ?? defaults.tapBodyToCollapse,
        hasIcon: theme.hasIcon ?? defaults.hasIcon,
        iconSize: theme.iconSize ?? defaults.iconSize,
        iconPadding: theme.iconPadding ?? defaults.iconPadding,
        iconRotationAngle:
            theme.iconRotationAngle ?? defaults.iconRotationAngle,
        expandIcon: theme.expandIcon ?? defaults.expandIcon,
        collapseIcon: theme.collapseIcon ?? defaults.collapseIcon,
      );
    }
  }

  double get collapsedFadeStart =>
      crossFadePoint! < 0.5 ? 0 : (crossFadePoint! * 2 - 1);

  double get collapsedFadeEnd =>
      crossFadePoint! < 0.5 ? 2 * crossFadePoint! : 1;

  double get expandedFadeStart =>
      crossFadePoint! < 0.5 ? 0 : (crossFadePoint! * 2 - 1);

  double get expandedFadeEnd => crossFadePoint! < 0.5 ? 2 * crossFadePoint! : 1;

  ExpandableThemeData? nullIfEmpty() {
    return isEmpty() ? null : this;
  }

  bool isEmpty() {
    return this == empty;
  }

  bool isFull() {
    return iconColor != null &&
        useInkWell != null &&
        inkWellBorderRadius != null &&
        animationDuration != null &&
        scrollAnimationDuration != null &&
        crossFadePoint != null &&
        fadeCurve != null &&
        sizeCurve != null &&
        alignment != null &&
        headerAlignment != null &&
        bodyAlignment != null &&
        iconPlacement != null &&
        tapHeaderToExpand != null &&
        tapBodyToExpand != null &&
        tapBodyToCollapse != null &&
        hasIcon != null &&
        iconRotationAngle != null &&
        expandIcon != null &&
        collapseIcon != null;
  }

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) {
      return true;
    } else if (other is ExpandableThemeData) {
      return iconColor == other.iconColor &&
          useInkWell == other.useInkWell &&
          inkWellBorderRadius == other.inkWellBorderRadius &&
          animationDuration == other.animationDuration &&
          scrollAnimationDuration == other.scrollAnimationDuration &&
          crossFadePoint == other.crossFadePoint &&
          fadeCurve == other.fadeCurve &&
          sizeCurve == other.sizeCurve &&
          alignment == other.alignment &&
          headerAlignment == other.headerAlignment &&
          bodyAlignment == other.bodyAlignment &&
          iconPlacement == other.iconPlacement &&
          tapHeaderToExpand == other.tapHeaderToExpand &&
          tapBodyToExpand == other.tapBodyToExpand &&
          tapBodyToCollapse == other.tapBodyToCollapse &&
          hasIcon == other.hasIcon &&
          iconRotationAngle == other.iconRotationAngle &&
          expandIcon == other.expandIcon &&
          collapseIcon == other.collapseIcon;
    } else {
      return false;
    }
  }

  @override
  int get hashCode {
    return 0; // we don't care
  }

  static ExpandableThemeData of(BuildContext context,
      {bool rebuildOnChange = true}) {
    final notifier = rebuildOnChange
        ? context.dependOnInheritedWidgetOfExactType<_ExpandableThemeNotifier>()
        : context.findAncestorWidgetOfExactType<_ExpandableThemeNotifier>();
    return notifier?.themeData ?? defaults;
  }

  static ExpandableThemeData withDefaults(
      ExpandableThemeData? theme, BuildContext context,
      {bool rebuildOnChange = true}) {
    if (theme != null && theme.isFull()) {
      return theme;
    } else {
      return combine(
          combine(theme, of(context, rebuildOnChange: rebuildOnChange)),
          defaults);
    }
  }
}

class ExpandableTheme extends StatelessWidget {
  final ExpandableThemeData data;
  final Widget child;

  const ExpandableTheme({super.key, required this.data, required this.child});

  @override
  Widget build(BuildContext context) {
    _ExpandableThemeNotifier? n =
        context.dependOnInheritedWidgetOfExactType<_ExpandableThemeNotifier>();
    return _ExpandableThemeNotifier(
      themeData: ExpandableThemeData.combine(data, n?.themeData),
      child: child,
    );
  }
}

/// Makes an [ExpandableController] available to the widget subtree.
/// Useful for making multiple [Expandable] widgets synchronized with a single controller.
class ExpandableNotifier extends StatefulWidget {
  final ExpandableController? controller;
  final bool? initialExpanded;
  final Widget child;

  const ExpandableNotifier(
      {
      // An optional key
      Key? key,
      this.controller,
      this.initialExpanded,
      required this.child})
      : assert(!(controller != null && initialExpanded != null)),
        super(key: key);

  @override
  _ExpandableNotifierState createState() => _ExpandableNotifierState();
}

class _ExpandableNotifierState extends State<ExpandableNotifier> {
  ExpandableController? controller;
  ExpandableThemeData? theme;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ??
        ExpandableController(initialExpanded: widget.initialExpanded ?? false);
  }

  @override
  void didUpdateWidget(ExpandableNotifier oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller &&
        widget.controller != null) {
      setState(() {
        controller = widget.controller;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cn = _ExpandableControllerNotifier(
        controller: controller, child: widget.child);
    return theme != null
        ? _ExpandableThemeNotifier(themeData: theme, child: cn)
        : cn;
  }
}

/// Makes an [ExpandableController] available to the widget subtree.
/// Useful for making multiple [Expandable] widgets synchronized with a single controller.
class _ExpandableControllerNotifier
    extends InheritedNotifier<ExpandableController> {
  const _ExpandableControllerNotifier(
      {required ExpandableController? controller, required Widget child})
      : super(notifier: controller, child: child);
}

/// Makes an [ExpandableController] available to the widget subtree.
/// Useful for making multiple [Expandable] widgets synchronized with a single controller.
class _ExpandableThemeNotifier extends InheritedWidget {
  final ExpandableThemeData? themeData;

  const _ExpandableThemeNotifier(
      {required this.themeData, required Widget child})
      : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return !(oldWidget is _ExpandableThemeNotifier &&
        oldWidget.themeData == themeData);
  }
}

/// Controls the state (expanded or collapsed) of one or more [Expandable].
/// The controller should be provided to [Expandable] via [ExpandableNotifier].
class ExpandableController extends ValueNotifier<bool> {
  /// Returns [true] if the state is expanded, [false] if collapsed.
  bool get expanded => value;

  ExpandableController({
    bool? initialExpanded,
  }) : super(initialExpanded ?? false);

  /// Sets the expanded state.
  set expanded(bool exp) {
    value = exp;
  }

  /// Sets the expanded state to the opposite of the current state.
  void toggle() {
    expanded = !expanded;
  }

  static ExpandableController? of(BuildContext context,
      {bool rebuildOnChange = true, bool required = false}) {
    final notifier = rebuildOnChange
        ? context
            .dependOnInheritedWidgetOfExactType<_ExpandableControllerNotifier>()
        : context
            .findAncestorWidgetOfExactType<_ExpandableControllerNotifier>();
    assert(notifier != null || !required,
        "ExpandableNotifier is not found in widget tree");
    return notifier?.notifier;
  }
}

/// Shows either the expanded or the collapsed child depending on the state.
/// The state is determined by an instance of [ExpandableController] provided by [ScopedModel]
class Expandable extends StatelessWidget {
  /// Whe widget to show when collapsed
  final Widget collapsed;

  /// The widget to show when expanded
  final Widget expanded;

  /// If the controller is not specified, it will be retrieved from the context
  final ExpandableController? controller;

  final ExpandableThemeData? theme;
  final bool isTrue;

  Expandable({
    Key? key,
    required this.collapsed,
    required this.expanded,
    this.controller,
    this.theme,
    required this.isTrue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final controller =
    //     this.controller ?? ExpandableController.of(context, required: isTrue);
    final theme = ExpandableThemeData.withDefaults(this.theme, context);

    return AnimatedCrossFade(
      alignment: theme.alignment!,
      firstChild: collapsed,
      secondChild: isTrue ? expanded : SizedBox(),
      firstCurve: Interval(theme.collapsedFadeStart, theme.collapsedFadeEnd,
          curve: theme.fadeCurve!),
      secondCurve: Interval(theme.expandedFadeStart, theme.expandedFadeEnd,
          curve: theme.fadeCurve!),
      sizeCurve: theme.sizeCurve!,
      crossFadeState: controller?.expanded ?? true
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
      duration: theme.animationDuration!,
    );
  }
}

typedef ExpandableBuilder = Widget Function(
    BuildContext context, Widget collapsed, Widget expanded);

enum ExpandablePanelIconPlacement {
  left,
  right,
}

enum ExpandablePanelHeaderAlignment {
  top,
  center,
  bottom,
}

enum ExpandablePanelBodyAlignment {
  left,
  center,
  right,
}

class ExpandablePanel extends StatefulWidget {
  final Widget collapsed;

  final Widget expanded;
  final Widget child;

  final ExpandableBuilder? builder;

  final ExpandableController? controller;

  final ExpandableThemeData? theme;
  final String title;
  final bool isTrue;
  final String body;
  final String price;
  Function() onTap;

  ExpandablePanel({
    Key? key,
    required this.collapsed,
    required this.expanded,
    required this.child,
    this.controller,
    this.builder,
    this.theme,
    this.title = "",
    required this.isTrue,
    this.body = "",
    this.price = "",
    required this.onTap,
  }) : super(key: key);

  @override
  State<ExpandablePanel> createState() => _ExpandablePanelState();
}

class _ExpandablePanelState extends State<ExpandablePanel> {
  @override
  Widget build(BuildContext context) {
    final theme = ExpandableThemeData.withDefaults(widget.theme, context);

    Widget buildBody() {
      Widget wrapBody(Widget child, bool tap) {
        return child;
      }

      return Expandable(
          collapsed: wrapBody(widget.collapsed, theme.tapBodyToExpand!),
          expanded: wrapBody(widget.expanded, theme.tapBodyToCollapse!),
          theme: theme,
          isTrue: widget.isTrue);
    }

    return ExpandableNotifier(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ExpandableButton(
              theme: theme,
              onTap: () {
                widget.onTap();
              },
              child: widget.child),
          buildBody(),
        ],
      ),
    );
  }
}

class ExpandableButton extends StatelessWidget {
  final Widget? child;
  final ExpandableThemeData? theme;
  Function() onTap;

  ExpandableButton({super.key, this.child, this.theme, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final controller = ExpandableController.of(context, required: true);
    final theme = ExpandableThemeData.withDefaults(this.theme, context);

    if (theme.useInkWell!) {
      return InkWell(
        onTap: () {
          onTap();
        },
        borderRadius: theme.inkWellBorderRadius!,
        child: child,
      );
    } else {
      return GestureDetector(
        onTap: () {
          debugPrint('hhheeeq');
          controller?.toggle();
        },
        child: child,
      );
    }
  }
}
