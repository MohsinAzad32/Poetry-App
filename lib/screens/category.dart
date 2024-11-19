import 'package:flutter/material.dart';
import 'package:poetry_app/model/categories.dart';
import 'package:poetry_app/model/category.dart';
import 'package:poetry_app/screens/poetryscreen.dart';
import 'package:poetry_app/widgets/categorywidget.dart';

class CategoryScreen extends StatefulWidget {
  final ScrollController controller;
  const CategoryScreen({
    super.key,
    required this.controller,
  });

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final items = Category.categories;
  List poetry = [
    Categories.zindagi,
    Categories.ansu,
    Categories.dard,
    Categories.dua,
    Categories.dosti,
    Categories.eid,
    Categories.eyes,
    Categories.dil,
    Categories.bewafa,
    Categories.funny,
    Categories.barish,
    Categories.gham,
    Categories.qismat,
    Categories.mosam,
    Categories.mekhana,
    Categories.romantic,
    Categories.tanhai,
    Categories.intizar,
    Categories.wish,
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: widget.controller,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return FadeTransition(
                  opacity: animation,
                  child: PoetryScreen(
                    image: items[index].imageurl,
                    poetry: poetry[index],
                    title: items[index].titleurdu,
                  ),
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
          child: Categorywidget(
            titleenglish: items[index].titleenglish,
            titleurdu: items[index].titleurdu,
            image: items[index].imageurl,
          ),
        );
      },
      itemCount: items.length,
    );
  }
}
