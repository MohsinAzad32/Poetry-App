// import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poetry_app/screens/statusscreen.dart';
import 'package:share_plus/share_plus.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:flutter_share/flutter_share.dart';
// import 'package:share_plus/share_plus.dart';

class CardWidget extends StatefulWidget {
  final String urdulines;
  final String englishlines;
  final String category;
  const CardWidget({
    super.key,
    required this.englishlines,
    required this.urdulines,
    required this.category,
  });

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController animationcontroller;
  late Animation<double> animation;
  bool iscopied = false;

  @override
  void initState() {
    super.initState();
    animationcontroller = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 2,
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
      child: Container(
        height: MediaQuery.of(context).size.height * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        child: Stack(
          children: [
            Positioned(
              right: -10,
              top: -70,
              child: Align(
                alignment: Alignment.topRight,
                child: AnimatedBuilder(
                  animation: animation,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.15,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          width: 6),
                    ),
                  ),
                  builder: (context, child) {
                    return SizeTransition(
                      sizeFactor: animation,
                      child: child,
                    );
                  },
                ),
              ),
            ),
            Positioned(
              left: -30,
              bottom: -120,
              child: Align(
                alignment: Alignment.topRight,
                child: AnimatedBuilder(
                  animation: animation,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.30,
                    width: MediaQuery.of(context).size.width * 0.30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          width: 6),
                    ),
                  ),
                  builder: (context, child) {
                    return SizeTransition(
                      sizeFactor: animation,
                      child: child,
                    );
                  },
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(
                    5.0,
                  ),
                  child: Card(
                    color: Theme.of(context).colorScheme.primaryFixed,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        30,
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(
                            8.0,
                          ),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              widget.englishlines,
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'DancingScript',
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryFixedVariant,
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(
                            8.0,
                          ),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              widget.urdulines,
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'DancingScript',
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryFixedVariant,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        widget.category,
                        style: const TextStyle(
                          fontSize: 20,
                          fontFamily: 'DancingScript',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            Theme.of(context).colorScheme.primaryContainer,
                          ),
                        ),
                        onPressed: () async {
                          await Share.share(widget.urdulines);
                        },
                        icon: const Icon(
                          Icons.share,
                        ),
                      ),
                      IconButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            Theme.of(context).colorScheme.primaryContainer,
                          ),
                        ),
                        onPressed: () async {
                          final dta = ClipboardData(text: widget.urdulines);
                          await Clipboard.setData(dta);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              animation: animation,
                              duration: const Duration(seconds: 1),
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                              content: const Text('Text Copied To ClipBoard'),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.copy_rounded,
                        ),
                      ),
                      IconButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            Theme.of(context).colorScheme.primaryContainer,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) {
                              return FadeTransition(
                                opacity: animation,
                                child: const StatusScreen(),
                              );
                            },
                            transitionDuration: const Duration(seconds: 1),
                            reverseTransitionDuration:
                                const Duration(seconds: 1),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                          ));
                        },
                        icon: const Icon(
                          Icons.edit,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
