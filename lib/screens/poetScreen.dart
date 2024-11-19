import 'package:flutter/material.dart';
import 'package:poetry_app/model/poet.dart';
import 'package:poetry_app/model/poets.dart';
import 'package:poetry_app/screens/poetryscreen.dart';
import 'package:poetry_app/widgets/poetwidget.dart';

class PoetScreen extends StatefulWidget {
  final ScrollController controller;
  const PoetScreen({super.key, required this.controller});

  @override
  State<PoetScreen> createState() => _PoetScreenState();
}

class _PoetScreenState extends State<PoetScreen> {
  final poets = Poet.poets;
  List poetry = [
    Poets.faraz,
    Poets.parveen,
    Poets.john,
    Poets.haafi,
    Poets.ali,
    Poets.wasi,
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: widget.controller,
      itemCount: poets.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return FadeTransition(
                  opacity: animation,
                  child: PoetryScreen(
                    image: poets[index].imageurl,
                    poetry: poetry[index],
                    title: poets[index].poetname,
                  ),
                );
              },
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              transitionDuration: const Duration(seconds: 1),
              reverseTransitionDuration: const Duration(seconds: 1),
            ));
          },
          child: PoetWidget(
              poetimage: poets[index].imageurl,
              poetnameinUrdu: poets[index].urdu,
              poetnameinEnglish: poets[index].poetname),
        );
      },
    );
  }
}
