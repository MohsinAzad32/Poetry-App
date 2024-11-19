import 'package:flutter/material.dart';

class PoetWidget extends StatefulWidget {
  final String poetnameinEnglish;
  final String poetimage;
  final String poetnameinUrdu;
  const PoetWidget(
      {super.key,
      required this.poetimage,
      required this.poetnameinUrdu,
      required this.poetnameinEnglish});

  @override
  State<PoetWidget> createState() => _PoetWidgetState();
}

class _PoetWidgetState extends State<PoetWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController animationcontroller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationcontroller = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 3,
      ),
    );

    animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: animationcontroller, curve: Curves.decelerate));
    animationcontroller.forward();
  }

  @override
  void dispose() {
    animationcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.onPrimary,
      child: Stack(
        children: [
          Positioned(
            top: -50,
            right: -20,
            child: Align(
              alignment: Alignment.topRight,
              child: AnimatedBuilder(
                animation: animation,
                builder: (context, child) {
                  return SizeTransition(
                    sizeFactor: animation,
                    child: child,
                  );
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width * 0.15,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        width: 6),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -140,
            left: -40,
            child: AnimatedBuilder(
              animation: animation,
              builder: (context, child) {
                return SizeTransition(
                  sizeFactor: animation,
                  child: child,
                );
              },
              child: Container(
                alignment: Alignment.bottomLeft,
                height: MediaQuery.of(context).size.height * 0.30,
                width: MediaQuery.of(context).size.width * 0.30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      width: 6),
                ),
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 25.0, left: 8.0, right: 8.0, bottom: 10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Hero(
                    tag: widget.poetnameinEnglish,
                    child: Image.asset(
                      widget.poetimage,
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    widget.poetnameinEnglish,
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'DancingScript',
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    widget.poetnameinUrdu,
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'DancingScript',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
