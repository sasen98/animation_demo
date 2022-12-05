import 'package:flutter/material.dart';

class HomeTwo extends StatelessWidget {
  const HomeTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Container(
        height: 110,
        width: 110,
        //padding: const EdgeInsets.all(10),
        decoration:
            BoxDecoration(border: Border.all(color: Colors.blue, width: 5)),
        child: BuildRIpples(
          child: Container(
            color: Colors.blue,
            height: 83,
            width: 83,
          ),
        ),
      )),
    );
  }
}

class BuildRIpples extends StatefulWidget {
  const BuildRIpples({super.key, required this.child});

  final Widget child;

  @override
  State<BuildRIpples> createState() => _BuildRIpplesState();
}

class _BuildRIpplesState extends State<BuildRIpples>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      lowerBound: 0.5,
      duration: const Duration(seconds: 3),
    )..repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation:
          CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn),
      builder: (context, _) {
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            BuildContainer(
              height: (150.0 * controller.value),
              width: (150.0 * controller.value),
              controller: controller,
            ),
            BuildContainer(
              height: (200.0 * controller.value),
              width: (200.0 * controller.value),
              controller: controller,
            ),
            BuildContainer(
              height: (250.0 * controller.value),
              width: (250.0 * controller.value),
              controller: controller,
            ),
            Align(child: widget.child),
          ],
        );
      },
    );
  }
}

class BuildContainer extends StatelessWidget {
  const BuildContainer(
      {super.key,
      required this.height,
      required this.width,
      required this.controller});
  final double height;
  final double width;
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: height,
      height: width,
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(1 - controller.value),
      ),
    );
  }
}
