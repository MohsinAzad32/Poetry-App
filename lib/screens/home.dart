import 'package:flutter/material.dart';
// import 'package:poetry_app/model/poetry.dart';
import 'package:poetry_app/widgets/poetrycard.dart';

class HomeScreen extends StatelessWidget {
  final ScrollController controller;
  final List poetry;
  const HomeScreen({super.key, required this.controller, required this.poetry});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller,
      itemCount: poetry.length,
      itemBuilder: (context, index) {
        return CardWidget(
          englishlines: poetry[index].english,
          urdulines: poetry[index].urdu,
          category: poetry[index].category,
        );
      },
    );
  }
}
