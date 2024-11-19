// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'dart:convert';
import 'dart:typed_data';
// import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
// import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:gal/gal.dart';
import 'package:share_plus/share_plus.dart';

class ImageWidget extends StatefulWidget {
  final String image;
  const ImageWidget({super.key, required this.image});

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    animation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: controller, curve: Curves.ease));
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
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
                        width: 6),
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedBuilder(
                  animation: animation,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      widget.image,
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height * 0.35,
                      width: MediaQuery.of(context).size.width * 0.5,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 0,
                    top: 5,
                    bottom: 5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            Theme.of(context).colorScheme.primaryContainer,
                          ),
                        ),
                        onPressed: () async {
                          String imageUrl = widget.image;

                          // Step 1: Download the image
                          final tempDir = await getTemporaryDirectory();
                          final filePath = '${tempDir.path}/my_image.jpg';

                          try {
                            await Dio().download(imageUrl, filePath);

                            // Step 2: Share the downloaded file
                            await Share.shareXFiles([XFile(filePath)],
                                text: 'Check out this image!');
                          } catch (e) {
                            // Handle any errors during the download or share
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.red,
                                content: Text('Error sharing the image!'),
                              ),
                            );
                            print(e);
                          }
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
                          String url = widget.image;
                          final tempdir = await getTemporaryDirectory();
                          final path = '${tempdir.path}/myfile.jpg';
                          await Dio().download(url, path);
                          final check = await GallerySaver.saveImage(path,
                              albumName: 'Flutter');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                              animation: animation,
                              duration: const Duration(seconds: 1),
                              content: const Text(
                                'saved to Gallery',
                              ),
                            ),
                          );
                          print(check);
                        },
                        icon: const Icon(
                          Icons.download,
                          // color: Theme.of(context)
                          //     .colorScheme
                          //     .onPrimaryFixedVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future savePhoto(String imageUrl) async {
    var response = await Dio()
        .get(imageUrl, options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(
      Uint8List.fromList(response.data),
    );
    print(result);
  }
}
