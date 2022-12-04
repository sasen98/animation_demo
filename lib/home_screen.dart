import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            RippleAnimationWidget(
              isLive: true,
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.red, width: 5)),
              ),
            ),
            ZoomInOutAnimationWidget(
              isLive: true,
              child: Container(
                color: Colors.blue,
                height: 100,
                width: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ZoomInOutAnimationWidget extends StatefulWidget {
  const ZoomInOutAnimationWidget(
      {super.key, required this.isLive, required this.child});
  final bool isLive;
  final Widget child;

  @override
  State<ZoomInOutAnimationWidget> createState() =>
      _ZoomInOutAnimationWidgetState();
}

class _ZoomInOutAnimationWidgetState extends State<ZoomInOutAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Tween<double> _tween = Tween(begin: 1, end: 1.9);
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 700), vsync: this);
    _controller.repeat(reverse: false);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isLive
        ? ScaleTransition(
            scale: _tween.animate(
                CurvedAnimation(parent: _controller, curve: Curves.easeInOut)),
            child: widget.child)
        : widget.child;
  }
}

class RippleAnimationWidget extends StatefulWidget {
  const RippleAnimationWidget(
      {super.key, required this.child, required this.isLive});
  final Widget child;
  final bool isLive;

  @override
  State<RippleAnimationWidget> createState() => _RippleAnimationWidgetState();
}

class _RippleAnimationWidgetState extends State<RippleAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 900), vsync: this);
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isLive
        ? Stack(
            alignment: Alignment.center,
            children: [
              ScaleTransition(
                scale: TweenSequence<double>(
                  <TweenSequenceItem<double>>[
                    TweenSequenceItem<double>(
                      tween: Tween<double>(begin: 1, end: 1.2)
                          .chain(CurveTween(curve: Curves.easeInOut)),
                      weight: 50.0,
                    ),
                    TweenSequenceItem<double>(
                      tween: Tween<double>(begin: 0, end: 0)
                          .chain(CurveTween(curve: Curves.easeInOut)),
                      weight: 50.0,
                    ),
                  ],
                ).animate(_controller),
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.red, width: 5)),
                ),
              ),
              widget.child
            ],
          )
        : widget.child;
  }
}
