import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iot_app/constants/app_colors.dart';
import 'package:iot_app/constants/assets_path.dart';

class TbProgressIndicator extends ProgressIndicator {
  final double size;

  const TbProgressIndicator({
    Key? key,
    this.size = 36.0,
    Animation<Color?>? valueColor,
    String? semanticsLabel,
    String? semanticsValue,
  }) : super(
          key: key,
          value: null,
          valueColor: valueColor,
          semanticsLabel: semanticsLabel,
          semanticsValue: semanticsValue,
        );

  @override
  _TbProgressIndicatorState createState() => _TbProgressIndicatorState();

  Color _getValueColor(BuildContext context) =>
      valueColor?.value ?? AppColors.inversePrimaryDarkMode;
      // valueColor?.value ?? Colors.transparent;
      // valueColor?.value ?? Colors.red;
}

class _TbProgressIndicatorState extends State<TbProgressIndicator>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late CurvedAnimation _rotation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1500),
        vsync: this,
        upperBound: 1,
        animationBehavior: AnimationBehavior.preserve);
    _rotation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.repeat();
  }

  @override
  void didUpdateWidget(TbProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_controller.isAnimating) _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          left: 5,
          top: 5,
          right: 5,
          bottom: 10,
          child: SvgPicture.asset(
            ThingsboardImage.aquaCareCenter,
            height: widget.size,
            width: widget.size,
            // color: widget._getValueColor(context),
          ),
        ),
        AnimatedBuilder(
          animation: _rotation,
          child: SvgPicture.asset(ThingsboardImage.aquaCareOuter,
              height: widget.size + 20,
              width: widget.size + 20,
              color: widget._getValueColor(context)),
          builder: (BuildContext context, Widget? child) {
            return Transform.rotate(
                angle: _rotation.value * pi * 2, child: child);
          },
        )
      ],
    );
  }
}
