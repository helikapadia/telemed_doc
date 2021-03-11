import 'package:flutter/material.dart';

class ModalProgressBar extends StatelessWidget {
  const ModalProgressBar({
    @required this.inAsyncCall,
    @required this.child,
    Key key,
    this.opacity = 0.3,
    this.color = Colors.grey,
    this.progressIndicator = const CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan),
    ),
    this.offset,
    this.dismissible = false,
  })  : assert(inAsyncCall != null, "Call must not be null"),
        assert(child != null, "Child Widget must not be null"),
        super(key: key);

  final bool inAsyncCall;
  final double opacity;
  final Color color;
  final Widget progressIndicator;
  final Offset offset;
  final bool dismissible;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (!inAsyncCall) {
      return child;
    }

    Widget layOutProgressIndicator;
    if (offset == null) {
      layOutProgressIndicator = Center(child: progressIndicator);
    } else {
      layOutProgressIndicator = Positioned(
        left: offset.dx,
        top: offset.dy,
        child: progressIndicator,
      );
    }

    return Stack(
      children: [
        child,
        Opacity(
          opacity: opacity,
          child: ModalBarrier(dismissible: dismissible, color: color),
        ),
        layOutProgressIndicator,
      ],
    );
  }
}
