// import 'dart:js_interop';

// import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:poetry_app/model/poet.dart';
import 'package:poetry_app/model/poetry.dart';
import 'package:poetry_app/providers/themeprovider.dart';
import 'package:poetry_app/screens/category.dart';
// import 'package:flutter/widgets.dart';
import 'package:poetry_app/screens/home.dart';
import 'package:poetry_app/screens/images.dart';
import 'package:poetry_app/screens/poetScreen.dart';
import 'package:poetry_app/screens/searchscreen.dart';
import 'package:poetry_app/screens/statusscreen.dart';
import 'package:poetry_app/screens/videocreen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late ScrollController bottomcontroller;
  bool isvisible = true;
  bool isdarktheme = false;

  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bottomcontroller = ScrollController();
    bottomcontroller.addListener(() {
      if (bottomcontroller.position.userScrollDirection !=
          ScrollDirection.reverse) {
        setState(() {
          isvisible = true;
        });
      }
      if (bottomcontroller.position.userScrollDirection !=
          ScrollDirection.forward) {
        setState(() {
          isvisible = false;
        });
      }
    });

    if (isvisible) {
      controller = AnimationController(
        vsync: this,
        duration: const Duration(
          seconds: 2,
        ),
      );
      animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: controller,
          curve: Curves.ease,
        ),
      );

      controller.forward();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    bottomcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Provider.of<Themeprovider>(context).currentTheme,
      home: Scaffold(
        extendBody: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
          title: const Text(
            'Just Poetry',
            style: TextStyle(
                fontFamily: 'DancingScript',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          centerTitle: true,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: Visibility(
          visible: isvisible,
          child: AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return ScaleTransition(
                scale: animation,
                child: child,
              );
            },
            child: FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return FadeTransition(
                        opacity: animation,
                        child: const StatusScreen(),
                      );
                    },
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                    transitionDuration: const Duration(
                      seconds: 1,
                    ),
                    reverseTransitionDuration: const Duration(
                      seconds: 1,
                    ),
                  ),
                );
              },
              child: Icon(
                Icons.add,
                color: Theme.of(context).colorScheme.onPrimaryFixed,
              ),
            ),
          ),
        ),
        bottomNavigationBar: Visibility(
          visible: isvisible,
          child: AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return ScaleTransition(
                scale: animation,
                child: child,
              );
            },
            child: BottomAppBar(
              shape: const CircularNotchedRectangle(),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: MediaQuery.of(context).size.height * 0.06,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              notchMargin: 5,
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 32,
                    ),
                    onPressed: openbottomsheet,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 32,
                    ),
                    onPressed: () {
                      final poets = Poet.poets;
                      showSearch(
                        context: context,
                        delegate: Mydelegate(
                          data: poets,
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.facebook,
                      color: Colors.white,
                      size: 32,
                    ),
                    onPressed: () async {
                      String url = 'https://m.facebook.com/MaaNsjustpoetry/';
                      await launchUrl(Uri.parse(url));
                    },
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.video_collection_rounded,
                      color: Colors.white,
                      size: 32,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return FadeTransition(
                            opacity: animation,
                            child: const VideoScreen(),
                          );
                        },
                        transitionDuration: const Duration(seconds: 1),
                        reverseTransitionDuration: const Duration(seconds: 1),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                      ));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        body: DefaultTabController(
          length: 4,
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(5),
                constraints: const BoxConstraints(maxHeight: 150.0),
                decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(20.0)),
                ),
                child: const Material(
                  child: TabBar(
                    tabs: [
                      Tab(
                        child: Text(
                          'Poetry',
                          style: TextStyle(
                              fontFamily: 'DancingScript',
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Images',
                          style: TextStyle(
                              fontFamily: 'DancingScript',
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Category',
                          style: TextStyle(
                              fontFamily: 'DancingScript',
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Poets',
                          style: TextStyle(
                              fontFamily: 'DancingScript',
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    HomeScreen(
                      controller: bottomcontroller,
                      poetry: Poetry.poetry,
                    ),
                    ImagesScreen(
                      controller: bottomcontroller,
                    ),
                    CategoryScreen(
                      controller: bottomcontroller,
                    ),
                    PoetScreen(
                      controller: bottomcontroller,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  openbottomsheet() {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return BottomSheet(
            onClosing: () {},
            builder: (context) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -10,
                      bottom: -50,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: AnimatedBuilder(
                          animation: animation,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.15,
                            width: MediaQuery.of(context).size.width * 0.15,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
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
                      right: -40,
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
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Options',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Times New Roman',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        TextButton.icon(
                          icon: const Icon(
                            Icons.color_lens_rounded,
                            size: 25,
                          ),
                          onPressed: alertoption,
                          label: const Text(
                            'Dark Mode / Light Mode',
                            style: TextStyle(
                              fontFamily: 'DancingScript',
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 40.0, right: 100.0),
                          child: Divider(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            thickness: 2,
                          ),
                        ),
                        TextButton.icon(
                          icon: const Icon(
                            Icons.mail,
                            size: 25,
                          ),
                          onPressed: launchEmail,
                          label: const Text(
                            'Contact Us',
                            style: TextStyle(
                              fontFamily: 'DancingScript',
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 40.0, right: 100.0),
                          child: Divider(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            thickness: 2,
                          ),
                        ),
                        TextButton.icon(
                          icon: const Icon(
                            Icons.star_rounded,
                            size: 25,
                          ),
                          onPressed: rating,
                          label: const Text(
                            'Rate App',
                            style: TextStyle(
                                fontFamily: 'DancingScript', fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        });
  }

  rating() async {
    String url = 'https://play.google.com/store/apps/details?id=org.Rekhta';
    await launchUrl(
      Uri.parse(
        url,
      ),
    );
  }

  alertoption() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Theme'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
              onPressed: () {
                isdarktheme = !isdarktheme;
                final provider =
                    Provider.of<Themeprovider>(context, listen: false);
                isdarktheme
                    ? provider.setDarktheme()
                    : provider.setLighttheme();

                Navigator.pop(context);
              },
              child: Text(
                'OK',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ],
          content: isdarktheme
              ? const Text('Do you want to enable Light Mode ?')
              : const Text('Do you want to enable Dark Mode ?'),
        );
      },
    );
  }

  launchEmail() async {
    try {
      Uri email = Uri(
        scheme: 'mailto',
        path: "mk7174572@gmail.com",
        queryParameters: {'subject': "Testing subject"},
      );
      await launchUrl(email);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
