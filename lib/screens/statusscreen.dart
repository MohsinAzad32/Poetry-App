import 'dart:io';
import 'dart:math';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
// import 'package:poetry_app/widgets/status.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({super.key});

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  final random = Random();
  Color color = Colors.blue;
  bool isbold = false;
  final controller = TextEditingController();
  bool isvisible = true;

  FontWeight weight = FontWeight.normal;
  XFile? image;
  final ScreenshotController screenshotController = ScreenshotController();
  // Assume this is your image file.

  final family = [
    'exo2',
    'exo2_italic',
    'Lato-Black',
    'Lato-BlackItalic ',
    'Lato-Bold',
    'Lato-BoldItalic ',
    'Lato-Italic',
  ];

  int index = 0;

  changecolor() {
    setState(() {
      color = Color.fromARGB(random.nextInt(255), random.nextInt(255),
          random.nextInt(255), random.nextInt(255));
    });
  }

  changefamily() {
    setState(() {
      index = (index + 1) % family.length;
    });
  }

  Future<void> _saveImageWithText() async {
    final imageFile = await screenshotController.capture();
    if (imageFile != null) {
      final directory = (await getApplicationDocumentsDirectory()).path;
      final result =
          await File('$directory/screenshot.png').writeAsBytes(imageFile);
      final response = await GallerySaver.saveImage(result.path);
      if (response!) {
        try {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Status saved to gallery'),
            ),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString()),
            ),
          );
        }
      }
    }
  }

  Future pickImagefromgallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = XFile(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImagefromcamera() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.camera,
      );
      if (image == null) return;
      final imageTemp = XFile(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  final poetrycontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: buildimagebutton,
            icon: const Icon(
              Icons.camera_alt,
              size: 30,
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Container(
        color: color,
        height: MediaQuery.of(context).size.height * 0.9,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Screenshot(
            controller: screenshotController,
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (image != null)
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(
                        File(
                          image!.path,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                else
                  Center(
                    child: Container(),
                  ),
                isvisible
                    ? TextField(
                        controller: controller,
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus!.unfocus();
                          setState(() {
                            isvisible = !isvisible;
                          });
                        },
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 3),
                        )),
                      )
                    : InkWell(
                        onTap: () {
                          setState(() {
                            isvisible = true;
                          });
                        },
                        child: Text(
                          controller.text,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: weight,
                            fontFamily: family[index],
                          ),
                        )),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    Theme.of(context).colorScheme.primaryFixedDim,
                  ),
                ),
                onPressed: changefamily,
                icon: const Icon(
                  Icons.text_format,
                  size: 30,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    Theme.of(context).colorScheme.primaryFixedDim,
                  ),
                ),
                onPressed: changecolor,
                icon: const Icon(
                  Icons.color_lens,
                  size: 30,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    Theme.of(context).colorScheme.primaryFixedDim,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    isbold = !isbold;
                    isbold ? weight = FontWeight.bold : weight;
                  });
                },
                icon: const Icon(
                  Icons.format_bold,
                  size: 30,
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    Theme.of(context).colorScheme.primaryFixedDim,
                  ),
                ),
                onPressed: _saveImageWithText,
                icon: const Icon(
                  Icons.check,
                  size: 35,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> downloadImage(File image) async {
    final directory = await getApplicationDocumentsDirectory();
    final fileName = path.basename(image.path);
    final savedImage = await image.copy('${directory.path}/$fileName');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Image downloaded to: ${savedImage.path}')),
    );
  }

  buildimagebutton() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.primary,
          content: SizedBox(
            height: 200, // Set the desired height here
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: pickImagefromcamera,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.camera_alt,
                            size: 50,
                            color: Colors.white, // Adjust size if needed
                          ),
                          Text(
                            'Camera',
                            style: TextStyle(
                              fontFamily: 'DancingScript',
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: pickImagefromgallery,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.image,
                            size: 50,
                            color: Colors.white, // Adjust size if needed
                          ),
                          Text(
                            'Gallery',
                            style: TextStyle(
                              fontFamily: 'DancingScript',
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
