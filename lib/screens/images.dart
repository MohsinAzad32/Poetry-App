import 'package:flutter/material.dart';
import 'package:poetry_app/model/images.dart';
import 'package:poetry_app/widgets/imagewidget.dart';

class ImagesScreen extends StatefulWidget {
  final ScrollController controller;
  const ImagesScreen({super.key, required this.controller});

  @override
  State<ImagesScreen> createState() => _ImagesScreenState();
}

class _ImagesScreenState extends State<ImagesScreen> {
  final images = Images.images;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 20) / 1.9;
    final double itemWidth = size.width / 2;
    return GridView.builder(
        controller: widget.controller,
        itemCount: images.length,
        padding: const EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: (itemWidth / itemHeight),
        ),
        itemBuilder: (context, index) {
          return ImageWidget(
            image: images[index],
          );
        });
  }
}
