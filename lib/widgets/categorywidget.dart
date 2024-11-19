import 'package:flutter/material.dart';
// import 'package:poetry_app/model/categories.dart';
// import 'package:poetry_app/model/category.dart';
// import 'package:poetry_app/model/poetry.dart';
// import 'package:poetry_app/screens/poetryscreen.dart';

class Categorywidget extends StatefulWidget {
  final String titleurdu;
  final String titleenglish;
  final String image;
  const Categorywidget({
    super.key,
    required this.titleenglish,
    required this.titleurdu,
    required this.image,
  });

  @override
  State<Categorywidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<Categorywidget>
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        color: Theme.of(context).colorScheme.onPrimary,
        child: Stack(
          children: [
            Positioned(
              top: -35,
              right: -15,
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
                    height: MediaQuery.of(context).size.height * 0.10,
                    width: MediaQuery.of(context).size.width * 0.10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        width: 6,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -90,
              left: -30,
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
                  height: MediaQuery.of(context).size.height * 0.20,
                  width: MediaQuery.of(context).size.width * 0.20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        width: 6),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
              child: Row(
                children: [
                  Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(widget.titleenglish),
                      )),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.titleurdu,
                      style: const TextStyle(
                          letterSpacing: 4.0,
                          fontSize: 30,
                          fontFamily: 'DancingScript',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          widget.image,
                          width: MediaQuery.of(context).size.width * 0.30,
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
