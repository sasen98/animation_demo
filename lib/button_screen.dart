import 'package:flutter/material.dart';

class ButtonScreen extends StatelessWidget {
  const ButtonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: AnimatedButton(),
      ),
    );
  }
}

class AnimatedButton extends StatefulWidget {
  const AnimatedButton({super.key});

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  double _width = 300;
  double _height = 80;
  bool isLoading = false;
  Color _color = Colors.blue;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isLoading = !isLoading;
          _width = isLoading ? 50 : 300;
          _height = isLoading ? 45 : 80;

          _color = isLoading ? Colors.blue.withOpacity(0.4) : Colors.blue;
        });
      },
      child: AnimatedContainer(
        alignment: Alignment.center,
        width: _width,
        height: _height,
        decoration: BoxDecoration(
          color: _color,
        ),
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
        child: isLoading
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : const Text(
                'Login',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
