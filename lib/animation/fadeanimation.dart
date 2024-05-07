import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

enum AniProps { opacity, translateY }

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  FadeAnimation({required this.delay, required this.child});

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<AniProps>()
      ..add(AniProps.opacity, 0.0.tweenTo(1.0), 700.milliseconds)
      ..add(AniProps.translateY, (50.0).tweenTo(0.0), 700.milliseconds,
          Curves.easeOut)
      ..add(AniProps.translateY, (0.0).tweenTo(-10.0), 200.milliseconds,
          Curves.easeIn)
      ..add(AniProps.translateY, (-10.0).tweenTo(0.0), 200.milliseconds,
          Curves.easeOut);

    return PlayAnimation<MultiTweenValues<AniProps>>(
      delay: Duration(milliseconds: (700 * delay).round()),
      duration: tween.duration,
      tween: tween,
      builder: (context, child, value) {
        final opacityValue = value.get<double>(AniProps.opacity);
        final translateYValue = value.get<double>(AniProps.translateY);

        return Opacity(
          opacity: opacityValue,
          child: Transform.translate(
            offset: Offset(0, translateYValue),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
