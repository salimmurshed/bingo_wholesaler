import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../data_models/models/statement_web_model/statement_web_model.dart';
import '../../../widgets/cards/shadow_card.dart';

@immutable
class GroupedListView<T, E> extends StatefulWidget {
  final List<T> elements;

  final E Function(T element) groupBy;

  final int Function(E value1, E value2)? groupComparator;

  final int Function(T element1, T element2)? itemComparator;

  final Widget Function(E value)? groupSeparatorBuilder;

  final Widget Function(T element)? groupHeaderBuilder;

  final Widget Function(T element)? groupStickyHeaderBuilder;

  final Widget Function(BuildContext context, T element)? itemBuilder;
  final int? itemCounts;

  final Widget Function(BuildContext context, T? previousElement,
      T currentElement, T? nextElement)? interdependentItemBuilder;

  final Widget Function(
          BuildContext context, T element, bool groupStart, bool groupEnd)?
      groupItemBuilder;

  final Widget Function(BuildContext context, T element, int index)?
      indexedItemBuilder;

  final Widget? emptyPlaceholder;

  final GroupedListOrder order;

  final bool sort;

  final bool useStickyGroupSeparators;

  final Widget separator;

  final bool floatingHeader;

  final Color stickyHeaderBackgroundColor;

  final ScrollController? controller;

  final Axis scrollDirection;

  final bool? primary;

  final ScrollPhysics? physics;

  final bool shrinkWrap;

  final EdgeInsetsGeometry? padding;

  final bool reverse;

  final bool addAutomaticKeepAlives;

  final bool addRepaintBoundaries;

  final bool addSemanticIndexes;

  final double? cacheExtent;

  final Clip clipBehavior;

  final DragStartBehavior dragStartBehavior;

  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  final String? restorationId;

  final int? semanticChildCount;

  final double? itemExtent;

  final Widget? footer;
  final Widget? loadMoraWidget;
  final Function()? onSubmit;

  const GroupedListView({
    super.key,
    required this.elements,
    required this.groupBy,
    this.groupComparator,
    this.groupSeparatorBuilder,
    this.groupHeaderBuilder,
    this.groupStickyHeaderBuilder,
    this.emptyPlaceholder,
    this.itemBuilder,
    this.itemCounts,
    this.groupItemBuilder,
    this.indexedItemBuilder,
    this.interdependentItemBuilder,
    this.itemComparator,
    this.order = GroupedListOrder.ASC,
    this.sort = true,
    this.useStickyGroupSeparators = false,
    this.separator = const SizedBox.shrink(),
    this.floatingHeader = false,
    this.stickyHeaderBackgroundColor = const Color(0xffF7F7F7),
    this.scrollDirection = Axis.vertical,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
    this.reverse = false,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    this.clipBehavior = Clip.hardEdge,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.dragStartBehavior = DragStartBehavior.start,
    this.restorationId,
    this.semanticChildCount,
    this.itemExtent,
    this.footer,
    this.loadMoraWidget,
    this.onSubmit,
  })  : assert(itemBuilder != null ||
            indexedItemBuilder != null ||
            interdependentItemBuilder != null ||
            groupItemBuilder != null),
        assert(groupSeparatorBuilder != null || groupHeaderBuilder != null);

  @override
  State<StatefulWidget> createState() => _GroupedListViewState<T, E>();
}

class _GroupedListViewState<T, E> extends State<GroupedListView<T, E>> {
  final StreamController<int> _streamController = StreamController<int>();
  final LinkedHashMap<String, GlobalKey> _keys = LinkedHashMap();
  final GlobalKey _key = GlobalKey();
  late final ScrollController _controller;
  GlobalKey? _groupHeaderKey;
  List<T> _sortedElements = [];
  int _topElementIndex = 0;
  RenderBox? _headerBox;
  RenderBox? _listBox;

  I? _ambiguate<I>(I? value) => value;

  @override
  void initState() {
    _controller = widget.controller ?? ScrollController();
    if (widget.useStickyGroupSeparators) {
      _controller.addListener(_scrollListener);
    }
    super.initState();
  }

  @override
  void dispose() {
    if (widget.useStickyGroupSeparators) {
      _controller.removeListener(_scrollListener);
    }
    if (widget.controller == null) {
      _controller.dispose();
    }
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _sortedElements = _sortElements();
    var hiddenIndex = widget.reverse ? _sortedElements.length * 2 - 1 : 0;
    var isSeparator = widget.reverse ? (int i) => i.isOdd : (int i) => i.isEven;
    isValidIndex(int i) => i >= 0 && i < _sortedElements.length;

    _ambiguate(WidgetsBinding.instance)!.addPostFrameCallback((_) {
      _scrollListener();
    });

    Widget itemBuilder(context, index) {
      if (widget.footer != null && index == _sortedElements.length * 2) {
        // return SizedBox();
        return widget.footer!;
      }
      var actualIndex = index ~/ 2;
      if (index == hiddenIndex) {
        return Opacity(
          opacity: widget.useStickyGroupSeparators ? 0 : 1,
          child: _buildGroupSeparator(_sortedElements[actualIndex]),
        );
      }
      var curr = widget.groupBy(_sortedElements[actualIndex]);
      var preIndex = actualIndex + (widget.reverse ? 1 : -1);
      var prev = isValidIndex(preIndex)
          ? widget.groupBy(_sortedElements[preIndex])
          : null;
      var nextIndex = actualIndex + (widget.reverse ? -1 : 1);
      var next = isValidIndex(nextIndex)
          ? widget.groupBy(_sortedElements[nextIndex])
          : null;
      if (isSeparator(index)) {
        if (prev != curr) {
          return _buildGroupSeparator(_sortedElements[actualIndex]);
        }
        return widget.separator;
      }
      return _buildItem(context, actualIndex, prev != curr, curr != next);
    }

    return Stack(
      key: _key,
      alignment: Alignment.topCenter,
      children: <Widget>[
        SingleChildScrollView(
          scrollDirection: widget.scrollDirection,
          controller: _controller,
          physics: widget.physics,
          primary: widget.primary,
          padding: widget.padding,
          reverse: widget.reverse,
          clipBehavior: widget.clipBehavior,
          dragStartBehavior: widget.dragStartBehavior,
          restorationId: widget.restorationId,
          keyboardDismissBehavior: widget.keyboardDismissBehavior,
          child: Padding(
            padding: const EdgeInsets.only(top: 28.0),
            child: Column(
              children: [
                for (int i = 0; i < widget.elements.length; i++)
                  itemBuilder(context, i),
                widget.loadMoraWidget ?? const SizedBox()
              ],
            ),
          ),
        ),
        StreamBuilder<int>(
            stream: _streamController.stream,
            initialData: _topElementIndex,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return _showFixedGroupHeader(snapshot.data!);
              }
              return const SizedBox.shrink();
            }),
      ],
    );
  }

  Widget _buildItem(context, int index, bool groupStart, bool groupEnd) =>
      KeyedSubtree(
        key: _keys.putIfAbsent('$index', () => GlobalKey()),
        child: widget.groupItemBuilder != null
            ? widget.groupItemBuilder!(
                context,
                _sortedElements[index],
                groupStart,
                groupEnd,
              )
            : widget.indexedItemBuilder != null
                ? widget.indexedItemBuilder!(
                    context,
                    _sortedElements[index],
                    index,
                  )
                : widget.interdependentItemBuilder != null
                    ? widget.interdependentItemBuilder!(
                        context,
                        index > 0 ? _sortedElements[index - 1] : null,
                        _sortedElements[index],
                        index + 1 < _sortedElements.length
                            ? _sortedElements[index + 1]
                            : null,
                      )
                    : widget.itemBuilder!(
                        context,
                        _sortedElements[index],
                      ),
      );

  void _scrollListener() {
    if (_sortedElements.isEmpty) {
      return;
    }

    _listBox ??= _key.currentContext?.findRenderObject() as RenderBox?;
    var listPos = _listBox?.localToGlobal(Offset.zero).dy ?? 0;
    _headerBox ??=
        _groupHeaderKey?.currentContext?.findRenderObject() as RenderBox?;
    var headerHeight = _headerBox?.size.height ?? 0;
    var max = double.negativeInfinity;
    var topItemKey = widget.reverse ? '${_sortedElements.length - 1}' : '0';
    for (var entry in _keys.entries) {
      var key = entry.value;
      if (_isListItemRendered(key)) {
        var itemBox = key.currentContext!.findRenderObject() as RenderBox;
        // position of the item's top border inside the list view
        var y = itemBox.localToGlobal(Offset(0, -listPos - headerHeight)).dy;
        if (y <= headerHeight && y > max) {
          topItemKey = entry.key;
          max = y;
        }
      }
    }
    var index = math.max(int.parse(topItemKey), 0);
    if (index != _topElementIndex) {
      var curr = widget.groupBy(_sortedElements[index]);
      E prev;

      try {
        prev = widget.groupBy(_sortedElements[_topElementIndex]);
      } on RangeError catch (_) {
        prev = widget.groupBy(_sortedElements[0]);
      }

      if (prev != curr) {
        _topElementIndex = index;
        _streamController.add(_topElementIndex);
      }
    }
  }

  List<T> _sortElements() {
    var elements = [...widget.elements];
    if (widget.sort && elements.isNotEmpty) {
      elements.sort((e1, e2) {
        int? compareResult;
        // compare groups
        if (widget.groupComparator != null) {
          compareResult =
              widget.groupComparator!(widget.groupBy(e1), widget.groupBy(e2));
        } else if (widget.groupBy(e1) is Comparable) {
          compareResult = (widget.groupBy(e1) as Comparable)
              .compareTo(widget.groupBy(e2) as Comparable);
        }
        // compare elements inside group
        if (compareResult == null || compareResult == 0) {
          if (widget.itemComparator != null) {
            compareResult = widget.itemComparator!(e1, e2);
          } else if (e1 is Comparable) {
            compareResult = e1.compareTo(e2);
          }
        }
        return compareResult!;
      });
      print('elementselements');
      print(elements.length);
      for (dynamic a in elements) {
        print((a.groupName));
      }
      if (widget.order == GroupedListOrder.DESC) {
        elements = elements.reversed.toList();
      }
    }
    return elements;
    // return [
    //   T(groupName: "Overdue (90+)"),
    //   "Overdue (61-90)",
    //   "Overdue (31-60)",
    //   "Overdue (1-30)",
    //   "Today",
    //   "1-7 Days",
    //   "8-14 Days",
    //   "15-30 Days",
    //   "30+ Days"
    // ];
  }

  Widget _showFixedGroupHeader(int topElementIndex) {
    _groupHeaderKey = GlobalKey();
    if (widget.useStickyGroupSeparators && _sortedElements.isNotEmpty) {
      T topElement;

      try {
        topElement = _sortedElements[topElementIndex];
      } on RangeError catch (_) {
        topElement = _sortedElements[0];
      }

      return Container(
        key: _groupHeaderKey,
        color:
            widget.floatingHeader ? null : widget.stickyHeaderBackgroundColor,
        width: widget.floatingHeader ? null : MediaQuery.of(context).size.width,
        child: _buildFixedGroupHeader(topElement),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildGroupSeparator(T element) {
    if (widget.groupHeaderBuilder == null) {
      return widget.groupSeparatorBuilder!(widget.groupBy(element));
    }
    return widget.groupHeaderBuilder!(element);
  }

  Widget _buildFixedGroupHeader(T element) {
    if (widget.groupStickyHeaderBuilder == null) {
      return _buildGroupSeparator(element);
    }
    return widget.groupStickyHeaderBuilder!(element);
  }

  bool _isListItemRendered(GlobalKey<State<StatefulWidget>> key) {
    return key.currentContext != null &&
        key.currentContext!.findRenderObject() != null;
  }
}

enum GroupedListOrder { ASC, DESC }
