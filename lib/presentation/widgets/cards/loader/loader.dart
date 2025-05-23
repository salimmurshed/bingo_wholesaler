import '/const/all_const.dart';
import 'package:flutter/material.dart';
import 'draw_dot.dart';
import 'dart:math' as math;

class LoaderWidget extends StatefulWidget {
  const LoaderWidget({
    this.color = AppColors.whiteColor,
    Key? key,
  }) : super(key: key);
  final Color color;
  @override
  _FourRotatingDotsState createState() => _FourRotatingDotsState();
}

class _FourRotatingDotsState extends State<LoaderWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 2200,
      ),
    )..repeat();
  }

  Widget _rotatingDots({
    required bool visible,
    required List<Color> colors,
    required double dotSize,
    required double offset,
    required double initialAngle,
    required double finalAngle,
    required Interval interval,
  }) {
    final double angle = Tween<double>(
      begin: initialAngle,
      end: finalAngle,
    )
        .animate(
          CurvedAnimation(
            parent: _animationController,
            curve: interval,
          ),
        )
        .value;
    return Visibility(
      visible: visible,
      child: Transform.rotate(
        angle: angle,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Transform.translate(
              offset: Offset(-offset, 0),
              child: DrawDot.circular(
                dotSize: dotSize,
                color: colors[0],
              ),
            ),
            Transform.translate(
              offset: Offset(offset, 0),
              child: DrawDot.circular(
                dotSize: dotSize,
                color: colors[1],
              ),
            ),
            Transform.translate(
              offset: Offset(0, -offset),
              child: DrawDot.circular(
                dotSize: dotSize,
                color: colors[2],
              ),
            ),
            Transform.translate(
              offset: Offset(0, offset),
              child: DrawDot.circular(
                dotSize: dotSize,
                color: colors[3],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _animatingDots({
    required bool fixedSize,
    required List<Color> colors,
    required double dotInitialSize,
    required double initialOffset,
    required double finalOffset,
    required Interval interval,
    double? dotFinalSize,
    required bool visible,
  }) {
    final CurvedAnimation curvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: interval,
    );

    final double dotSize = fixedSize
        ? dotInitialSize
        : Tween<double>(begin: dotInitialSize, end: dotFinalSize)
            .animate(
              CurvedAnimation(
                parent: _animationController,
                curve: interval,
              ),
            )
            .value;
    return Visibility(
      visible: visible,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Transform.translate(
            offset: Tween<Offset>(
              begin: Offset(-initialOffset, 0),
              end: Offset(-finalOffset, 0),
            ).animate(curvedAnimation).value,
            child: DrawDot.circular(
              dotSize: dotSize,
              color: colors[0],
            ),
          ),
          Transform.translate(
            offset: Tween<Offset>(
              begin: Offset(initialOffset, 0),
              end: Offset(finalOffset, 0),
            ).animate(curvedAnimation).value,
            child: DrawDot.circular(
              dotSize: dotSize,
              color: colors[1],
            ),
          ),
          Transform.translate(
            offset: Tween<Offset>(
              begin: Offset(0, -initialOffset),
              end: Offset(0, -finalOffset),
            ).animate(curvedAnimation).value,
            child: DrawDot.circular(
              dotSize: dotSize,
              color: colors[2],
            ),
          ),
          Transform.translate(
            offset: Tween<Offset>(
              begin: Offset(0, initialOffset),
              end: Offset(0, finalOffset),
            ).animate(curvedAnimation).value,
            child: DrawDot.circular(
              dotSize: dotSize,
              color: colors[3],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double size = 50.0.wp;
    final List<Color> colors = [
      AppColors.loader1,
      AppColors.loader2,
      AppColors.loader3,
      AppColors.loader4,
    ];
    final double dotMaxSize = size * 0.40;
    final double dotMinSize = size * 0.14;
    final double maxOffset = size * 0.35;

    return Container(
      color: widget.color,
      width: 100.0.wp,
      height: 100.0.hp,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (_, __) {
          return Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Transform.rotate(
                angle: Tween<double>(
                  begin: 0.0,
                  end: math.pi / 8,
                )
                    .animate(
                      CurvedAnimation(
                        parent: _animationController,
                        curve: const Interval(
                          0.0,
                          0.18,
                          // curve: Curves.easeInCubic,
                        ),
                      ),
                    )
                    .value,
                child: _animatingDots(
                  visible: _animationController.value <= 0.18,
                  fixedSize: true,
                  colors: colors,
                  dotInitialSize: dotMaxSize,
                  initialOffset: maxOffset,
                  finalOffset: 0,
                  interval: const Interval(
                    0.0,
                    0.18,
                    curve: Curves.easeInQuart,
                  ),
                ),
              ),
              Transform.rotate(
                angle: Tween<double>(
                  begin: math.pi / 8,
                  end: math.pi / 4,
                )
                    .animate(
                      CurvedAnimation(
                        parent: _animationController,
                        curve: const Interval(
                          0.18,
                          0.36,
                          // curve: Curves.easeOutCubic,
                        ),
                      ),
                    )
                    .value,
                child: _animatingDots(
                  visible: _animationController.value >= 0.18 &&
                      _animationController.value <= 0.36,
                  fixedSize: false,
                  colors: colors,
                  dotInitialSize: dotMaxSize,
                  dotFinalSize: dotMinSize,
                  initialOffset: 0,
                  finalOffset: maxOffset,
                  interval: const Interval(
                    0.18,
                    0.36,
                    curve: Curves.easeOutQuart,
                  ),
                ),
              ),
              _rotatingDots(
                visible: _animationController.value >= 0.36 &&
                    _animationController.value <= 0.60,
                colors: colors,
                dotSize: dotMinSize,
                initialAngle: math.pi / 4,
                finalAngle: 7 * math.pi / 4,
                interval: const Interval(
                  0.36,
                  0.60,
                  curve: Curves.easeInOutSine,
                ),
                offset: maxOffset,
              ),
              Transform.rotate(
                angle: Tween<double>(
                  begin: 7 * math.pi / 4,
                  end: 2 * math.pi,
                )
                    .animate(
                      CurvedAnimation(
                        parent: _animationController,
                        curve: const Interval(
                          0.6,
                          0.78,
                        ),
                      ),
                    )
                    .value,
                child: _animatingDots(
                  visible: _animationController.value >= 0.60 &&
                      _animationController.value <= 0.78,
                  fixedSize: false,
                  colors: colors,
                  dotInitialSize: dotMinSize,
                  dotFinalSize: dotMaxSize,
                  initialOffset: maxOffset,
                  finalOffset: 0,
                  interval: const Interval(
                    0.60,
                    0.78,
                    curve: Curves.easeInQuart,
                  ),
                ),
              ),
              _animatingDots(
                visible: _animationController.value >= 0.78 &&
                    _animationController.value <= 1.0,
                fixedSize: true,
                colors: colors,
                dotInitialSize: dotMaxSize,
                initialOffset: 0,
                finalOffset: maxOffset,
                interval: const Interval(
                  0.78,
                  0.96,
                  curve: Curves.easeOutQuart,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
