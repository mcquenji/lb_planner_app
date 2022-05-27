part of lbplanner_widgets;

/// Progress indicator.
class LpLoadingIndicator extends StatelessWidget {
  /// Linear progress indicator.
  LpLoadingIndicator.linear({Key? key, this.progress, this.color, this.size, this.thickness, this.backgroundColor = Colors.transparent}) : super(key: key) {
    type = _LpProgressIndicatorTypes.linear;
    animation = null;
    center = false;
  }

  /// Circular progress indicator.
  // ignore: no-magic-number
  LpLoadingIndicator.circular({Key? key, this.progress, this.color, this.size = 15, this.thickness = 2, this.backgroundColor = Colors.transparent, this.center = true}) : super(key: key) {
    animation = null;
    type = _LpProgressIndicatorTypes.circular;
  }

  /// Circular progress indicator with logo in the middle.
  LpLoadingIndicator.rive({Key? key, this.size, this.animation}) : super(key: key) {
    type = _LpProgressIndicatorTypes.rive;
    backgroundColor = Colors.transparent;
    thickness = 0;
    color = null;
    progress = 0;
    center = false;
  }

  /// Progress indicator type.
  late final _LpProgressIndicatorTypes type;

  /// Progress of the progress indicator.
  late final double? progress;

  /// The size of the progress indicator.
  final double? size;

  /// The thickness of the progress indicator.
  late final double? thickness;

  /// Color of the progress indicator.
  late final Color? color;

  /// Background color of the progress indicator.
  late final Color backgroundColor;

  /// The animation to play when of type [LpLoadingIndicator.rive].
  late final RiveAnimation? animation;

  /// Whether to automatically center the progress indicator.
  late final bool center;

  @override
  Widget build(BuildContext context) {
    var color = this.color ?? accentColor;
    return ConditionalWrapper(
      condition: type.isRive || (type.isCircular && center),
      wrapper: (context, child) => Center(child: child),
      child: ConditionalWrapper(
        condition: size != null,
        wrapper: (context, child) => SizedBox(
          width: size,
          height: type.isLinear ? null : size,
          child: child,
        ),
        child: ConditionalWidget(
          condition: type.isLinear,
          trueWidget: (context) => LinearProgressIndicator(
            value: progress,
            backgroundColor: backgroundColor,
            color: color,
            minHeight: thickness,
          ),
          falseWidget: (context) => ConditionalWidget(
            condition: type.isCircular,
            trueWidget: (context) => CircularProgressIndicator(
              color: color,
              // ignore: no-magic-number
              strokeWidth: thickness ?? 4,
              value: progress,
              backgroundColor: backgroundColor,
            ),
            falseWidget: (context) {
              var animation = this.animation ?? (kLoadingAnimations.toList()..shuffle()).first;

              return UniversalActor.fromRiveAnimation(animation);
            },
          ),
        ),
      ),
    );
  }
}

enum _LpProgressIndicatorTypes {
  circular,
  linear,
  rive,
}

extension on _LpProgressIndicatorTypes {
  bool get isCircular => this == _LpProgressIndicatorTypes.circular;
  bool get isLinear => this == _LpProgressIndicatorTypes.linear;
  bool get isRive => this == _LpProgressIndicatorTypes.rive;
}
