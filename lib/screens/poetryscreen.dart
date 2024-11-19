import 'package:flutter/material.dart';
import 'package:poetry_app/model/poetry.dart';
import 'package:poetry_app/widgets/poetrycard.dart';

class PoetryScreen extends StatefulWidget {
  final List<Poetry> poetry;
  final String image;
  final String title;
  const PoetryScreen({
    super.key,
    required this.image,
    required this.poetry,
    required this.title,
  });

  @override
  State<PoetryScreen> createState() => _PoetryScreenState();
}

class _PoetryScreenState extends State<PoetryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title: Text(
          widget.title,
          style: const TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'DancingScript'),
        ),
        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Hero(
                tag: widget.title,
                child: Image.asset(
                  widget.image,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: widget.poetry.length,
                  itemBuilder: (context, index) {
                    return CardWidget(
                        englishlines: widget.poetry[index].english,
                        urdulines: widget.poetry[index].urdu,
                        category: widget.poetry[index].category);
                  }))
        ],
      ),
    );
  }
}
