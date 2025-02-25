import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Animation type enum
enum FloatingAnimationType {
  /// Linear upward movement
  linear,

  /// Curved upward movement
  curve,

  /// Random upward movement
  random
}

class FloatingHeartsButton extends StatefulWidget {
  /// SVG resource path
  final String? svgPath;

  /// Custom Widget (takes priority over svgPath)
  final Widget? child;

  /// Button size
  final double size;

  /// Tap callback
  final VoidCallback onTap;

  /// Number of floating hearts
  final int floatingItemCount;

  /// Animation duration
  final Duration animationDuration;

  /// Delay time between animation elements
  final Duration itemDelay;

  /// Animation type
  final FloatingAnimationType animationType;

  /// Size ratio of animation elements (relative to main button size)
  final double floatingItemScale;

  /// Creates a floating hearts button
  ///
  /// You can provide [svgPath] or [child]. If both are provided, [child] will be used
  /// [size] controls the main button size
  /// [floatingItemCount] controls the number of floating elements
  /// [animationDuration] controls the duration of a single animation
  /// [itemDelay] controls the time interval between each floating element's animation start
  /// [animationType] controls the animation type
  /// [floatingItemScale] controls the size ratio of floating elements relative to the main button
  const FloatingHeartsButton({
    Key? key,
    this.svgPath,
    this.child,
    required this.onTap,
    this.size = 50,
    this.floatingItemCount = 3,
    this.animationDuration = const Duration(milliseconds: 1500),
    this.itemDelay = const Duration(milliseconds: 300),
    this.animationType = FloatingAnimationType.random,
    this.floatingItemScale = 0.6,
  })  : assert(svgPath != null || child != null,
            "Either svgPath or child must be provided"),
        super(key: key);

  @override
  FloatingHeartsButtonState createState() => FloatingHeartsButtonState();
}

class FloatingHeartsButtonState extends State<FloatingHeartsButton>
    with TickerProviderStateMixin {
  late List<AnimationController> controllers;
  late List<Animation<double>> animations;
  late List<Offset> positions;
  late List<bool> itemVisibility;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  @override
  void didUpdateWidget(FloatingHeartsButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    // If key animation parameters change, reinitialize animations
    if (oldWidget.floatingItemCount != widget.floatingItemCount ||
        oldWidget.animationDuration != widget.animationDuration) {
      // Clean up old controllers first
      for (var controller in controllers) {
        controller.dispose();
      }

      _initializeAnimations();
    }
  }

  void _initializeAnimations() {
    controllers = [];
    animations = [];
    positions = [];
    itemVisibility = List.filled(widget.floatingItemCount, false);

    for (int i = 0; i < widget.floatingItemCount; i++) {
      controllers.add(AnimationController(
        duration: widget.animationDuration,
        vsync: this,
      ));
      animations.add(Tween<double>(begin: 0, end: 1).animate(controllers[i]));
      positions.add(Offset.zero);
    }
  }

  Future<void> _handleTap() async {
    widget.onTap();
    _startAnimation();
  }

  void _startAnimation() {
    final random = math.Random();

    for (int i = 0; i < widget.floatingItemCount; i++) {
      // Use user-defined delay interval
      Future.delayed(widget.itemDelay * i, () {
        if (mounted) {
          setState(() {
            // Generate different offsets based on animation type
            switch (widget.animationType) {
              case FloatingAnimationType.linear:
                positions[i] = Offset(0, 0);
                break;
              case FloatingAnimationType.curve:
                positions[i] = Offset(i % 2 == 0 ? 20 : -20, 0);
                break;
              case FloatingAnimationType.random:
                positions[i] = Offset(random.nextDouble() * 40 - 20, 0);
                break;
            }
            itemVisibility[i] = true;
          });

          controllers[i].forward(from: 0).then((_) {
            if (mounted) {
              setState(() {
                itemVisibility[i] = false;
              });
              controllers[i].reset();
            }
          });
        }
      });
    }
  }

  Widget _buildMainButton() {
    if (widget.child != null) {
      return widget.child!;
    } else {
      return SvgPicture.asset(
        widget.svgPath!,
        height: widget.size,
        width: widget.size,
      );
    }
  }

  Widget _buildFloatingItem() {
    if (widget.child != null) {
      // If user provided a custom Widget, try to scale it
      return SizedBox(
        width: widget.size * widget.floatingItemScale,
        height: widget.size * widget.floatingItemScale,
        child: widget.child,
      );
    } else {
      return SvgPicture.asset(
        widget.svgPath!,
        width: widget.size * widget.floatingItemScale,
        height: widget.size * widget.floatingItemScale,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          _buildMainButton(),
          ...animations.asMap().entries.map((entry) {
            int idx = entry.key;
            return AnimatedBuilder(
              animation: entry.value,
              builder: (context, child) {
                if (!itemVisibility[idx]) return SizedBox.shrink();

                // Calculate animation trajectory
                double verticalOffset = widget.size * 4 * entry.value.value;
                double horizontalOffset =
                    positions[idx].dx * (1 - entry.value.value);

                return Positioned(
                  bottom: verticalOffset,
                  left: widget.size / 2 + horizontalOffset,
                  child: Opacity(
                    opacity: 1 - entry.value.value,
                    child: _buildFloatingItem(),
                  ),
                );
              },
            );
          }).toList(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
